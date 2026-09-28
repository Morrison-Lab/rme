# CLAUDE.md — rme (Regression Models for Epidemiology)

## Project Overview

This is a Quarto-based textbook/lecture-notes R package for Epi 204 at UC Davis.
Content lives in `.qmd` files; chapters include subfiles from `_subfiles/`.
The repo is also an R package (`DESCRIPTION`) using `renv` for reproducible environments.

## Build & Test Commands

```bash
# Render a single chapter (HTML only — do NOT render the full book)
quarto render <chapter.qmd> --to html

# Lint changed R or .qmd files
Rscript -e 'lintr::lint("path/to/file.R")'
Rscript -e 'lintr::lint("path/to/file.qmd")'

# Spell check
Rscript -e 'spelling::spell_check_package()'
```

## Pre-Commit Checklist (MANDATORY)

Before committing any `.qmd`, `.R`, or config file change:

1. Run `quarto render <chapter.qmd> --to html` on each **parent chapter** whose subfiles were edited
2. Run `lintr::lint()` on each changed `.R` / `.qmd` file — fix only issues in code you changed
3. Run `spelling::spell_check_package()` — fix errors you introduced; add technical terms to `inst/WORDLIST`
4. Only commit after all three pass

**CI is not the test. Never rely on CI to catch rendering, lint, or spelling errors.**

## Key Conventions

### File Structure
- Subfiles (`_subfiles/`) must NOT begin with a section heading — place headings in the parent `.qmd`
- Link to `.qmd` source files, not rendered `.html` files
- Aim to keep `.qmd` source files under ~100 lines; split longer files into named subfiles in `_subfiles/`
- `_extensions/` is vendored third-party code — do not review or modify it
- New book pages must be wired into each render profile that should include them — the profiles keep independent page lists, so a page added to only one is missing from the others:
  - `_quarto-website.yml` — the default profile (`profile.default: website` in `_quarto.yml`): add to the `render:` list, and to the navbar if it's a primary/navigable chapter (supplemental pages like appendices can stay in `render:` without a navbar entry)
  - `_quarto-book.yml` — the book/PDF TOC: add to `book.chapters:` (directly or inside a `part:` grouping)
  - `_quarto-handout.yml` — a curated PDF-handout subset with its own `render:` list; add the page here too if it belongs in the handouts

### Quarto
- Use `{{< slidebreak >}}` instead of `---` for slide breaks
- Add `{{< slidebreak >}}` immediately before every theorem-type div (`#thm-`, `#lem-`, `#cor-`, `#prp-`, `#cnj-`, `#def-`, `#exm-`, `#exr-`, `#rem-`, `#sol-`)
- When a subfile begins with a theorem-type div, put the preceding `{{< slidebreak >}}` in the **parent** file (before the `{{< include >}}`), not inside the subfile
  - Exception: when a section heading immediately precedes the div (or the `{{< include >}}` of a subfile that begins with one), the slidebreak may be omitted so the heading shares its slide with the div, rather than producing a title-only slide. Mark the intentional omission with an inline `<!-- ... do not re-flag -->` comment at that spot.
  - `{{< slidebreak >}}` and `---` are **not equivalent** and must not be combined: per `_extensions/slidebreak/slidebreak.lua`, the shortcode only renders a rule in the `revealjs` profile and is a no-op everywhere else, while a bare `---` renders a visible `<hr>` in *every* profile (book, website, PDF handout). When relocating an example/theorem div next to an existing `---` separator, replace that `---` with `{{< slidebreak >}}` rather than adding the shortcode alongside it — leaving both introduces a stray `<hr>` in the non-slide renders.
