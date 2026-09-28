# GitHub Copilot Instructions

> [!IMPORTANT]
> **MANDATORY TESTING BEFORE EVERY COMMIT:**
>
> Before committing ANY changes to `.qmd`, `.R`, or config files:
>
> 1. **Run `quarto render <chapter.qmd> --to html` on each chapter whose subfiles were edited** (not individual subfiles; not the full book; HTML format only unless you are specifically fixing a non-HTML format issue)
> 2. **Verify it completes successfully** (exit code 0, no errors)
> 3. **Address ALL rendering warnings**:
>    - Review output for `[WARNING]` or `Warning:` messages
>    - Fix warnings related to:
>      - Math rendering (TeX/LaTeX errors, undefined commands like `\atop`)
>      - Missing resources (images, files)
>      - Broken links or references
>      - Deprecated syntax or constructs
>    - **Fix all warnings you can address** - document any that cannot be fixed
> 4. **Run linter on changed files**:
>    - For R files: `lintr::lint("path/to/file.R")`
>    - For .qmd files with R code: Extract and lint R code chunks
>    - **Fix lint issues in code you wrote or modified** - ignore pre-existing issues in unchanged code
> 5. **Run spellcheck**: `spelling::spell_check_package()`
>    - **Fix spelling errors you introduced** - ignore pre-existing errors
>    - Add technical terms to `inst/WORDLIST` if needed (create file if it doesn't exist, one word per line)
> 6. Only then commit your changes
>
> **CRITICAL RULES:**
> - **CI is NOT the test** - you must test locally BEFORE pushing
> - **NEVER rely on CI to discover rendering, lint, or spelling errors** - that's your job
> - **ALWAYS address rendering warnings** - they indicate problems that will cause issues in different output formats
> - **Only render HTML format** (`--to html`) unless specifically fixing a non-HTML format issue
> - **Only render edited chapters** — run `quarto render <chapter.qmd> --to html` on the parent `.qmd` that includes each edited subfile; do not render the full book
> - **Only fix lint/spell issues in code YOU changed** - don't fix unrelated pre-existing issues
> - **This is a hard requirement - no exceptions, no excuses**

## General Development Principles

**CRITICAL**: Do not make assumptions about what code will do - always test it yourself.

- **Test your changes**: Run the actual commands to verify functionality
- **Run `quarto render <chapter.qmd> --to html` on each edited chapter**: Only render chapters whose subfiles were edited, in HTML format (not the full book, not all formats)
- **Verify output**: Check that expected files are created with correct content
- **Never claim success without evidence**: Only report that something works after you've confirmed it yourself

## Scoped Instructions

Use the matching file-scoped instructions in `.github/instructions/`
in addition to this global policy file:

- `quarto-content.instructions.md` for `.qmd` and `.Rmd` authoring work
- `r-and-config.instructions.md` for R, Quarto YAML, and workflow/config changes
- `latex-macros.instructions.md` when editing the `latex-macros/` submodule

Keep this file as the repo-wide policy anchor.
Prefer the scoped files for task-specific details,
links to source documentation,
and reminders that would otherwise add noise to every task.

Related reusable customizations live under `.github/skills/`
and `.github/prompts/`.
Use them for repeated repo-specific workflows
instead of re-deriving the same steps in every chat.

## Narrative Flow

When writing or editing chapter content,
strive for **straightforward narrative flow**:

- Introduce concepts before they are used.
  Never reference a section, definition, or term
  that has not yet been introduced at that point in the document.
- Avoid forward references within a chapter
  (e.g., "See @sec-later-section for details")
  when those concepts are needed to understand the current content.
  Reorder sections so that foundational material precedes applied material.
- If two sections are closely related
  (e.g., an "Observational Studies" section that relies on DAG concepts),
  place the foundational section first.
- **After every definition or concept, include a concrete example** —
  preferably numerical — to illustrate the abstract idea.
  Use a `{#exm-...}` div immediately following the `{#def-...}` div.
  The example should show specific numbers or a small dataset,
  not just repeat the definition in different words.
  - Narrow exception: an immediate corollary whose statement is itself
    a concrete instance of the result it follows needs no separate example —
    the corollary already is one.
    For instance, $\E{aX+c} = a\E{X}+c$ stated right after linearity of
    expectation needs no further example:
    a filler example there would just restate the corollary in different
    symbols, costing the reader more than it teaches.
    This exemption is narrow — it covers only a corollary whose own statement
    already instantiates the preceding result;
    definitions and theorems still require a genuine example,
    and a corollary that adds new content of its own still needs one.
    (Decided 2026-09-28.)

## Code Review Scope

The `_extensions/` directory contains Quarto extensions installed from external repositories
(e.g., via `quarto add`).
These files are third-party code managed upstream.
**Do not review or suggest changes to files under `_extensions/`.**
Treat them as vendored dependencies — read them for context if needed,
but do not flag issues or request modifications in those files.

## Pull Request Guidelines

- **When you start working on a PR, immediately remove any existing review requests.**
  This signals to reviewers that the PR is not yet ready for review
  and prevents premature reviews of incomplete work.
- Always ensure that PR branch is up to date with main branch before requesting PR review
- **ALWAYS verify all changed hyperlinks are correct before requesting PR review**:
  - Check that internal links point to existing files/sections
  - Verify external URLs are accessible and correct
  - Test cross-references and anchor links
  - Ensure relative paths are correct
- **If ANY subfiles (`_subfiles/`) were edited in the PR, add the "clear freezer" label to the PR.**
  Quarto's freeze cache does not detect changes in subfiles (see [quarto-dev/quarto-cli#6793](https://github.com/quarto-dev/quarto-cli/issues/6793)),
  so the frozen output must be cleared manually to pick up those changes.

## Linking Within the Quarto Website

When linking to other pages within this Quarto website, always link to the **source `.qmd` file**, not the rendered `.html` file.
This follows the [Quarto website linking guidelines](https://quarto.org/docs/websites/#linking).

**Correct** (link to source file):
```markdown
[chain rule](math-prereqs.qmd#thm-chain-rule)
```

**Incorrect** (link to rendered HTML):
```markdown
[chain rule](math-prereqs.html#thm-chain-rule)
```

This ensures links work correctly across all output formats and during local development.

## Attribution for Adapted Content

When content is adapted from published sources (textbooks, papers, websites),
**always provide explicit attribution** in the document.
Use `@citekey` Pandoc citation syntax and include a prose note explaining what was adapted.

Examples of acceptable attribution:

- "Adapted from @vittinghoff2e [Chapter 10]."
- "The following example is based on @kleinbaum2010logistic [Chapter 8]."
- "This approach follows @hulley1998hers."

Attribution should appear:

- At the top of the chapter or section (in the Acknowledgements or Introduction),
  *or*
- Adjacent to the specific content being adapted (as a prose sentence or in a `::: notes` div).

**Always include chapter and/or page numbers** in inline citations where applicable,
so that readers can locate the source material.
Use Pandoc's citation locator syntax: `[@citekey, Chapter 8]` or `[@citekey, p. 194]`.
Include both chapter and page when both are known.
Do **not** invent page numbers.
Only cite a page after opening the source PDF
and confirming the exact page.
If you have not verified a page directly from the source PDF,
cite chapter-level location only.

Examples of attribution with page numbers
(formatting examples):

- "Adapted from [@vittinghoff2e, Chapter 10, p. 194]."
- "The following example is based on [@kleinbaum2010logistic, Chapter 8, p. 230]."

Do **not** reproduce verbatim text from copyrighted sources without clear quotation marks and attribution.
Paraphrase and summarize with a citation instead.

## Decomposing content into subfiles

Quarto subfiles (files under `_subfiles/`) should **not** begin with a section heading.
The heading for a subfile's content should be placed in the **parent** file that includes the subfile,
immediately before the `{{< include ... >}}` shortcode.

**Correct** — heading in the parent file:
```markdown
## My Section Title {#sec-my-section}

{{< include _subfiles/chapter/_sec_my_content.qmd >}}
```

**Incorrect** — heading inside the subfile:
```markdown
<!-- inside _subfiles/chapter/_sec_my_content.qmd -->
## My Section Title {#sec-my-section}

Content starts here...
```

This keeps the document hierarchy centralized in the parent file,
makes heading levels easy to audit,
and avoids nesting errors when the same subfile might be included at different depths.

### One subtopic per subfile

Each subfile should cover exactly one subtopic or section.
Do **not** combine multiple independent subtopics in a single subfile.
If a topic naturally splits into distinct subtopics,
create one subfile per subtopic and include each separately in the parent file.

**Correct** — separate subfiles per subtopic:
```markdown
## Interval Censoring {#sec-interval-censoring}

{{< include _subfiles/chapter/_sec_interval_censoring.qmd >}}

## Left-Truncation {#sec-left-truncation}

{{< include _subfiles/chapter/_sec_left_truncation.qmd >}}
```

**Incorrect** — both subtopics in one subfile:
```markdown
## Interval Censoring and Left-Truncation

{{< include _subfiles/chapter/_sec_interval_censoring_and_left_truncation.qmd >}}
```

### No references section in subfiles

Subfiles must **not** include a `## References` section.
References sections belong only in parent `.qmd` files (chapters, index pages, etc.).
Do **not** add `## References {.unnumbered}` or `:::{#refs}:::` to any file under `_subfiles/`.

## Citation Grammar Conventions

When using Pandoc-style citation keys (e.g., `@dobson4e`) as the grammatical subject of a sentence,
treat the citation as a **singular** subject and use third-person singular verb forms:

- **Correct**: `@dobson4e omits … but describes …`
- **Incorrect**: `@dobson4e omit … but describe …`

This applies whether the citation refers to one author or multiple authors (e.g., "Dobson and Barnett").
Pandoc renders `@dobson4e` as a noun phrase (e.g., "Dobson and Barnett (2018)"),
but grammatically the citation key itself is treated as a singular pronoun/name.

## DAG Naming for Categorical Variables

In DAGs,
use node names that represent the full categorical variable,
not a specific level of that variable.

Example:
use `personality_type`,
not `TypeA`.

## Evidence and Source Citation Requirements

For factual claims that are not directly proved in the text,
always include a specific source citation.
Do not leave factual statements uncited.

Always cite papers and books using
BibTeX entries in `references.bib`
and Quarto/Pandoc citation syntax
(for example `[@MickeyGreenland1989]`),
rather than plaintext author-date references.

When adapting any content from another source,
always include specific attribution in the chapter text.
Always state the exact adapted exercise(s) or example(s),
not just a broad chapter citation.
When the source provides numbered exercises/examples,
cite the exact number
and the exact page number.
When specific numbers are not available in the source,
use chapter/section locators instead of inventing numbers.
Use a BibTeX-backed citation key
with a chapter or page locator
(for example, `[@dobson4e, Chapter 7]` or `[@vittinghoff2e, p. 194]`).
Do not use generic acknowledgements without locators
or plaintext author-title references
when a BibTeX citation is available.

## Observational vs Causal Estimands

Always distinguish observational estimands
from causal estimands in notation and prose.

- Use observational notation
  (for example, standardized risks based on `\E{Y \mid A=a, Z=z}`)
  when discussing model-based associations.
- Use potential-outcome notation
  (for example, `\Prf{Y^a = 1}`)
  only when making a causal claim.
- If observational and causal estimands are equated,
  explicitly state identification assumptions
  (consistency, exchangeability, and positivity).

## Variable Definitions in Exercises

When introducing model variables in exercises,
list variable definitions as bullet points
and/or a table.
Do not define multiple variables inline in prose.
Include symbol,
plain-language meaning,
and dataset column mapping.

## Solution Wording

In solution blocks,
state the correct conclusions directly.
Do not phrase final answers conditionally
when the provided figure or context
supports a specific conclusion.

## Code Formatting Guidelines

When adding or editing text in source code (such as comments, documentation strings, or error messages) or in Quarto document text chunks:
- Add a newline at the end of every phrase or logical unit of text
- Each phrase should be on its own line in the source code
- A phrase is typically a complete thought, clause, or sentence
- This improves readability and makes diffs clearer

## ggplot2 Layer Style

Always put `ggplot()` and `aes()` calls in **separate layers**.
Never pass `aes()` as an argument to `ggplot()`.

**Correct:**
```r
ggplot(my_data) +
  aes(x = time, y = value, color = group) +
  geom_line()
```

**Incorrect:**
```r
ggplot(my_data, aes(x = time, y = value, color = group)) +
  geom_line()
```

## No Hard-Coded Results in Narrative Text

Do not hard-code numerical results (percentages, means, counts, etc.)
in Quarto narrative text.
Use inline R expressions instead,
so that the numbers update automatically if the data or code changes.

**Correct:**
```markdown
At 5 years, `r round(surv_5yr * 100, 1)`% of participants had experienced the event.
```

**Incorrect:**
```markdown
At 5 years, 8% of participants had experienced the event.
```

Compute the values in a code chunk (using `#| include: false` if needed),
then reference them with inline `` `r expr` `` expressions.

## Notes Divs in Quarto Slides

Wrap content in `::: notes` divs in two situations:

1. **Parenthetical references and short asides** that are supplementary
   (for example, `c.f. @dunn2018generalized §2.10.3`) —
   place them in a `::: notes` div
   instead of leaving them inline in the main narrative.

2. **Large explanatory text blocks** — multi-sentence prose that provides
   intuition, context, or derivation details —
   should be wrapped in `::: notes` when the surrounding content is
   structured for slide presentation.
   Use `::: notes` for any block that would overflow or distract on a slide;
   leave brief one- or two-line slide headers and summary bullet points unwrapped.

## Fenced Divs and List Indentation in Quarto

Do not indent `:::` fenced div markers
as if they were list-continuation content.
In this project,
indented fenced div markers can render as literal `:::`
instead of being parsed as div blocks.

When you need a notes/callout div related to a list item,
end the list first,
then start the div at the left margin
with blank lines around the fenced block.

Example:
```r
# Good: Each instruction on its own line
# First, check if the input is valid.
# Then, process the data.
# Finally, return the result.

# Avoid: Multiple phrases on one line
# First, check if the input is valid. Then, process the data. Finally, return the result.
```

## Definition Formatting

When introducing or editing formal statistical definitions in `.qmd` files:

- Use a definition div with an id beginning `#def-`
- Put the definition title in a heading inside the div
  and choose the heading level to match the surrounding section depth
  (for example, `####` or `#####`)
- If a definition uses other statistical terms
  (for example, empirical CDF),
  ensure those terms also have formal `#def-` div definitions
  in the relevant scope before relying on them

## Slidebreaks Before Theorem-Type Divs

Always add `{{< slidebreak >}}` on a blank line immediately before
every theorem-type div opener.
This ensures slide-format output stays readable.

Theorem-type div types (per [Quarto cross-reference docs](https://quarto.org/docs/authoring/cross-references.html#theorems-and-proofs)):
`#thm-`, `#lem-`, `#cor-`, `#prp-`, `#cnj-`, `#def-`, `#exm-`, `#exr-`, `#rem-`, `#sol-`

### Slidebreaks in including vs. included files

When a subfile's **first** content is a theorem-type div,
place the `{{< slidebreak >}}` in the **including** (parent) file,
immediately before the `{{< include >}}` shortcode —
**not** at the start of the included subfile itself.

**Correct** — slidebreak in the including file:
```qmd
<!-- in the parent file -->
{{< slidebreak >}}

{{< include _subfiles/chapter/_exm-my-example.qmd >}}
```

```qmd
<!-- in _exm-my-example.qmd — no leading slidebreak -->
:::{#exm-my-example}

#### My example title

Content...

:::
```

**Incorrect** — slidebreak inside the included file:
```qmd
<!-- in the parent file — no slidebreak -->
{{< include _subfiles/chapter/_exm-my-example.qmd >}}
```

```qmd
<!-- in _exm-my-example.qmd — do NOT put slidebreak here -->
{{< slidebreak >}}

:::{#exm-my-example}

#### My example title

Content...

:::
```

**Correct** example (non-leading slidebreak, same file):
```qmd
{{< slidebreak >}}

:::{#def-collapsibility}

#### Collapsibility

A measure is *collapsible* if ...

:::
```

**Incorrect** (missing slidebreak):
```qmd
:::{#def-collapsibility}

#### Collapsibility

A measure is *collapsible* if ...

:::
```

### Exception: section heading immediately before the div

When a section heading immediately precedes the div
(or the `{{< include >}}` of a subfile that begins with one),
the `{{< slidebreak >}}` may be omitted
so the heading shares its slide with the div,
rather than producing a title-only slide.
Mark the intentional omission with an inline
`<!-- ... do not re-flag -->` comment at that spot.

## Example Formatting

All worked examples in `.qmd` files must be wrapped in a Quarto `#exm-` div.
Never leave a named example as a plain markdown section.

**Correct:**
```qmd
:::{#exm-wcgs-marginal-rd}

##### Example: Marginal risk difference

Content of the example...

:::
```

**Incorrect:**
```qmd
##### Example: Marginal risk difference

Content of the example...
```

- Use an id beginning `#exm-` (for example, `#exm-wcgs-marginal-rd`)
- Put the example title in a heading inside the div,
  at the heading level matching the surrounding section depth
- All content for the example (setup, computation, interpretation)
  should live inside the div

## Div Titles vs. Markdown Headings

**CRITICAL**: Div titles (headings inside divs like `:::{#def-...}`, `:::{#thm-...}`, `:::{#exm-...}`, etc.) are NOT the same as regular markdown headings.

**Rules for div titles:**
- Div titles must remain inside their divs
- Div titles use heading syntax (`####`, `###`, etc.) but serve as titles for the div content
- **NEVER move a div title outside of its div or change its heading level when fixing heading level jumps**
- Div titles should match the nesting level of their surrounding context, but this is different from regular heading hierarchy

**How to identify div titles:**
- They appear immediately after a div opener like `:::{#def-something}`, `:::{#thm-something}`, `:::{#exm-something}`, etc.
- They are inside the div block (between `:::` markers)

**Example of correct div title:**
```qmd
:::{#def-confounder}
#### Confounder

A **confounder** is a variable...
:::
```

**Wrong - do NOT do this:**
```qmd
#### Confounder

:::{#def-confounder}
A **confounder** is a variable...
:::
```

**When fixing heading level jumps:**
- Only fix regular markdown headings (those NOT inside divs)
- Leave div titles at their original heading levels
- Div titles may appear to "jump" levels, but this is correct because they serve a different purpose

## Quarto Code Chunk Options

Default to
`#| code-fold: true`
for chunks that create figures or tables.
Only set
`#| code-fold: false`
for those chunks
if reviewers explicitly request it
or if the surrounding narrative requires visible code to follow the argument.

When the code **and** its console output are both needed for the surrounding narrative to make sense, use `#| code-fold: false` so that neither is hidden:

```qmd
```{r}
#| code-fold: false
deviance(my_model)
sum(residuals(my_model)^2)
```
```

Use `code-fold: false` whenever:
- The output value is referenced or explained in the surrounding text
- The reader needs to see both the code and the result to follow the argument

**Do not use `#| include: false` unless there is a specific reason** to hide the code from readers
(for example, loading a package whose installation messages would be distracting,
or a long data-munging chunk that is not the focus of the example).
For most setup chunks in examples and exercises,
leave the code visible or use `#| code-fold: true`
so readers can see how the data or values were constructed.

## Quarto `df-print` behavior

For this repository,
configure Quarto YAML settings
so data-frame printing is:
- paged in HTML and RevealJS outputs
- tibble-style in PDF and DOCX outputs

When this configuration is in place,
full dataset prints in exercises are expected behavior,
not automatically a readability problem.
Feedback that asks to trim dataset prints
without checking these format settings
can be incorrect.

If a maintainer claim
(or any other claim)
appears to conflict with the repository configuration or rendered output,
verify it against the code and outputs
and politely correct it with evidence.

## Landscape Tables in PDF

When a table is too wide for portrait orientation in PDF,
wrap the table div in a `.landscape` fenced div.

Use this pattern:

```qmd
::: {.landscape}

:::{#tbl-your-wide-table}
... table content ...
:::

:::
```

Apply this only where needed,
so HTML and RevealJS output stay unchanged.

## Figures and Tables: Use Div Format

Prefer the **Quarto div format** for new figures and tables
rather than chunk-option `fig-cap`/`tbl-cap`.
The div format makes it easier to write and format multi-sentence captions.
Existing chunk-option captions in older files are acceptable
unless you are already refactoring that content.

**Correct** (div format):
````qmd
::: {#fig-my-figure}

```{r}
plot(x, y)
```

Caption text here.
This can span multiple lines and include *markdown*.

:::
````

**Correct** (div format for tables):
````qmd
::: {#tbl-my-table}

```{r}
my_table
```

Caption text here.

:::
````

**Incorrect** (chunk option format):
````qmd
```{r}
#| label: fig-my-figure
#| fig-cap: "Caption text here."
plot(x, y)
```
````

Use this for newly added or substantially revised figures and tables in `.qmd` files.

## Chunk Label Prefixes (`fig-` and `tbl-`)

Only use `fig-` or `tbl-` chunk/div label prefixes when the chunk or div **actually renders a cross-referenceable figure or table**.
Do **not** use these prefixes for setup, computation-only, or helper chunks that produce no visible output.

**Correct** — `fig-` label on a div that produces a cross-referenceable figure:
````qmd
::: {#fig-my-plot}

```{r}
plot(x, y)
```

Caption text here.

:::
````

**Correct** — setup chunk that only computes values (no figure/table produced):
````qmd
```{r}
#| label: my-setup-chunk
#| include: false
my_value <- compute_something()
```
````

**Incorrect** — `tbl-` label on a chunk that only computes values:
````qmd
```{r}
#| label: tbl-my-values   # wrong: no table is rendered
my_value <- compute_something()
```
````

Using the wrong prefix can cause Quarto cross-reference errors or mislead readers about what the chunk produces.


## Math Notation

This repository uses custom LaTeX macros defined in `latex-macros/macros.qmd` (a git submodule).
Always use the custom macros instead of raw LaTeX equivalents.

Key macros to use:
- **Expectation operator**: Use `\E{Y|X=x}` (renders as $\text{E}[Y|X=x]$), **not** raw `E[Y|X=x]`
- **Aligned equations**: Use `\ba` / `\ea` for `\begin{aligned}` / `\end{aligned}`
- **Greek letters**: Use `\b` for $\beta$, `\g` for $\gamma$, `\a` for $\alpha$
- **Formatting**: Use `\red{...}` and `\teal{...}` for colored text in math
- **Deviation/error notation**: Use `\erf{...}` for deviations of estimates/estimators from their estimands; use `\devn(...)` for all other deviations (e.g., observations from population means)
- **Estimators of vector estimands**: the estimator symbol (e.g. `\hat`,
  `\bar`, `\tilde`) goes on top of the vector symbol, not inside it —
  write `\hat{\vec{\mu}}`, not `\vec{\hat\mu}`. The hat sits on top of the
  already-vectorized symbol. Use `\v{}`, `\vec{}`, or `\vecf{}` — all three
  work. (`\v` was formerly broken because `\providecommand` could not override
  the LaTeX built-in caron accent; it is now defined with `\renewcommand`
  in `macros.qmd`.)

matrix-product helper macros:

- `\dprod{u}{v}` for dot products
- `\iprod{u}{v}` for inner products (`\tp{u} v`)
- For vector:vector inner products in chapter/exam formulas, prefer `\dprod{u}{v}` over transpose form unless dimensions are the focus.
- `\oprod{u}{v}` for outer products (`u \tp{v}`)
- `\siprod{u}` for self-inner products (`\tp{u} u`)
- `\soprod{u}` for self-outer products (`u \tp{u}`)

Residual and deviation helper macros include:

- `\err` is deprecated; prefer `\devn(...)` for new non-estimation deviations while legacy uses are being phased out
- `\erf{\theta}` for estimate/estimand deviations
- `\devn(...)` for other deviations
- `\resid` for residual symbols (`r`)
- `\stdresid` for standardized residual symbols (`r'`)
- `\modresid` for modified residual symbols (`r^*`)

- **Transpose**: Use `\tp{v}` (renders as $v'$) instead of the raw prime `v'` notation.
  However, `\tp{v}` appends `^{\top}` to the argument, so if the argument already carries a superscript
  (e.g., `\vxs` expands to `{{\vec{x}^*}}` which has `^*`), wrap it in parentheses first:
  use `\tp{(\vxs)}` not `\tp{\vxs}`.
  This avoids LaTeX "Double superscript" errors.

**Ratio vs. factor macros**:

- **Ratios** compare two quantities. Use the *generic* `\ratio` / `\ratiof` macro when the
  inputs are the **quantities themselves** (the odds, hazards, rates, etc.) — the type of ratio
  is clear from the inputs. For example, an odds ratio of two odds is `\ratio(\odds_1, \odds_2)`,
  **not** `\ror(\odds_1, \odds_2)`.
- Use the *type-subscripted* ratio macros (`\ror` for odds ratios, `\hazratio`/`\hr` for hazard
  ratios, and `\rateratio`, `\riskratio`, `\prevratio`, `\cuhazratio`, …) only when the inputs are
  **covariate patterns** (e.g. `\ror(\vx, \vxs)`, `\hr(t \mid \vx : \vxs)`), where the subscript
  is needed to indicate which kind of ratio it is.
- **Factors** compare **one** covariate pattern to the implicit baseline pattern. Use the
  type-subscripted factor macros (`\hazfactor`, `\oddsfactor`, …; function forms `\hazfactorf` /
  `\hazff`, …) — e.g. the Cox risk score `\hazfactor(\vx)`. Factors always take a covariate
  pattern, so they keep their subscript.

**Vector–scalar product ordering** (for dimensional clarity):

- When multiplying a **column vector** `\vb` by a scalar `s`, write the **vector on the left**:
  use `\vb s` not `s \vb`.
- When multiplying a **row vector** (or a transpose) by a scalar, write the **vector on the right**:
  use `s \tp{\vb}` not `\tp{\vb} s`.

This ordering makes the matrix dimensions of expressions immediately readable
and is consistent with the convention that column vectors are always written first
in scalar multiples (e.g., a gradient $\nabla f = \vb \pi(1-\pi)$,
not $\pi(1-\pi) \vb$).

Always check `latex-macros/macros.qmd` for available macros before writing raw LaTeX.

When a repeatedly used expression needs a new macro,
add it to `latex-macros/macros.qmd`
in the `latex-macros` submodule
and push that submodule update.

To push changes to the `latex-macros` submodule (`https://github.com/d-morrison/macros`),
use the `SUBMODULES_TOKEN` environment variable for authentication:

```bash
cd latex-macros
git remote set-url origin "https://x-access-token:${SUBMODULES_TOKEN}@github.com/d-morrison/macros.git"
# make changes, commit, then push to a branch (main is protected; PRs required):
git push origin main:copilot/your-branch-name
# then open and merge a PR via the GitHub API or UI
```

## Accessing the private `ucdavis/epi202` repository

The `EPI202_TOKEN` environment variable holds a fine-grained PAT with
read access to `https://github.com/ucdavis/epi202` (Epi 202 course
materials, taught alongside this Epi 204 course). Use it on demand
when you need to look up course content from that repo. If
`EPI202_TOKEN` is empty in your environment, the repo is not
available for this session — say so rather than guessing.

```bash
# Clone the whole repo:
git clone "https://x-access-token:${EPI202_TOKEN}@github.com/ucdavis/epi202.git" /tmp/epi202

# Fetch a specific file via the API:
curl -fsSL -H "Authorization: token ${EPI202_TOKEN}" \
  https://raw.githubusercontent.com/ucdavis/epi202/main/path/to/file.qmd

# Hit the GitHub REST API:
GH_TOKEN="${EPI202_TOKEN}" gh api repos/ucdavis/epi202/contents/path/to/file.qmd
```

The token is loaded automatically for the Copilot coding agent (via the
`copilot` deployment environment) and for `@claude` PR sessions (via a
job-level `env:` mapping in `.github/workflows/claude.yml`).

## Accessing the private `ucdavis/epi204` repository

The `EPI204_TOKEN` environment variable holds a fine-grained PAT with
read access to `https://github.com/ucdavis/epi204` (Epi 204 homework
and solutions for this course). Use it on demand when you need to look
up homework or solution content from that repo. If `EPI204_TOKEN` is
empty in your environment, the repo is not available for this session —
say so rather than guessing.

```bash
# Clone the whole repo:
git clone "https://x-access-token:${EPI204_TOKEN}@github.com/ucdavis/epi204.git" /tmp/epi204

# Fetch a specific file via the API:
curl -fsSL -H "Authorization: token ${EPI204_TOKEN}" \
  https://raw.githubusercontent.com/ucdavis/epi204/main/path/to/file.qmd

# Hit the GitHub REST API:
GH_TOKEN="${EPI204_TOKEN}" gh api repos/ucdavis/epi204/contents/path/to/file.qmd
```

The token is loaded automatically for the Copilot coding agent (via the
`copilot` deployment environment) and for `@claude` PR sessions (via a
job-level `env:` mapping in `.github/workflows/claude.yml`).

## Color Coding Strategy for Math Expressions

Use `\red{...}` and `\teal{...}` purposefully and consistently to help readers
(`\teal`, not `\blue` — `\teal` reads better in dark mode):

1. **Focal coefficient**: Use `\red{...}` for the coefficient being interpreted or derived in the current context.
   This draws the reader's eye to the quantity that the surrounding text is about.
   Example: When deriving that $\b_A$ is the slope, color it `\red{\b_A}` throughout the derivation.

2. **Differences between similar expressions**: When comparing two expressions that differ in certain components,
   use `\red{...}` for the unique/extra term and `\teal{...}` for the shared term.
   This makes it visually clear what cancels and what remains.
   Example: Male slope $= \teal{\b_A} + \red{\b_{AM}}$, female slope $= \teal{\b_A}$,
   difference $= \teal{\b_A} + \red{\b_{AM}} - \teal{\b_A} = \red{\b_{AM}}$.

3. **Reference level constraints**: In models with interactions, coefficient interpretations are constrained
   to a specific reference level of other covariates.
   Use `\red{0}` (or `\red{P = 0}`, `\red{A = 0}`, etc.) to highlight reference levels that constrain an interpretation.
   Use `\teal{m}` (or the generic variable name) when the interpretation holds for any value.
   This visually distinguishes interaction models (constrained) from additive models (unconstrained).

4. **Chain rule components**: When applying the chain rule, use `\red{...}` for the first factor
   and `\teal{...}` for the second factor.
   This connects the factored form to the simplified form on the next line.

5. **Connected components across equations**: When a term is defined in one equation and expanded
   or substituted in another, use the same color for the term and its expansion.
   This creates a visual link between the definition and its use.

## Math Derivations

Include as many intermediate steps as possible in math derivations.
Every non-trivial algebraic manipulation should be shown explicitly on its own line inside an aligned equation.
Do not skip steps even if they seem obvious.
This helps readers follow the logic and makes errors easier to spot.

## CI/CD Workflow Debugging

When investigating CI/CD failures (build, test, or lint workflow issues):

1. **Use GitHub MCP tools to inspect job logs directly**:
   - **ALWAYS read workflow logs directly** using GitHub MCP tools (`github-mcp-server-get_job_logs`, `github-mcp-server-list_workflow_runs`)
   - Do NOT rely on assumptions or generic troubleshooting - examine the actual error output
   - Use `list_workflow_runs` to see recent workflow runs and their status
   - Use `get_job_logs` with `failed_only=true` and `return_content=true` to retrieve logs from failed jobs
   - These tools provide direct access to workflow run details and logs without needing to manually check GitHub UI

2. **Running lintr locally**:
   - You can run `lintr` yourself using R to verify linting issues
   - Ensure all required packages are installed before running the linter
   - The lint workflow configuration is in `.github/workflows/lint-changed-files.yaml`

### Fixing Lint Workflow Failures Due to Missing Packages

If the lint workflow fails with errors like "Could not find exported symbols for package X":

1. **Check if the package is already in DESCRIPTION**:
   - Look in `Imports:` or `Suggests:` sections
   - If it's in `Suggests:`, it won't be installed by default in CI

2. **Preferred solution**: Ensure the lint workflow installs all dependencies:
   - Use `dependencies: '"all"'` in `setup-r-dependencies` to install both `Imports` and `Suggests`
   - This is better than manually listing packages in the workflow

3. **Install system dependencies if needed**:
   - Some R packages require system libraries (e.g., `rjags` requires JAGS)
   - Add a step before `setup-r-dependencies` to install system packages
   - Example: `sudo apt-get update && sudo apt-get install -y jags`

4. **Alternative**: Move the package from `Suggests` to `Imports` if it's truly required for the package to function

## R Package Management

This repository uses `renv` for reproducible R package environments:

- Package versions are locked in `renv.lock`
- All workflows use `r-lib/actions/setup-renv@v2` for dependency installation
- CI dependencies (gh, lintr, purrr, pkgdown) are listed in DESCRIPTION Suggests

## System Dependencies

Some R packages require system-level libraries to compile from source:
- `curl` package requires `libcurl4-openssl-dev`
- `png` package requires `libpng-dev`
- `jpeg` package requires `libjpeg-dev`
- `systemfonts` package requires `libfontconfig1-dev`
- `igraph` (used by `ggdag` for DAG figures such as `fig-dag-heat-deaths`) requires `libglpk40` (runtime dependency — needed even when installing pre-compiled binaries) — install with `sudo apt-get install -y libglpk40`; without it a local `quarto render` halts with `Error in dyn.load(...): libglpk.so.40: cannot open shared object file`
- Consider using `rocker/verse` Docker image for workflows to reduce installation requirements

## JAGS Dependencies

This repository uses JAGS (Just Another Gibbs Sampler) for Bayesian analysis:
- JAGS must be installed in workflows that render Quarto documents (using `sudo apt-get install -y jags`)
- R packages `rjags` and `runjags` depend on JAGS being installed
- The lint workflow also needs these packages installed to avoid false positives

## Quarto Slide Breaks

Use `{{< slidebreak >}}` instead of raw `---` to insert slide breaks in `.qmd` files.
The `{{< slidebreak >}}` shortcode produces a slide break only in `revealjs` output,
and produces no output in other formats (HTML, PDF, etc.).
This allows the same source file to render correctly across multiple output formats.

Example:

```markdown
## Slide 1

Content here.

{{< slidebreak >}}

## Slide 2

More content.
```

## Computer Algebra Systems (CAS)

The Copilot environment includes two computer algebra systems for symbolic mathematics.
Use them to verify or derive formulas, derivatives, integrals, and algebraic simplifications
when working on the mathematical content in this repository.

### SymPy (Python)

SymPy is available as `python3 -c "import sympy; ..."` or in a Python script.
It supports symbolic differentiation, integration, equation solving, simplification, and LaTeX output.

```python
from sympy import symbols, diff, integrate, simplify, solve, latex, exp, log

x, mu, sigma = symbols('x mu sigma', real=True)

# Differentiate the normal log-likelihood with respect to mu
log_lik = -((x - mu)**2) / (2 * sigma**2)
score = diff(log_lik, mu)
print(score)          # (x - mu) / sigma**2
print(latex(score))   # \frac{x - \mu}{\sigma^{2}}
```

Common SymPy operations:
- `diff(expr, x)` — symbolic derivative
- `integrate(expr, x)` — symbolic integral
- `solve(expr, x)` — solve equation for x
- `simplify(expr)` — algebraic simplification
- `latex(expr)` — convert to LaTeX string for use in `.qmd` files
- `factor(expr)` / `expand(expr)` — factor or expand polynomials

### Maxima

Maxima is available from the shell as the `maxima` command.
It is a full-featured CAS with strong support for calculus and algebra.

```bash
# Single expression (non-interactive)
echo "diff(x^3 + 2*x^2 - x - 2, x);" | maxima --very-quiet

# Multi-step batch computation saved to a file
cat > /tmp/cas_check.mac << 'EOF'
expr: x^3 + 2*x^2 - x - 2;
factor(expr);
diff(expr, x);
integrate(expr, x);
EOF
maxima --very-quiet --batch=/tmp/cas_check.mac
```

### When to use CAS tools

- **Verifying derivations**: Check that hand-derived formulas match CAS output before including them in documents.
- **Generating LaTeX**: Use `sympy.latex()` to produce correct LaTeX for complex expressions.
- **Solving equations**: Use `sympy.solve()` or Maxima's `solve()` to find closed-form solutions.
- **Simplifying expressions**: Use `sympy.simplify()` or Maxima's `ratsimp()` to confirm algebraic equivalences.

## Quarto Rendering

**CRITICAL REQUIREMENTS** before requesting code review:

1. **Run `quarto render <chapter.qmd> --to html`** on each chapter whose subfiles you edited — do NOT render the full book, and do NOT render all formats unless you are specifically fixing a non-HTML format issue
2. **Verify it completes successfully** (exit code 0, no errors)
3. **Do NOT rely solely on CI workflows** to catch rendering issues
4. **Test the actual command and wait for completion** - do not assume success
5. **Check exit code to confirm success** - partial output doesn't count
6. **If quarto render fails locally**, investigate and fix the issue before pushing changes

**What "successful rendering" means**:
- The command completes without errors (exit code 0)
- All expected output files are generated
- No error messages in the output
- All documents render correctly (check for missing images, broken math, etc.)

**Common mistakes to avoid**:
- Rendering all chapters when only a few subfiles changed (only render chapters with edited subfiles)
- Rendering all output formats when only HTML is needed (use `--to html` unless fixing a specific format issue)
- Not waiting for the command to complete
- Assuming success without checking the exit code
- Claiming "it works" without actually running the command
- Relying on CI to catch rendering issues

This ensures all dependencies are properly configured and all documents render successfully.

## Linting

**CRITICAL**: Always lint changed files before requesting code review and before committing.

```r
# Lint R code files you modified
lintr::lint("path/to/modified/file.R")

# Lint Quarto documents (lints R code chunks)
lintr::lint("path/to/modified/file.qmd")

# Lint all R files in the repository (use sparingly)
lintr::lint_dir()
```

**When to lint**:
- Before calling the `code_review` tool
- After making changes to R files (`.R`) or Quarto documents (`.qmd`)
- Before committing code changes

**Linting workflow for changed files**:
1. Identify which files you've changed
2. For `.R` files: Run `lintr::lint("filename.R")` on each changed file
3. For `.qmd` files: Run `lintr::lint("filename.qmd")` on each changed file to lint R code chunks
4. Fix any linting errors or warnings
5. Only then proceed to code review

**Important notes**:
- **Only fix lint issues in code you wrote or modified** - do not fix pre-existing issues in unchanged code
- If lint errors exist in code you didn't change, ignore them - they're not your responsibility
- The lint-changed-files workflow will flag issues, but you should catch them locally first

## Spell Checking

**CRITICAL**: Always run spellcheck locally BEFORE committing.

```r
# Run spell check on the entire repository
spelling::spell_check_package()

# Check specific files
spelling::spell_check_files("README.md")
spelling::spell_check_files("path/to/modified/file.qmd")
```

**Spell checking workflow**:
1. Identify which files you've changed
2. Run `spelling::spell_check_package()` to check all documentation
3. Review any spelling errors found
4. Either fix the spelling errors OR add legitimate technical terms to `inst/WORDLIST` (create this file if it doesn't exist, one word per line)
5. Re-run spell check to verify all errors are resolved
6. Only then proceed to code review or commit

**Important notes**:
- **Only fix spelling errors you introduced** - ignore pre-existing errors in unchanged files
- Add legitimate technical terms (e.g., "renv", "Bayesian", "MCMC") to `inst/WORDLIST`
- Don't add typos to the wordlist - fix the typos instead

## Code Review Workflow

**MANDATORY ORDER OF OPERATIONS** before finalizing a pull request:

1. **Lint changed files FIRST**
   - Run `lintr::lint()` on all changed `.R` and `.qmd` files
   - Fix any linting errors or warnings
   - See the "Linting" section above for detailed commands

2. **Run spellcheck**
   - Run `spelling::spell_check_package()`
   - Fix spelling errors you introduced or add legitimate terms to `inst/WORDLIST`

3. **Then request code review**
   - Use the `code_review` tool to get automated feedback
   - The tool must be called AFTER linting and spellcheck are complete
   - Review and address any valid comments from the code review

4. **Finally run security checks**
   - Use the `codeql_checker` tool after code review
   - Address any security vulnerabilities found
   - Re-run if you make significant changes

**CRITICAL**: Never call `code_review` without linting and spell-checking changed files first. Linting and spell-checking catch basic issues that should be fixed before more comprehensive code review.

## Determining Responsibility for Workflow Failures

**IMPORTANT**: Not all workflow failures are your responsibility to fix.

**You ARE responsible for** fixing workflow failures if:
- The failure is in code or files you directly modified
- The failure is caused by changes you introduced (e.g., new dependencies, configuration changes)
- The error message indicates an issue with YOUR specific changes

**You are NOT responsible for** fixing workflow failures if:
- The failure is in pre-existing code you didn't modify
- Lint errors exist in unchanged files or unchanged sections of files
- Spelling errors exist in files you didn't modify
- The workflow itself has an environment or infrastructure issue (e.g., package installation failures, Docker issues)
- The error occurs in lines of code that existed before your changes

**How to determine responsibility**:
1. Check the workflow logs to identify which files/lines are causing the failure
2. Use `git diff` or `git show` to verify whether you modified those specific lines
3. If you only modified prose (text/comments) but errors are in code blocks, those are pre-existing
4. If the error is "file X line Y" and you didn't touch line Y, it's pre-existing

**What to do**:
- **If it's your responsibility**: Fix the issue and re-run the workflow
- **If it's NOT your responsibility**: Document it in your PR description and notify the repository maintainer
- **Never** fix unrelated pre-existing issues - focus on your changes only

