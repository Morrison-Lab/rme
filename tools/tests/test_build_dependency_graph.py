#!/usr/bin/env python3
"""Self-test for build_dependency_graph.py.

Builds a tiny site and pins: an `@id` edge, a `page.qmd#id` edge, a cross-site
URL edge (with an external stub node), an edge from a subfile, a forward
reference, a cycle, that a reference to an example div adds no edge, and that
reference syntax inside a code block adds no edge and follows no include,
that a proof right after its result counts toward that result,
and that a proof after other text does not.

Run it directly with ``python3`` (from the repository root, giving its path). Needs no pytest.
"""

from __future__ import annotations

import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

import build_dependency_graph as bdg  # noqa: E402

PAGE_A = """---
title: A
---

{{< include _subfiles/a/_def-one.qmd >}}

::: {#def-two}
Uses @def-one and [b](b.qmd#thm-b)
and [a definition elsewhere](https://morrison-lab.github.io/pds/expectation.html#def-expectation).
See @exm-skipped.

```markdown
Example syntax: @def-late and {{< include _subfiles/a/_missing.qmd >}}
```

::: {.callout-note}
A nested non-definition div.
:::

After the callout, still in the div: [a vector](https://example.org/mds/vectors.qmd#def-vector).
:::

::: {#def-early}
Uses @def-late.
:::

::: {#def-late}
Uses @def-early.
:::
"""
SUB = "::: {#def-one}\n\n#### One\n\nNo references.\n\n:::\n"
PAGE_B = "::: {#thm-b}\nUses [one](a.qmd#def-one).\n:::\n"

# A proof right after its result belongs to it; a proof after other text does not.
PAGE_C = """::: {#thm-c}
Statement without references.
:::

::: proof
Uses @def-one and [b](b.qmd#thm-b).

::: {.callout-note}
Nested note citing [one](a.qmd#def-one).
:::
:::

::: {#thm-d}
Statement without references.
:::

Some text between the result and the proof.

::: proof
Cites @thm-c, which belongs to no result.
:::

::: {#thm-e}
Statement without references.
:::

::: proof
Cites [one](a.qmd#def-one).
:::

::: proof
A second proof citing [b](b.qmd#thm-b), which the result does not take.
:::

::: {#thm-f}
Statement without references.
:::

::: {.proofreading}
Cites [one](a.qmd#def-one), but this div is not a proof.
:::

::: {.callout-note title="draft.proof"}
Cites [b](b.qmd#thm-b), but this div is not a proof either.
:::

::: {#thm-g}
Statement without references.
:::

::: {.proof}
Cites [one](a.qmd#def-one) in a brace-form proof.
:::
"""


def main() -> int:
    failures = []
    with tempfile.TemporaryDirectory() as tmp:
        root = Path(tmp)
        (root / "chapters" / "_subfiles" / "a").mkdir(parents=True)
        (root / "chapters" / "a.qmd").write_text(PAGE_A)
        (root / "chapters" / "b.qmd").write_text(PAGE_B)
        (root / "chapters" / "c.qmd").write_text(PAGE_C)
        (root / "chapters" / "_subfiles" / "a" / "_def-one.qmd").write_text(SUB)
        (root / "chapters" / "_include.qmd").write_text("::: {#def-hidden}\nHidden\n:::\n")
        nodes, edges, forward, _ = bdg.build(root, "t")
        cycles = bdg.find_cycles(nodes, edges)
        (root / "chapters" / "a.qmd").rename(root / "a.qmd")
        (root / "chapters" / "b.qmd").rename(root / "b.qmd")
        (root / "chapters" / "c.qmd").rename(root / "c.qmd")
        (root / "chapters" / "_subfiles").rename(root / "_subfiles")
        root_nodes = bdg.build(root, "t", ".")[0]
    edge_set = set(edges)

    def check(name, ok):
        if not ok:
            failures.append(name)

    check("subfile div found with its title", nodes["t/a#def-one"]["title"] == "One")
    check("@id edge", ("t/a#def-two", "t/a#def-one") in edge_set)
    check("page.qmd#id edge", ("t/a#def-two", "t/b#thm-b") in edge_set
          and ("t/b#thm-b", "t/a#def-one") in edge_set)
    check("cross-site edge and stub", ("t/a#def-two", "pds/expectation#def-expectation") in edge_set
          and nodes["pds/expectation#def-expectation"]["external"])
    check("link after a nested div still belongs to the div", ("t/a#def-two", "mds/vectors#def-vector") in edge_set)
    check("cross-site URL keeps its own host",
          nodes["mds/vectors#def-vector"]["url"] == "https://example.org/mds/vectors.html#def-vector")
    check("a proof right after its result adds that result's edges",
          ("t/c#thm-c", "t/a#def-one") in edge_set and ("t/c#thm-c", "t/b#thm-b") in edge_set)
    check("a proof after other text belongs to no result", not any(a == "t/c#thm-d" for a, _ in edge_set))
    check("only the first proof after a result counts",
          ("t/c#thm-e", "t/a#def-one") in edge_set and ("t/c#thm-e", "t/b#thm-b") not in edge_set)
    check("a class that merely contains proof is not a proof",
          not any(a == "t/c#thm-f" for a, _ in edge_set))
    check("a brace-form .proof div is a proof", ("t/c#thm-g", "t/a#def-one") in edge_set)
    check("example reference adds no edge", not any("exm" in b for _, b in edge_set))
    check("syntax shown in a code block is not a reference", ("t/a#def-two", "t/a#def-late") not in edge_set)
    check("forward reference", ("t/a#def-early", "t/a#def-late") in forward)
    check("cycle", cycles == [["t/a#def-early", "t/a#def-late"]])
    check("pages at the root with --pages .", set(root_nodes) == set(nodes))
    check("an underscore-prefixed file is an include, not a page", not any("_include" in k or "hidden" in k for k in nodes))
    for f in failures:
        print("FAIL:", f)
    print("ok" if not failures else f"{len(failures)} failed")
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
