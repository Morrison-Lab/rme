#!/usr/bin/env python3
# check-one-function-per-file: allow-multiple
"""Build the prerequisite graph of a notes site's definitions and results.

Parses every `#def-`, `#thm-`, `#lem-`, `#prp-` and `#cor-` div in
`<root>/<pages>/*.qmd` (`chapters` by default; following `{{< include >}}` subfiles) and records the
other such divs each one uses, through an `@id` cross-reference or a link to
`page.qmd#id` / `page.html#id` / a cross-site URL.  An edge A -> B means
"A uses B", so B is a prerequisite of A and A is a postrequisite of B.

Writes JSON (default `<root>/dependency-graph.json`) and prints cycles and
forward references (a div that uses one defined later on the same page).
Stdlib only, so it can run in any notes repo's pre-render step.

    python3 tools/build_dependency_graph.py [--root .] [--out FILE] [--site lds] [--fail]
"""
import argparse
import json
import re
import sys
from pathlib import Path

KINDS = ("def", "thm", "lem", "prp", "cor")
DIV_OPEN = re.compile(r"^(:{3,})\s*\{[^}]*#((?:%s)-[A-Za-z0-9_-]+)[^}]*\}\s*$" % "|".join(KINDS))
DIV_ANY = re.compile(r"^(:{3,})(?:\s*\{.*\}|\s*\S+)?\s*$")
INCLUDE = re.compile(r"\{\{<\s*include\s+(\S+?)\s*>\}\}")
AT_REF = re.compile(r"(?<![\w@/.])@((?:%s)-[A-Za-z0-9_-]+)" % "|".join(KINDS))
LINK = re.compile(r"\]\(\s*<?([^)\s>]*?)#((?:%s)-[A-Za-z0-9_-]+)>?[^)]*\)" % "|".join(KINDS))
URL_SITE = re.compile(r"https?://[^/]+/([^/]+)/([^/#?]+?)\.(?:html|qmd)$")
HEADING = re.compile(r"^#{2,6}\s+(.*?)\s*(?:\{.*\})?\s*$")


def expand(path, seen=()):
    """Yield (line, source_path) of a .qmd with includes expanded in place."""
    for line in path.read_text(encoding="utf-8").splitlines():
        m = INCLUDE.search(line)
        if m and not line.lstrip().startswith("<!--"):
            # Quarto resolves a nested include against the page, not the subfile.
            sub = (path.parent / m.group(1)).resolve()
            if not sub.exists():
                sub = (seen[0].parent / m.group(1)).resolve()
            if sub.exists() and sub not in seen:
                yield from expand(sub, seen + (sub,))
                continue
            if not sub.exists():
                print(f"warning: {path}: include target not found: {m.group(1)}", file=sys.stderr)
        yield line, path


def parse_page(qmd, site):
    """Return the ordered list of div records of one page."""
    page = qmd.stem
    divs, stack, cur = [], [], None
    in_code = False
    for line, src in expand(qmd, (qmd.resolve(),)):
        if line.lstrip().startswith("```"):
            in_code = not in_code
        if in_code:
            if cur is not None:
                cur["text"].append(line)
            continue
        m = DIV_OPEN.match(line)
        if m:
            cur = {"site": site, "page": page, "id": m.group(2), "title": "", "text": [],
                   "file": str(src), "depth": len(stack)}
            divs.append(cur)
            stack.append((len(m.group(1)), cur))
            continue
        m = DIV_ANY.match(line)
        if m:
            fence = len(m.group(1))
            if line.strip().strip(":") == "":  # closing fence
                for i in range(len(stack) - 1, -1, -1):
                    if stack[i][0] == fence:
                        del stack[i:]
                        break
            else:  # a nested, non-definition div
                stack.append((fence, None))
            cur = next((d for _, d in reversed(stack) if d), None)
            continue
        if cur is not None:
            if not cur["title"]:
                h = HEADING.match(line)
                if h:
                    cur["title"] = h.group(1)
            cur["text"].append(line)
    return divs


def key(site, page, id_):
    return f"{site}/{page}#{id_}"