- Default to `#| code-fold: true` for figure/table chunks
- Use div format (`:::{#fig-...}`) for figures and tables, not chunk-option `fig-cap`/`tbl-cap`
- Do not indent `:::` fenced div markers inside lists
- One source line per major phrase in prose — keeps git diffs readable and review easier
- **Theorem-div headings** (`:::{#exm-...}`, `:::{#def-...}`, etc.): use `####` (level 4) or deeper for the name heading inside the div — using `##` or `###` creates numbered section headings that disrupt document structure and break example/definition numbering.
- **Parenthetical notes and asides** — meta-commentary that isn't core to the main definition/derivation (e.g. "this doesn't actually need theorem X" or "note that X and Y aren't independent here") — should usually go in a `::: notes` div rather than sitting inline in the main prose. `::: notes` renders as a plain aside in the book/website profiles and doubles as [Reveal.js speaker notes](https://quarto.org/docs/presentations/revealjs/presenting.html#speaker-view) in slide profiles, so writing the aside there rather than inline keeps the main text focused and gets slide-mode support for free. See `thm-lotus`'s existing `::: notes` div for precedent.

### Cross-references
- **Within-chapter** (`@id`): use Pandoc `@id` syntax for any element in the same rendered `.html` file — includes the parent chapter and all its `{{< include >}}`d subfiles.
- **Cross-chapter** (`other-chapter.qmd`): this is a Quarto `website` project (not `book`), so `@id` does **not** resolve across `.html` files. For elements in other chapters use an explicit relative link: `[text](other-chapter.qmd#id)`.

