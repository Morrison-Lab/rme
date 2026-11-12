# Common Mistakes

Code

- [Show All Code](javascript:void(0))

- [Hide All Code](javascript:void(0))

- 

  ------------------------------------------------------------------------

- [View Source](javascript:void(0))

Published

Last modified: 2026-11-12: 7:37:46 (UTC)

------------------------------------------------------------------------

# Configuring R

Functions from these packages will be used throughout this document:

Show R code

``` downlit
library(conflicted) # check for conflicting function definitions
# printr is not loaded here: it inserts help-file output into markdown output
library(rmarkdown) # Convert R Markdown documents into a variety of formats.
library(pander) # format tables for markdown
library(ggplot2) # graphics
library(ggfortify) # help with graphics
library(dplyr) # manipulate data
library(tibble) # `tibble`s extend `data.frame`s
library(magrittr) # `%>%` and other additional piping tools
library(haven) # import Stata files
library(knitr) # format R output for markdown
library(tidyr) # Tools to help to create tidy data
library(plotly) # interactive graphics
library(dobson) # datasets from Dobson and Barnett 2018
library(parameters) # format model output tables for markdown
library(haven) # import Stata files
library(latex2exp) # use LaTeX in R code (for figures and tables)
library(fs) # filesystem path manipulations
library(survival) # survival analysis
library(survminer) # survival analysis graphics
library(KMsurv) # datasets from Klein and Moeschberger
library(parameters) # format model output tables for
library(webshot2) # convert interactive content to static for pdf
library(forcats) # functions for categorical variables ("factors")
library(stringr) # functions for dealing with strings
library(lubridate) # functions for dealing with dates and times
# Summarizes key information about statistical objects in tidy tibbles
library(broom)
# Provides suite of functions to work with regression model
# `broom::tidy()` tibbles
library(broom.helpers)
```

Here are some R settings I use in this document:

Show R code

``` downlit
rm(list = ls()) # delete any data that's already loaded into R

conflicts_prefer(dplyr::filter)
ggplot2::theme_set(
  ggplot2::theme_bw() +
    # ggplot2::labs(col = "") +
    ggplot2::theme(
      legend.position = "bottom",
      text = ggplot2::element_text(size = 12, family = "serif")
    )
)

knitr::opts_chunk$set(message = FALSE)
options(digits = 6)

panderOptions("big.mark", ",")
pander::panderOptions("table.emphasize.rownames", FALSE)
pander::panderOptions("table.split.table", Inf)
# use the `filter()` function from dplyr() by default
conflicts_prefer(dplyr::filter)
legend_text_size <- 9
run_graphs <- TRUE
```

# 1 Parameters versus random variables

The parameters of a probability distribution shouldn’t involve the [random variables](https://morrison-lab.github.io/pds/random-variables.html#def-random-variable) being modeled:

> **WARNING:**
>
> $$X \sim Pois(\lambda)$$ $$\hat{\lambda}_{ML} \rightarrow_D N(\bar{X}, \lambda/n)$$

> **NOTE:**
>
> *Solution*. $$\hat{\lambda}_{ML} \rightarrow_D N(\lambda, \lambda/n)$$

[Expectations](https://morrison-lab.github.io/pds/expectation.html#def-expectation) are means, not sums, despite the similarity of $\Sigma$ and $\text{E}$. Really, we should use $\mu$ instead of $\text{E}$.

# 2 Regression modeling

Each mistake in this section is shown in a warning callout, followed by a corrected version.

## 2.1 Logistic-regression coefficients are log odds ratios

In a logistic regression model, a coefficient $\beta_j$ is a difference in [log-odds](../chapters/binary-outcome-associations.llms.md#def-logodds), so ${\operatorname{exp}\mathopen{}\left\{\beta_j\right\}\mathclose{}}$ is an [odds ratio](../chapters/binary-outcome-associations.llms.md#def-OR) (see the [odds ratio theorem for logistic regression](../chapters/logistic-regression.llms.md#thm-logistic-OR)), not a [risk ratio](../chapters/binary-outcome-associations.llms.md#def-RR):

> **WARNING:**
>
> “${\operatorname{exp}\mathopen{}\left\{\beta_1\right\}\mathclose{}} = 1.5$, so a one-unit increase in $x_1$ makes the outcome 50% more likely.”

> **NOTE:**
>
> *Solution*. “${\operatorname{exp}\mathopen{}\left\{\beta_1\right\}\mathclose{}} = 1.5$, so a one-unit increase in $x_1$ multiplies the **odds** of the outcome by 1.5, holding the other covariates fixed: $\text{ϙ}_{\omega}(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}},\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}}) = 1.5$ when $\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}$ and $\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}}$ differ by one unit in $x_1$ only.”

## 2.2 Odds ratios approximate risk ratios only for rare outcomes