def build(root, site, pages_dir="chapters"):
    # A `_`-prefixed file is an include, never a page: Quarto does not render it.
    chapters = sorted(p for p in (root / pages_dir).glob("*.qmd") if not p.name.startswith("_"))
    pages = {}
    for qmd in chapters:
        pages[qmd.stem] = parse_page(qmd, site)
    nodes, order = {}, {}
    for page, divs in pages.items():
        for i, d in enumerate(divs):
            k = key(site, page, d["id"])
            nodes[k] = {"id": k, "site": site, "page": page, "div": d["id"], "kind": d["id"].split("-")[0],
                        "title": d["title"] or d["id"], "external": False}
            order[k] = i
    edges = set()
    for page, divs in pages.items():
        for d in divs:
            src = key(site, page, d["id"])
            body = "\n".join(d["text"])
            targets = {}  # (site, page, id) -> the link's own URL, for a cross-site one
            for ref in AT_REF.findall(body):
                targets[(site, page, ref)] = ""
            for href, ref in LINK.findall(body):
                href = href.strip()
                um = URL_SITE.match(href)
                url = ""
                if um and not href.startswith("#"):
                    t_site, t_page = um.group(1), um.group(2)
                    url = re.sub(r"\.qmd$", ".html", href) + "#" + ref
                elif href == "":
                    t_site, t_page = site, page
                else:
                    t_site = site
                    t_page = re.sub(r"\.(qmd|html)$", "", href.split("/")[-1])
                targets[(t_site, t_page, ref)] = url
            for (t_site, t_page, ref), url in targets.items():
                tk = key(t_site, t_page, ref)
                if tk == src:
                    continue
                if tk not in nodes:
                    if t_site == site:
                        continue  # a dangling local reference is check_site.py's business
                    nodes[tk] = {"id": tk, "site": t_site, "page": t_page, "div": ref, "kind": ref.split("-")[0],
                                 "title": ref.split("-", 1)[1].replace("-", " "), "external": True,
                                 "url": url}
                edges.add((src, tk))
    forward = sorted((a, b) for a, b in edges
                     if a in order and b in order and nodes[a]["page"] == nodes[b]["page"] and order[b] > order[a])
    return nodes, sorted(edges), forward, order


def find_cycles(nodes, edges):
    adj = {}
    for a, b in edges:
        adj.setdefault(a, []).append(b)
    index, low, on, stack, out, n = {}, {}, set(), [], [], [0]

    def strong(v):  # iterative Tarjan
        work = [(v, iter(adj.get(v, [])))]
        index[v] = low[v] = n[0]
        n[0] += 1
        stack.append(v)
        on.add(v)
        while work:
            u, it = work[-1]
            for w in it:
                if w not in index:
                    index[w] = low[w] = n[0]
                    n[0] += 1
                    stack.append(w)
                    on.add(w)
                    work.append((w, iter(adj.get(w, []))))
                    break
                if w in on:
                    low[u] = min(low[u], index[w])
            else:
                work.pop()
                if work:
                    low[work[-1][0]] = min(low[work[-1][0]], low[u])
                if low[u] == index[u]:
                    comp = []
                    while True:
                        w = stack.pop()
                        on.discard(w)
                        comp.append(w)
                        if w == u:
                            break
                    if len(comp) > 1:
                        out.append(sorted(comp))

    for v in nodes:
        if v not in index:
            strong(v)
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--root", default=".")
    ap.add_argument("--out")
    ap.add_argument("--site", help="this site's name in cross-site keys (default: the root directory's name)")
    ap.add_argument("--pages", default="chapters",
                    help="directory under --root holding the pages (default: chapters; . for pages at the root)")
    ap.add_argument("--fail", action="store_true", help="exit 1 on a cycle")
    a = ap.parse_args()
    root = Path(a.root).resolve()
    a.site = a.site or root.name
    nodes, edges, forward, order = build(root, a.site, a.pages)
    cycles = find_cycles(nodes, edges)
    out = Path(a.out) if a.out else root / "dependency-graph.json"
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps({
        "site": a.site,
        "meaning": "edge [A, B] means A uses B: B is a prerequisite of A, A a postrequisite of B",
        "nodes": sorted(nodes.values(), key=lambda n: n["id"]),
        "edges": [list(e) for e in edges],
        "cycles": cycles,
        "forwardReferences": [list(e) for e in forward],
    }, indent=1) + "\n", encoding="utf-8")
    print(f"{len(nodes)} nodes, {len(edges)} edges, {len(cycles)} cycles, {len(forward)} forward references -> {out}")
    for c in cycles:
        print("cycle:", " <-> ".join(c))
    for x, y in forward:
        print(f"forward reference: {x} uses {y}, defined later on the page")
    return 1 if (cycles and a.fail) else 0


if __name__ == "__main__":
    sys.exit(main())