### Math Notation
- Use custom macros from `latex-macros/macros.qmd` instead of raw LaTeX
- Key macros: `\E{Y|X=x}`, `\ba`/`\ea`, `\tp{v}`, `\b`, `\g`, `\a`, `\devn(...)`, `\erf{...}`
- Color coding: `\red{...}` for focal/extra terms, `\teal{...}` for shared terms (use `\teal`, not `\blue` — `\teal` reads better in dark mode)
- Use `\eqdef` instead of `=` for any equality that holds **by definition** — both the defining equation in a `{#def-...}` div and the first introduction of new local notation (e.g. the step in a proof where a symbol is first defined). When an equality holds by definition, annotate it with `\eqdef` even inside a proof.
- Include every intermediate step in derivations — do not skip steps. Give
  each algebraic step its own aligned line (one operation per step —
  distribution, substitution, cancellation, approximation), and annotate
  each step with a short parenthetical explanation of the rule, definition,
  or approximation it uses (e.g. a trailing `&& \text{(...)}` column in an
  aligned block, as in `@eq-ph-surv-discretized`). Default to this level of
  explicitness for all derivations. This is a global standing rule from
  `Morrison-Lab/ai-config`'s `shared/writing/math-derivation-steps.md`, which
  also covers the review-side counterpart: a reviewer should name the
  exact gap and the missing operation when a step is skipped, not just
  flag "skipped steps" in general. The `@claude` bot applies this
  automatically via `Morrison-Lab/gha`'s review checklist
  ([gha#228](https://github.com/Morrison-Lab/gha/pull/228)).
- **Matrix dimensions**: always verify dimension compatibility for every matrix expression -- dimensions of each operand must be consistent with the operation
- **Annotate matrix dimensions with underbraces** in display math: use `\underbrace{M}_{m \times n}` for each matrix or vector
- **Zero matrices**: never write bare `\mathbf{0}` in a matrix equation -- subscript dimensions: `\mathbf{0}_{m \times n}`
- **Jacobian**: `\deriv{\vb} \vx` where both are p-vectors produces a p × p Jacobian matrix (not a vector)
- Estimators of vector estimands: the estimator symbol (e.g. `\hat`) goes
  on top of the vector symbol, not inside it — write `\hat{\vec{\mu}}`, not
  `\vec{\hat\mu}`. (Same for `\bar`, `\tilde`, etc.) Use `\v{}`, `\vec{}`, or
  `\vecf{}` — all three work. (`\v` was formerly broken because its
  `\providecommand` definition was a no-op against the LaTeX built-in caron
  accent; it is now defined with `\renewcommand` in `macros.qmd`.)
- Ratios vs. factors:
  - Use the generic `\ratio`/`\ratiof` macro when a ratio's inputs are the **quantities themselves** (the odds, hazards, rates, etc.) — e.g. `\ratio(\odds_1, \odds_2)`, **not** `\ror(\odds_1, \odds_2)` — because the type of ratio is clear from the inputs.
  - Use the type-subscripted ratio macros (`\ror` for odds ratios, `\hazratio`/`\hr` for hazard ratios, `\rateratio`, `\riskratio`, `\prevratio`, `\cuhazratio`, …) only when the inputs are **covariate patterns** (e.g. `\ror(\vx,\vxs)`, `\hr(t\mid\vx:\vxs)`), where the subscript is needed to say which kind of ratio it is.
  - Factors compare **one** covariate pattern to the implicit baseline pattern (e.g. the Cox risk score `\hazfactor(\vx)`); always use the subscripted factor macros (`\hazfactor`, `\oddsfactor`, …; function forms `\hazfactorf`/`\hazff`, …).
- **Estimator indirection (`\est`/`\Est`), added in `latex-macros` #78:** every
  legacy `\h...`-prefixed hat-estimator macro (`\hb`, `\hsurv`, `\hhazratio`,
  `\hskm`, …) now has a parallel `\e...`-prefixed counterpart (`\eb`, `\esurv`,
  `\ehazratio`, `\eskm`, …) composed through the new `\est` (renders `\hat`) /
  `\Est` (renders `\widehat`) indirection macros, instead of applying
  `\hat`/`\widehat` directly. Prefer the `\e...` family in new content — a
  future change to the estimator symbol only requires editing `\est`/`\Est`.
  The `\h...` family is unchanged and stays supported for existing content.
  See `latex-macros/CONTRIBUTING.md` for the full naming convention.

### Citations
- Always use BibTeX keys with `@citekey` Pandoc syntax — never plaintext author-date
- Include chapter/page locators: `[@dobson4e, Chapter 7, p. 194]`
- Only cite a page number after verifying it directly from the source PDF

### Content Writing
- Introduce concepts before using them — no forward references
- Factual claims must have a specific citation
- Variable definitions in exercises: use bullet points/table with symbol, meaning, and dataset column
- After every definition or concept, include a concrete example — preferably numerical — to illustrate the abstract idea; use a `{#exm-...}` div; if a counterexample is feasible, include one immediately after the example
- After every theoretical claim (thm, cor, lem): when a proof is feasible and in scope, (1) immediately follow with a proof, then (2) immediately follow with an example utilizing the claim; when a proof is non-elementary or out of scope (e.g., `@thm-fubini`, `@thm-fubini-tonelli`), omit the proof block and proceed directly to the example
- Always arrange divs and sections so that related items are adjacent: theorem → proof → example(s) → counterexample(s)
- Never use "above" or "below" to refer to content — cross-reference with `@label` syntax instead
- Always add a noun phrase after "This", "That", and "Those" to clarify the referent (e.g., "This estimator", not "This")
- Clearly distinguish **model structure** (how the data relate to the parameters — distributional family, link function, random effects, hierarchies, …) from **inference method** (how the parameters are estimated — MLE, Bayes, GEE, method of moments, …). The two are orthogonal: any model structure can be paired with any compatible inference method (e.g. a random-effects model can be fit by maximum likelihood *or* by Bayesian MCMC). Never write as if a structure belonged to one inference paradigm (avoid e.g. "the Bayesian version of random effects"); instead name the inference method being applied to the structure.

### Pull Requests
- Remove existing review requests immediately when starting work on a PR
- Always merge `main` into the feature branch when starting or resuming work on it
- Merge `main` again before pushing — not just before requesting review
- Verify all changed hyperlinks before requesting review
- If any `_subfiles/` were edited, add the "clear freezer" label
- Workflow / `.github/` / CI / infra changes go in their own dedicated PRs — never mix them with book-content PRs
- **Fact-check prose and reasoning when reviewing content changes**, per the
  global rule in `Morrison-Lab/ai-config`'s `shared/writing/fact-check-prose.md`:
  check factual claims against domain knowledge and external sources, work
  through document-internal reasoning (formal derivations/proofs *and*
  informal arguments) step by step, and verify any computed value or figure
  the prose describes against the actual rendered output — don't take the
  source prose's word for it. Use the PR-preview deploy when available: the
  preview link is posted as a sticky comment on the PR, and the rendered
  files also land on the `gh-pages` branch under `pr-preview/pr-<N>/<path>`
  (e.g. `pr-preview/pr-123/chapter.html`) if the live site needs cross-checking
  against source. If no preview has deployed yet for the changed page, render
  it locally instead (`quarto render <chapter.qmd> --to html`) rather than
  skipping the check.
- This checkout is often shared by concurrent agent sessions — the branch can switch under you, and commits land on PR branches from other sessions or the `@claude` bot. Work in an isolated `git worktree`: for **new** work `git worktree add -b <branch> <dir> origin/main`; to **resume** an existing PR branch `git worktree add -B <branch> <dir> origin/<branch>` (uppercase `-B` so it resets to the remote even if the local branch already exists; the `origin/<branch>` start point picks up the PR rather than starting a fresh branch from `main`). Then run `git submodule update --init` in the new worktree. Before every push, `git fetch` and reconcile `origin/<branch>` (merge or rebase) — another session may have already pushed the same change
- After opening (or when asked to watch) a PR, subscribe to its activity and keep watching until it is merged or closed: confirm CI results, surface review comments, and catch merge conflicts; re-arm a periodic check-in and only ping when something needs the author. Stop immediately if the author asks you to back off.
- **Do not wait indefinitely for CI or review jobs.** When monitoring a PR, if a check has been `in_progress` for more than 5–10 minutes without completion, investigate immediately: check job logs for errors, look for blockers, and either fix issues or report what's stuck. Do not passively wait for slow or hung jobs to finish.

## Workflow Responsibility

You are responsible for fixing failures caused by your changes only.
Do not fix pre-existing lint/spell errors in code you didn't modify.
If a failure is not caused by your changes, document it in the PR description.

## Reporting

When summarizing PRs, issues, workflow runs, or jobs, always include the
GitHub URL alongside the reference (e.g.,
[#897](https://github.com/Morrison-Lab/rme/pull/897), not just "#897").

## ai-config skills and memories

The `ai-config` skills arrive as a **Claude Code plugin**, not a submodule.
`.claude/settings.json` declares the `Morrison-Lab` marketplace
and enables `ai-config@Morrison-Lab`.
Declaring is not installing:
per Claude Code's team-marketplace docs,
a plugin from an external source
"doesn't load until the team member installs it",
so a local session needs `claude plugin install ai-config@Morrison-Lab` once.
CI installs it explicitly instead —
`claude.yml` passes `plugin_marketplaces`/`plugins` to `claude-code-action`,
and `claude-code-review.yml`'s reusable workflow bakes it in.
Plugin skills are namespaced — invoke them as `/ai-config:reprexes`,
`/ai-config:grade-work`, and so on.

The plugin ships the whole `ai-config` repo, not just `skills/`,
so `memories/` and `shared/` come along with it.
There's no Claude Code mechanism that auto-loads a memories folder
the way it does skills,
so read a specific fragment on demand rather than expecting it in context.
Installed plugins live under
`~/.claude/plugins/cache/<marketplace>/<plugin>/<version>/`,
where the version segment is an opaque hash —
so locate the directory (`claude plugin list`, or glob that cache path)
rather than hardcoding it,
then read e.g. `shared/writing/fact-check-prose.md` from inside it.
Don't assume a fragment is unavailable just because a guessed path missed.

## External Resources Available in This Session

- `$EPI202_TOKEN` — fine-grained PAT with read access to
  `https://github.com/ucdavis/epi202` (Epi 202 course materials). Use on
  demand to look up content from that repo; see
  `.github/copilot-instructions.md` → "Accessing the private
  `ucdavis/epi202` repository" for usage snippets. If the variable is
  empty, the repo is unavailable for this session.

- `$EPI204_TOKEN` — fine-grained PAT with read access to
  `https://github.com/ucdavis/epi204` (Epi 204 homework and solutions).
  Use on demand to look up homework/solution content from that repo;
  see `.github/copilot-instructions.md` → "Accessing the private
  `ucdavis/epi204` repository" for usage snippets. If the variable is
  empty, the repo is unavailable for this session.
