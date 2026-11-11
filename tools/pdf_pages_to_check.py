#!/usr/bin/env python3
# check-one-function-per-file: allow-multiple
"""List the website pages whose PDF a pull request can break.

The PR preview renders HTML only, and the PDF render runs post-merge in
`publish.yml`, so a change that MathJax accepts and LaTeX rejects used to
pass every PR check (#1152, #1160). `check-pdf.yml` renders the pages this
script lists to PDF, one page per `quarto render` call, as `publish.yml`
does, since a whole-site PDF render runs out of memory (#1241).

A page is listed when it, or a file it includes (directly or through another
include), changed, or when it or one of its includes names a changed non-page
file, such as a data file. A change to a path in `GLOBAL` can affect every
page, so it lists them all.

Pages come from the `render:` list of `_quarto-website.yml`, read the same
way `publish.yml` reads it. Standard library only.

    python3 tools/pdf_pages_to_check.py BASE_SHA [--root .]

Prints one project-relative page per line.
"""
import argparse
import re
import subprocess
import sys
from pathlib import Path

# {{< include path >}}, with the path bare or in either kind of quotes
# (the pattern gha's preview/prune-stale-freeze.py uses).
INCLUDE_RE = re.compile(
    r"""\{\{<\s*include\s+(?:"([^"]+)"|'([^']+)'|([^"'>\s]+))\s*>\}\}"""
)
PAGE_SUFFIXES = {".qmd", ".rmd", ".ipynb", ".md"}

# Paths whose change can alter every page's LaTeX. A trailing `/` matches a
# directory prefix; anything else matches the path exactly.
GLOBAL = (
    "_quarto.yml",
    "_quarto-website.yml",
    "_extensions/",
    "filters/",
    "latex-macros",
    "latex-macros/",
    "references.bib",
    "renv.lock",
    "DESCRIPTION",
    "NAMESPACE",
    "R/",
    ".github/workflows/check-pdf.yml",
    "tools/pdf_pages_to_check.py",
)


def render_list(root):
    """The `render:` list of `_quarto-website.yml`, as publish.yml reads it."""
    pages = []
    in_render = False
    text = (root / "_quarto-website.yml").read_text(encoding="utf-8")
    for line in text.splitlines():
        if re.match(r"^  render:", line):
            in_render = True
            continue
        if not in_render:
            continue
        item = re.match(r"^    - (.*)$", line)
        if item:
            pages.append(re.sub(r"[ \t]+#.*$", "", item.group(1)).strip())
        elif not re.match(r"^[ \t]*(#.*)?$", line):
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
        target = next(group for group in match.groups() if group)
        # Quarto resolves a leading `/` against the project root.
        base = root if target.startswith("/") else page.parent
        dependencies(base / target.lstrip("/"), root, seen)
    return seen


def is_global(path):
    return any(
        path.startswith(entry) if entry.endswith("/") else path == entry
        for entry in GLOBAL
    )


def changed_paths(base, root):
    """Paths changed between the merge base of `base` and HEAD."""
    result = subprocess.run(
        ["git", "diff", "--name-only", "--no-renames", f"{base}...HEAD"],
        cwd=root, capture_output=True, text=True, check=True,
    )
    return [line for line in result.stdout.splitlines() if line]


def pages_to_check(changed, root):
    pages = render_list(root)
    if any(is_global(path) for path in changed):
        return pages
    changed_abs = {(root / path).resolve() for path in changed}
    changed_names = {
        Path(path).name for path in changed
        if Path(path).suffix.lower() not in PAGE_SUFFIXES
    }
    selected = []
    for page in pages:
        deps = dependencies(root / page, root)
        if deps & changed_abs:
            selected.append(page)
            continue
        for dep in deps:
            try:
                text = dep.read_text(encoding="utf-8")
            except (OSError, UnicodeDecodeError):
                continue
            if any(name in text for name in changed_names):
                selected.append(page)
                break
    return selected


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("base", help="the PR's base commit")
    parser.add_argument("--root", default=".", type=Path)
    args = parser.parse_args(argv)
    root = args.root.resolve()
    for page in pages_to_check(changed_paths(args.base, root), root):
        print(page)
    return 0


if __name__ == "__main__":
    sys.exit(main())
