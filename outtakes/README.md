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
The `.Rmd` files are old R Markdown drafts;
several carry vignette headers, but none was ever in `vignettes/`.
The "Status" column says whether the text is already in the notes.

| File | What it holds | Status |
| --- | --- | --- |
| `_class3.Rmd` | A one-sample t-test on simulated data, computed by hand and with `t.test()`, and the matching z-interval | Not in the notes |
| `correlation-causation.png` | The figure that `_intro-causal.qmd` shows | Used only by `_intro-causal.qmd` |
| `_dobson-carbs.qmd` | A tabset that loads Dobson's `carbohydrate` data, cuts age and weight into quartile groups, fits an interaction model and plots the data by group | Not in the notes |
| `_dobson-stroke-bayes-Sec-14.6.qmd` | A draft Bayesian analysis of Dobson's stroke data with `runjags` (Section 14.6 of Dobson and Barnett); its last chunk refers to an undefined `jags.post0` | Not in the notes |
| `_equationomatic.Rmd` | A demonstration of `equatiomatic::extract_eq()` on a linear model and on the Poisson example from `?glm` | Not in the notes |
| `_exm-smoking-heart-attack.qmd` | The start of an example: one scientific question about death rates | Not in the notes |
| `_intercept-only-logistic-regression.Rmd` | An intercept-only `glm()` on simulated binary data; despite the file name, it fits a Gaussian family | Not in the notes |
| `_intro-causal.qmd` | A short draft introduction to causal inference, with the figure `correlation-causation.png` | Its last line, "No causes in, no causes out", is in `chapters/causal-inference.qmd`; the rest is not |
| `_learning-R.qmd` | A heading and one link, to Simon Wood's notes on debugging R and C code | Duplicate: the same link is in `chapters/intro-to-R.qmd` |
| `_lm_outtakes.Rmd` | Draft lecture text on maximum likelihood for regression, the conditionally Gaussian outcome, interpreting the slope, and penguin plots | Overlaps `chapters/Linear-models-overview.qmd`, which also uses the penguin data; not compared line by line |
| `_notation.Rmd` | A list of notational conventions (random variables, observed data, parameters, mass and density, expectation) | Not compared with the notes |
| `_outtakes.Rmd` | Draft lecture text on subpopulations, curved fits, interactions and the motivation for link functions, with penguin plots and the start of Bliss's beetle example | Overlaps `chapters/Intro-to-GLMs.qmd`, which also uses the penguin and beetle data; not compared line by line |
| `_printr.qmd` | A demonstration of `printr`, which prints an R help page (`?bmt`) into the document | Not in the notes |
| `_qqplots.Rmd` | Code reproducing the `qqnorm()` plotting positions and QQ line by hand, copied from an RPubs post by Mark Heckmann | Largely covered by `_subfiles/Linear-models-overview/_sec_linreg_diag_qqplot.qmd` |
| `_survminer.qmd` | Kaplan-Meier and Cox fits to the uncensored `colon` data, plotted with `survminer`, with a Weibull CDF overlaid | Not in the notes |
