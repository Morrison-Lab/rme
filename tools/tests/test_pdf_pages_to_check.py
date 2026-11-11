#!/usr/bin/env python3
"""Self-test for pdf_pages_to_check.py, on a tiny site: each case in main().

Run it with ``python3 tools/tests/test_pdf_pages_to_check.py``; no pytest.
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
    print("\n".join(f"FAIL {f}" for f in failures) or "ok")
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
