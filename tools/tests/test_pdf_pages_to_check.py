#!/usr/bin/env python3
"""Self-test for pdf_pages_to_check.py.

Builds a tiny site and pins: a changed page lists itself, a changed subfile
lists the page that includes it through a nested include, a changed data file
lists the page that names it, an unrelated change lists nothing, a global path
lists every page, and comments in the render list are dropped.

Run it directly with ``python3`` (from the repository root, giving its path). Needs no pytest.
"""

from __future__ import annotations

import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from pdf_pages_to_check import pages_to_check, render_list  # noqa: E402

WEBSITE = """\
project:
  render:
    # the pages
    - chapters/a.qmd
    - chapters/b.qmd # trailing comment

  output-dir: _site
"""


def build(root: Path) -> None:
    (root / "chapters" / "_subfiles" / "a").mkdir(parents=True)
    (root / "_quarto-website.yml").write_text(WEBSITE)
    (root / "chapters" / "a.qmd").write_text(
        "# A\n\n{{< include _subfiles/a/_outer.qmd >}}\n"
    )
    (root / "chapters" / "_subfiles" / "a" / "_outer.qmd").write_text(
        "{{< include _inner.qmd >}}\n"
    )
    (root / "chapters" / "_subfiles" / "a" / "_inner.qmd").write_text("inner\n")
    (root / "chapters" / "b.qmd").write_text(
        '# B\n\n```{r}\nread.csv("data/hers.csv")\n```\n'
    )


def check(label: str, got: list[str], want: list[str], failures: list[str]) -> None:
    if got != want:
        failures.append(f"{label}: got {got}, want {want}")


def main() -> int:
    failures: list[str] = []
    with tempfile.TemporaryDirectory() as tmp:
        root = Path(tmp).resolve()
        build(root)
        both = ["chapters/a.qmd", "chapters/b.qmd"]
        check("render list", render_list(root), both, failures)
        check("changed page", pages_to_check(["chapters/b.qmd"], root),
              ["chapters/b.qmd"], failures)
        check("nested subfile",
              pages_to_check(["chapters/_subfiles/a/_inner.qmd"], root),
              ["chapters/a.qmd"], failures)
        check("data file", pages_to_check(["data/hers.csv"], root),
              ["chapters/b.qmd"], failures)
        check("unrelated", pages_to_check(["README.md"], root), [], failures)
        check("global path", pages_to_check(["latex-macros"], root), both, failures)
        check("global dir", pages_to_check(["filters/x.lua"], root), both, failures)
    for failure in failures:
        print(f"FAIL {failure}")
    print("ok" if not failures else f"{len(failures)} failure(s)")
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
