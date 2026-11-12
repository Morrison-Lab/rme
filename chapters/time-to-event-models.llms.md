# Time to Event Models

Code

- [Show All Code](javascript:void(0))

- [Hide All Code](javascript:void(0))

- 

  ------------------------------------------------------------------------

- [View Source](javascript:void(0))

Published

Last modified: 2026-11-12: 8:19:34 (UTC)

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

In many health sciences applications, [binary](https://morrison-lab.github.io/sds/data.html#def-binary-var) [outcomes](../chapters/Intro-to-GLMs.llms.md#def-outcome) are *incompletely observed*. For example, if we are studying whether cancer patients experience a relapse after an initial remission, we may not be able to follow patients to the end of their lives; instead, we may only know whether each patient has relapsed before the end of the study. If a patient has not relapsed by that point, we might not know if they will relapse at some other date or if they will stay cancer-free for the rest of their lives. [^1] Their recurrence status at end-of-life is *missing data*. If some study participants withdraw from a study before the scheduled end date, additional missing data arise. Standard [logistic regression](../chapters/logistic-regression.llms.md#def-logistic-regression) cannot handle such [right-censored](../chapters/intro-to-survival-analysis.llms.md#def-right-censor) data directly without introducing [bias](https://morrison-lab.github.io/sds/estimation.html#def-bias).

However, these outcome observations are not *entirely* missing. We know that those patients stayed relapse-free *at least* until the time point when they were last observed. If we also know the *time-to-event* for participants who experienced events while under study, we can analyze the *time-to-event-or-study-exit* alongside an event indicator using *survival analysis*. The survival analysis framework provides the foundation for the topics covered in this module.

# 1 Why censoring matters

> **NOTE:**
>
> **Example 1 (Six patients followed for relapse)** Suppose a study follows six cancer patients in remission for up to 12 months, and we want to estimate the 12-month relapse risk, $1 - {\operatorname{S}\mathopen{}\left(12\right)\mathclose{}}$, where $\operatorname{S}$ is the [survival function](../chapters/intro-to-survival-analysis.llms.md#def-surv-fn) of time to relapse (in months). [Table 1](#tbl-tte-overview-patients) shows each patient’s observed follow-up time and event indicator (1 = relapse observed; 0 = [right-censored](../chapters/intro-to-survival-analysis.llms.md#def-right-censor)).
>
> > **NOTE:**
> >
> > | Patient | Follow-up time (months) | Event indicator | Relapse status at 12 months |
> > |:-------:|:-----------------------:|:---------------:|:----------------------------|
> > |    A    |            3            |        1        | relapsed                    |
> > |    B    |            5            |        0        | unknown (withdrew)          |
> > |    C    |            7            |        1        | relapsed                    |
> > |    D    |            9            |        0        | unknown (withdrew)          |
> > |    E    |           12            |        0        | relapse-free                |
> > |    F    |           12            |        0        | relapse-free                |
> >
> > Table 1: Hypothetical follow-up data for six patients
>
> **Naive approach 1: treat censored patients as event-free.** Counting patients B and D as relapse-free gives $2/6 \approx 0.333$. This approach can only *under*estimate the risk, because any relapses that B or D experienced after withdrawal are counted as non-relapses.
>
> **Naive approach 2: drop patients with unknown status.** Discarding patients B and D gives $2/4 = 0.5$. This approach throws away the information that B stayed relapse-free for 5 months and D for 9 months, so in this example it *over*estimates the risk.
>
> **Using the censored observations.** The [Kaplan-Meier estimator](../chapters/intro-to-survival-analysis.llms.md#def-KM-estimator) keeps each censored patient in the [risk set](../chapters/intro-to-survival-analysis.llms.md#def-risk-set) until their censoring time [\[1, Ch. 2\]](#ref-kleinbaum2012survival). Relapses occur at 3 months (6 patients at risk) and at 7 months (4 patients at risk: C, D, E, F), so
>
> $$\begin{aligned}
> {\mathop{\hat{\operatorname{S}}}\nolimits_{\text{KM}}\mathopen{}\left(12\right)\mathclose{}}
> &= \mathopen{}\left(1 - \frac{1}{6}\right)\mathclose{} \cdot \mathopen{}\left(1 - \frac{1}{4}\right)\mathclose{}
> && \text{(product over the event times 3 and 7)}
> \\
> &= \frac{5}{6} \cdot \frac{3}{4}
> && \text{(subtract inside each factor)}
> \\
> &= \frac{15}{24}
> && \text{(multiply numerators and denominators)}
> \\
> &= 0.625
> && \text{(divide)}
> \end{aligned}$$
>
> and the estimated 12-month risk is $1 - 0.625 = 0.375$. That estimate lies between the two naive estimates, and it is valid under [non-informative censoring](../chapters/intro-to-survival-analysis.llms.md#def-noninformative-censoring) [\[1, Ch. 1\]](#ref-kleinbaum2012survival).

# 2 Module roadmap

This module has three chapters.

1.  [Introduction to Survival Analysis](../chapters/intro-to-survival-analysis.llms.md) defines the basic quantities for time-to-event data: [right censoring](../chapters/intro-to-survival-analysis.llms.md#def-right-censor), the [survival function](../chapters/intro-to-survival-analysis.llms.md#def-surv-fn), the [hazard function](../chapters/intro-to-survival-analysis.llms.md#def-hazard), and the [cumulative hazard](../chapters/intro-to-survival-analysis.llms.md#def-cuhaz). It then covers nonparametric methods: the [Kaplan-Meier estimator](../chapters/intro-to-survival-analysis.llms.md#def-KM-estimator), the [log-rank test](../chapters/intro-to-survival-analysis.llms.md#def-logrank-test), and the [Nelson-Aalen estimator](../chapters/intro-to-survival-analysis.llms.md#def-na-cuhaz-est).

2.  [Proportional Hazards Models](../chapters/proportional-hazards-models.llms.md) introduces the [Cox proportional hazards model](../chapters/proportional-hazards-models.llms.md#def-ph-model), which relates [covariates](../chapters/Intro-to-GLMs.llms.md#def-predictors) to a [baseline hazard](../chapters/proportional-hazards-models.llms.md#def-base-hazard) through [hazard ratios](../chapters/intro-to-survival-analysis.llms.md#def-hazard-ratio), and estimates its coefficients using the [partial likelihood](../chapters/proportional-hazards-models.llms.md#def-ph-partial-lik). It also introduces [competing risks](../chapters/proportional-hazards-models.llms.md#def-competing-risks).

3.  [Parametric Survival Models](../chapters/parametric-survival-models.llms.md) assumes a specific distributional family for the event times, such as the [exponential regression model](../chapters/parametric-survival-models.llms.md#def-exp-reg) and the [Weibull distribution](https://morrison-lab.github.io/pds/distributions.html#def-weibull), and introduces [accelerated failure time models](../chapters/parametric-survival-models.llms.md#def-aft).

Back to top

## References

\[1\]

D. G. Kleinbaum and M. Klein, *Survival analysis: A self-learning text*, 3rd ed. Springer, 2012. Available: <https://link.springer.com/book/10.1007/978-1-4419-6646-9>

## Footnotes

[^1]: Binary outcomes are typically defined *for a specific time-point*. It is important to clearly define whether we are interested in outcome status at end of study, at end of life, or at some other time.
