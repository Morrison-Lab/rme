# Outtakes

This folder keeps drafts and removed text that no page renders or includes,
so that nothing is lost while the repository layout is tidied
([#1462](https://github.com/Morrison-Lab/rme/issues/1462), [#744](https://github.com/Morrison-Lab/rme/issues/744)).
It follows the outtakes convention of `Morrison-Lab/lds`.

- Each `.qmd` or `.Rmd` file here starts with `_`, so Quarto never renders it on its own.
- No render profile lists this folder, and `.Rbuildignore` keeps it out of the R package.
- To reuse a piece, move its text into a subfile under `_subfiles/` and include it from a chapter,
  then remove it from here in the same pull request.

## Contents

Each file was moved here unchanged from the repository root.
The "Status" column says whether the text is already in the notes.

| File | What it holds | Status |
| --- | --- | --- |
| `_dobson-carbs.qmd` | A tabset that loads Dobson's `carbohydrate` data, cuts age and weight into quartile groups, fits an interaction model and plots the data by group | Not in the notes |
| `_dobson-stroke-bayes-Sec-14.6.qmd` | A draft Bayesian analysis of Dobson's stroke data with `runjags` (Section 14.6 of Dobson and Barnett); its last chunk refers to an undefined `jags.post0` | Not in the notes |
| `_exm-smoking-heart-attack.qmd` | The start of an example: one scientific question about death rates | Not in the notes |
| `_intro-causal.qmd` | A short draft introduction to causal inference, with the figure `correlation-causation.png` | Its last line, "No causes in, no causes out", is in `chapters/causal-inference.qmd`; the rest is not |
| `correlation-causation.png` | The figure that `_intro-causal.qmd` shows | Used only by `_intro-causal.qmd` |
| `_learning-R.qmd` | A heading and one link, to Simon Wood's notes on debugging R and C code | Duplicate: the same link is in `chapters/intro-to-R.qmd` |
| `_printr.qmd` | A demonstration of `printr`, which prints an R help page (`?bmt`) into the document | Not in the notes |
| `_survminer.qmd` | Kaplan-Meier and Cox fits to the uncensored `colon` data, plotted with `survminer`, with a Weibull CDF overlaid | Not in the notes |
