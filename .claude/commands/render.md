---
description: Render a single Quarto chapter to HTML and report build status
allowed-tools:
  - Bash(quarto render *)
---

Render only the touched chapter to HTML: `quarto render chapters/<chapter>.qmd --to html`. Do **not** render the full book --- it's slow, and the book builds in CI.

If the change is in a file under `chapters/_subfiles/`, render the *parent* chapter that includes it, not the subfile.

Report:

- Whether the render succeeded or failed
- Any ERROR or WARNING messages, with the file and line number where each occurred (call out math/macro, missing-resource, link, and deprecated-syntax warnings explicitly)

If the render fails, diagnose the root cause and suggest a fix before asking to proceed. Do not commit `_book/`, `_site/`, or `_freeze/` --- those are build artifacts.
