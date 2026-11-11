#!/usr/bin/env python3
# check-one-function-per-file: allow-multiple
"""List the website pages whose PDF a pull request can break.

`check-pdf.yml` renders these pages to PDF, one per `quarto render` call,
so a change that MathJax accepts and LaTeX rejects fails on the PR (#1152,
#1160) rather than in `publish.yml` after it merges.

A page is listed when it or a file it includes (directly or through another
include) changed, or when one of those names a changed non-page file, such as
a data file. A change to a path in `GLOBAL` can affect every page, so it lists
them all. Pages come from the `render:` list of `_quarto-website.yml`, read
the way `publish.yml` reads it. Standard library only.

    python3 tools/pdf_pages_to_check.py BASE [--root .]   # one page per line
"""
import argparse
import re
import subprocess
import sys
from pathlib import Path

# {{< include path >}}, bare or quoted (gha's preview/prune-stale-freeze.py).
INCLUDE_RE = re.compile(
    r"""\{\{<\s*include\s+(?:"([^"]+)"|'([^']+)'|([^"'>\s]+))\s*>\}\}"""
)
PAGE_SUFFIXES = {".qmd", ".rmd", ".ipynb", ".md"}

# Paths whose change can alter every page's LaTeX. A trailing `/` matches a
# directory prefix; anything else matches the path exactly.
GLOBAL = (
    "_quarto.yml", "_quarto-website.yml", "_extensions/", "filters/",
    "latex-macros", "latex-macros/", "references.bib", "renv.lock",
    "DESCRIPTION", "NAMESPACE", "R/",
    ".github/workflows/check-pdf.yml", "tools/pdf_pages_to_check.py",
)


def render_list(root):
    """The `render:` list of `_quarto-website.yml`, as publish.yml reads it."""
    pages, in_render = [], False
    for line in (root / "_quarto-website.yml").read_text(encoding="utf-8").splitlines():
        if re.match(r"^  render:", line):
            in_render = True
        elif in_render and (item := re.match(r"^    - (.*)$", line)):
            pages.append(re.sub(r"[ \t]+#.*$", "", item.group(1)).strip())
        elif in_render and not re.match(r"^[ \t]*(#.*)?$", line):
            in_render = False
    return pages


def dependencies(page, root, seen=None):
    """The page plus every file it includes, recursively, as resolved paths."""
    seen = set() if seen is None else seen
    page = page.resolve()
    if page in seen:
        return seen
    seen.add(page)
    try:
        text = page.read_text(encoding="utf-8")
    except (OSError, UnicodeDecodeError):
        return seen
    for match in INCLUDE_RE.finditer(text):
        target = next(g for g in match.groups() if g)
        # Quarto resolves a leading `/` against the project root.
        base = root if target.startswith("/") else page.parent
        dependencies(base / target.lstrip("/"), root, seen)
    return seen


def is_global(path):
    return any(path.startswith(e) if e.endswith("/") else path == e for e in GLOBAL)


def names_changed_file(deps, changed_names):
    for dep in deps:
        try:
            text = dep.read_text(encoding="utf-8")
        except (OSError, UnicodeDecodeError):
            continue
        if any(name in text for name in changed_names):
            return True
    return False


def pages_to_check(changed, root):
    pages = render_list(root)
    if any(is_global(path) for path in changed):
        return pages
    changed_abs = {(root / path).resolve() for path in changed}
    changed_names = {Path(p).name for p in changed if Path(p).suffix.lower() not in PAGE_SUFFIXES}
    selected = []
    for page in pages:
        deps = dependencies(root / page, root)
        if deps & changed_abs or names_changed_file(deps, changed_names):
            selected.append(page)
    return selected


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("base", help="the commit to diff against (its merge base with HEAD)")
    parser.add_argument("--root", default=".", type=Path)
    args = parser.parse_args()
    root = args.root.resolve()
    diff = subprocess.run(
        ["git", "diff", "--name-only", "--no-renames", f"{args.base}...HEAD"],
        cwd=root, capture_output=True, text=True, check=True,
    ).stdout.split()
    for page in pages_to_check(diff, root):
        print(page)


if __name__ == "__main__":
    sys.exit(main())
