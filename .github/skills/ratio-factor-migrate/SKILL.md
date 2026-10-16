---
name: ratio-factor-migrate
description: Apply the ratio-vs-factor macro convention to rme math notation --- generic \ratio when inputs are the quantities themselves, type-subscripted \ror/\hr/etc. only for covariate-pattern inputs, and \hazfactor/\oddsfactor/etc. for one-pattern-vs-baseline factors. Use when editing .qmd math that compares odds/hazards/rates/risks, or when asked to apply the ratio/factor convention.
argument-hint: Optionally provide a chapter or subfile path to migrate
---

Apply the ratio-vs-factor macro convention
from `latex-macros/macros.qmd`
when writing or migrating math
that compares two quantities
(odds, hazards, rates, risks, prevalences, cumulative hazards, survival).

This skill is for notation, not content rewriting.
Classify each occurrence, then edit to the matching macro.

## The convention

Pick the macro by **what the inputs are**:

1. **Generic ratio `\ratio` --- inputs are the quantities themselves.**
   When the two things divided are the actual odds/hazards/rates
   (not covariate patterns), use the generic macro:
   `\ratio(\odds_1, \odds_2)`, `\ratiof{...}`.
   The type of ratio is already clear from the inputs,
   so do **not** subscript it ---
   write `\ratio(\odds_1, \odds_2)`, **not** `\ror(\odds_1, \odds_2)`.

2. **Type-subscripted ratio `\ror`/`\hr`/… --- inputs are covariate patterns.**
   When the inputs are covariate patterns (e.g. `\vx`, `\vxs`),
   the subscript is needed to say which kind of ratio it is:
   - `\ror(\vx, \vxs)` --- odds ratio
   - `\hr(t \mid \vx : \vxs)` / `\hazratio` --- hazard ratio
   - `\rateratio`, `\riskratio`, `\prevratio`, `\cuhazratio` --- likewise.

3. **Factor `\hazfactor`/`\oddsfactor`/… --- one pattern vs. the implicit baseline.**
   A factor compares **one** covariate pattern to the implicit baseline pattern
   (e.g. the Cox risk score `\hazfactor(\vx)`).
   Always use the subscripted factor macros:
   `\hazfactor`, `\oddsfactor`, `\ratefactor`, `\riskfactor`,
   `\prevfactor`, `\cuhazfactor`, `\survfactor`.
   Function forms: `\hazfactorf`/`\hazff`, `\oddsfactorf`/`\oddsff`, etc.

Mnemonic: **ratio = two things compared; factor = one thing vs. the baseline.**

## Available macros (in `latex-macros/macros.qmd`)

- Generic: `\ratio` (= `\theta`), `\ratiof{·}`; `\factor` (= `\theta`), `\factorf{·}`.
- Subscripted ratios: `\ror` (odds, fn `\orf`),
  `\hazratio`/`\hr`/`\rhaz`/`\hazr` (hazard, fn `\hrf`/`\rhazf`/`\hazrf`),
  `\rateratio`/`\rater`/`\rrate` (fn `\rateratiof`/`\raterf`/`\rratef`),
  `\riskratio`/`\rrisk`/`\riskr` (fn `\riskratiof`/`\rriskf`/`\riskrf`),
  `\prevratio`/`\prr` (fn `\prevratiof`/`\prrf`),
  `\cuhazratio`/`\rcuhaz`/`\cuhazr` (fn `\cuhazratiof`/`\rcuhazf`/`\cuhazrf`),
  `\survratio`/`\rsurv`/`\survr` (fn `\survratiof`/`\rsurvf`/`\survrf`).
  Every subscripted ratio macro has a corresponding `-f` function form.
- Subscripted factors: `\oddsfactor`, `\hazfactor`, `\ratefactor`, `\riskfactor`,
  `\prevfactor`, `\cuhazfactor`, `\survfactor`;
  function forms `\oddsfactorf`/`\oddsff`, `\hazfactorf`/`\hazff`,
  `\ratefactorf`/`\rateff`, `\riskfactorf`/`\riskff`,
  `\prevfactorf`/`\prevff`, `\cuhazfactorf`/`\cuhazff`,
  `\survfactorf`/`\survff`.
  Short aliases (`\f`-prefix): `\fodds`/`\foddsf`, `\fhaz`/`\fhazf`,
  `\frate`/`\fratef`, `\frisk`/`\friskf`, `\fprev`/`\fprevf`,
  `\fcuhaz`/`\fcuhazf`, `\fsurv`/`\fsurvf`; generic `\ff` = `\factorf`.

Before relying on a name, confirm it still exists:

`grep -nE '\\(def|providecommand)\\(ratio|ror|hr|hazratio|hazfactor|oddsfactor)' latex-macros/macros.qmd`

Note: `\providecommand`-defined macros (the `-f` function forms like
`\ratiof`, `\hrf`, `\survfactorf`) won't appear in this output, because the
pattern matches `\def\name` / `\providecommand\name` but not the braced
`\providecommand{\name}` form those use. Drop the `\\` before the name
group (e.g. `'\\(def|providecommand)\{?\\(...)'`) to catch both.

## Workflow

1. **Find candidates.**
   Search the target chapter/subfile(s)
   for raw or mis-subscripted ratio/factor notation:
   `grep -nE '\\ror\(|\\hr\(|\\ratio\(|\\hazfactor|\\frac\{.*odds.*\}\{.*odds' chapters/<file>.qmd _subfiles/*.qmd`
2. **Classify each occurrence** by its inputs:
   quantities → `\ratio`;
   covariate patterns → subscripted ratio;
   one pattern vs. baseline → factor.
   The most common fix is `\ror(\odds_1, \odds_2)` → `\ratio(\odds_1, \odds_2)`
   (inputs are odds, not patterns).
3. **Edit** with the appropriate macro.
   Don't touch `macros.qmd` itself unless a needed macro is missing ---
   and **never add comments to `macros.qmd`**
   (`%` breaks the macros-table parser;
   HTML comments break the LaTeX/PDF render).
4. **Preflight before committing** (mandatory checklist):
   render each affected parent chapter to HTML,
   lint changed `.qmd`, spellcheck.
   Use the repo's `render` / `lint` / `spell` / `quarto-preflight` skills.

## Behavior rules

- Don't bulk find-and-replace `\ror` → `\ratio`:
  the right target depends on whether the inputs are quantities or covariate patterns.
  Classify each occurrence.
- This migration was gated on the macros change landing;
  if the generic/subscripted macros aren't yet present in `macros.qmd`,
  confirm that change merged before migrating source.