The [odds ratio](../chapters/binary-outcome-associations.llms.md#def-OR) equals the [risk ratio](../chapters/binary-outcome-associations.llms.md#def-RR) times the correction factor $\frac{1-\pi_2}{1-\pi_1}$ (see the [odds ratio correction-factor theorem](../chapters/binary-outcome-associations.llms.md#thm-rare-disease-or-rr)). That correction factor is close to 1 only when both risks are small.

> **WARNING:**
>
> $\pi_1 = 0.4$, $\pi_2 = 0.2$, odds ratio $= 2.67$: “exposed participants had 2.67 times the risk of unexposed participants.”

> **NOTE:**
>
> *Solution*. The risk ratio is $\frac{\pi_1}{\pi_2} = \frac{0.4}{0.2} = 2$. The odds ratio is $\frac{0.4/0.6}{0.2/0.8} = \frac{0.667}{0.25} = 2.67$, which equals $2 \cdot \frac{0.8}{0.6}$. Report “2.67 times the odds”, or estimate the risk ratio directly.

## 2.3 Poisson rate models need an offset

When subjects have different amounts of follow-up time $t$, a Poisson model for an event rate includes ${\operatorname{log}\mathopen{}\left\{t\right\}\mathclose{}}$ as an [offset](https://morrison-lab.github.io/pds/distributions.html#def-offset) (see the [Poisson rate model’s mean](../chapters/count-regression.llms.md#eq-mean-poisson)). Without the offset term, the model describes expected counts, not rates, and ${\operatorname{exp}\mathopen{}\left\{\beta_j\right\}\mathclose{}}$ is a ratio of expected counts rather than a [rate ratio](../chapters/count-regression.llms.md#thm-poisson-rate-ratio).

> **WARNING:**
>
> Group A: 10 events in 1000 person-years; group B: 10 events in 500 person-years. A Poisson model fit to the counts alone gives ${\operatorname{exp}\mathopen{}\left\{\hat{\beta}_1\right\}\mathclose{}} = 10/10 = 1$: “the groups have the same event rate.”

> **NOTE:**
>
> *Solution*. Include ${\operatorname{log}\mathopen{}\left\{t\right\}\mathclose{}}$ as an offset (in R, `offset(log(t))` in the model formula). The [incidence rates](../chapters/intro-to-survival-analysis.llms.md#def-incidence-rate) are $10/1000 = 0.01$ and $10/500 = 0.02$ events per person-year, so the rate ratio for A versus B is $0.01/0.02 = 0.5$.

## 2.4 Hazard ratios are not ratios of survival probabilities

A [hazard ratio](../chapters/intro-to-survival-analysis.llms.md#def-hazard-ratio) compares [hazards](../chapters/intro-to-survival-analysis.llms.md#def-hazard), which are instantaneous event rates, not [survival probabilities](../chapters/intro-to-survival-analysis.llms.md#def-surv-fn). Under proportional hazards, $\operatorname{S}(t|\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}) = \mathopen{}\left[\operatorname{S}_0(t)\right]\mathclose{}^{\theta_{{\lambda}}(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}})}$ (see the [proportional hazards survival theorem](../chapters/proportional-hazards-models.llms.md#thm-ph-surv)), so the hazard ratio enters the survival function as an exponent, not as a multiplier.

> **WARNING:**
>
> $\text{ϙ}_{{\lambda}}(t| \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}: \mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}}) = 2$ and $\operatorname{S}(t|\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}}) = 0.8$: “the exposed group has half the probability of surviving to $t$, $\operatorname{S}(t|\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}) = 0.4$.”

> **NOTE:**
>
> *Solution*. $\operatorname{S}(t|\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}) = 0.8^2 = 0.64$, so the ratio of survival probabilities is $0.64/0.8 = 0.8$, and the ratio of cumulative risks is $\frac{1-0.64}{1-0.8} = \frac{0.36}{0.2} = 1.8$. Neither ratio equals the hazard ratio of 2.

## 2.5 Censored observations are not event-free

A [right-censored](../chapters/intro-to-survival-analysis.llms.md#def-right-censor) observation tells us only that the event had not occurred by the end of that subject’s follow-up; the subject might have had the event later.

> **WARNING:**
>
> Of 100 participants, 20 had the event and 30 were censored before 5 years: “the 5-year risk is $20/100 = 0.2$, since the censored participants did not have the event.”

> **NOTE:**
>
> *Solution*. Counting censored participants as event-free for the whole period biases the estimated risk downward. Use a survival-analysis method that keeps each censored participant in the [risk set](../chapters/intro-to-survival-analysis.llms.md#def-risk-set) only until their censoring time, such as the [Kaplan-Meier estimator](../chapters/intro-to-survival-analysis.llms.md#def-KM-estimator) or a proportional hazards model, under the assumption of [non-informative censoring](../chapters/intro-to-survival-analysis.llms.md#def-noninformative-censoring).

# 3 R

## 3.1 Don’t copy-paste code

Successful programmers don’t use copy-paste! [Write functions instead.](https://r4ds.hadley.nz/functions#introduction)

# 4 Quarto

## 4.1 Separate divs and slide breaks

Make sure not to put a div `:::` on the next line after a slide break `---`:

    ---
    ::: notes
    :::

There needs to be an empty line between them:

    ---

    ::: notes
    :::

## 4.2 `library(printr)` currently breaks `df-print: paged`

See <https://github.com/yihui/printr/issues/41>

# 5 LaTeX

- don’t use `align*` or `align*` in quarto; only `aligned`

Double superscript issues: <https://www.overleaf.com/learn/latex/Errors/Double_superscript>

Back to top
