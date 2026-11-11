# Summary of Regression Modeling Concepts

Code

- [Show All Code](javascript:void(0))

- [Hide All Code](javascript:void(0))

- 

  ------------------------------------------------------------------------

- [View Source](javascript:void(0))

Published

Last modified: 2026-11-11: 8:13:42 (UTC)

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

# 1 We use different probability models for different data types

- Binary outcomes: [Bernoulli](https://morrison-lab.github.io/pds/random-variables.html#def-bernoulli) models
- [Event rate](https://morrison-lab.github.io/pds/distributions.html#def-event-rate) outcomes: [Poisson](https://morrison-lab.github.io/pds/distributions.html#def-poisson)/[Negative binomial](https://morrison-lab.github.io/pds/distributions.html#def-nb) models
- Time-to-event outcomes: Survival models
- Catch-all: [Gaussian](https://morrison-lab.github.io/pds/random-variables.html#def-normal) models

# 2 We use different link functions to connect these models with covariates

- Bernoulli models: [logit](../chapters/binary-outcome-associations.llms.md#def-logit-fn) link
- Count models: log link + [offset](https://morrison-lab.github.io/pds/distributions.html#def-offset)
- Survival models: log link
- Gaussian models: identity link

[Figure 1](#fig-model-diagrams) shows how the various models we have studied have analogous structures: each row uses model-specific transformations to connect the modeled quantity to a [linear predictor](../chapters/Intro-to-GLMs.llms.md#def-linear-predictor) $\eta(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}) = \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}} \cdot \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}} + \eta_0$.

> **NOTE:**
>
> [Linear](../chapters/Linear-models-overview.llms.md#def-lm-general-form) (Gaussian):
>
> $$\underbrace{\mu}_{\text{mean}}
> \underset{\xleftarrow[]{=}}{\xrightarrow[]{=}}
> \underbrace{\eta(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}) }_{\substack{\text{linear}\\\text{predictor}}}
> = \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}} \cdot \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}} + \mu(0)$$
>
> [Logistic](../chapters/logistic-regression.llms.md#def-logistic-regression) (Binomial):
>
> $$\underbrace{\mu}_{\text{mean}}
> \underset{
>   \xleftarrow[\pi \cdot n]{}
> }{
>   \xrightarrow{\frac{\mu}{n}}
> }
> \underbrace{\pi}_{\text{probability}}
> \underset{
>   \xleftarrow[\frac{\omega}{1+\omega}]{}
> }{
>   \xrightarrow{\frac{\pi}{1-\pi}}
> }
> \underbrace{\omega}_{\text{odds}}
> \underset{
>   \xleftarrow[{\operatorname{exp}\mathopen{}\left\{\eta\right\}\mathclose{}}]{}
> }{
>   \xrightarrow{{\operatorname{log}\mathopen{}\left\{\omega\right\}\mathclose{}}}
> }
> \underbrace{\eta}_{\text{log-odds}} = \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}} \cdot \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}} + \eta(0)$$
>
> Count ([Poisson](https://morrison-lab.github.io/pds/distributions.html#def-poisson)):
>
> $$\underbrace{\mu}_{\text{mean}}
> \underset{
>   \xleftarrow[{\lambda}\cdot t]{}
> }{
>   \xrightarrow{\mu / t}
> }
> \underbrace{{\lambda}}_{\text{rate}}
> \underset{
>   \xleftarrow[{\operatorname{exp}\mathopen{}\left\{\eta\right\}\mathclose{}}]{}
> }{
>   \xrightarrow{{\operatorname{log}\mathopen{}\left\{{\lambda}\right\}\mathclose{}}}
> }
> \underbrace{\eta}_{\text{log-rate}}
> = \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}} \cdot \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}} + {\operatorname{log}\mathopen{}\left\{{\lambda}(0)\right\}\mathclose{}}$$
>
> Survival ([Cox PH](../chapters/proportional-hazards-models.llms.md#def-ph-model)):
>
> $$\underbrace{\mu}_{\text{mean}}
> \xleftarrow[\int_{t=0}^{\infty}{\operatorname{S}(t|\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}})dt}]{}
> \underbrace{\operatorname{S}(t|\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}})}_{\text{survival}}
> \underset{
>   \xleftarrow[{\operatorname{exp}\mathopen{}\left\{-{\Lambda}(t|\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}})\right\}\mathclose{}}]{}
> }{
>   \xrightarrow{-{\operatorname{log}\mathopen{}\left\{\operatorname{S}(t|\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}})\right\}\mathclose{}}}
> }
> \underbrace{{\Lambda}(t|\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}})}_{\text{cumulative hazard}}
> \underset{
>   \xleftarrow[\int_0^t {\lambda}(u|\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}})\,du]{}
> }{
>   \xrightarrow{{\Lambda}'(t|\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}})}
> }
> \underbrace{{\lambda}(t|\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}})}_{\text{hazard}}
> \underset{
>   \xleftarrow[{\operatorname{exp}\mathopen{}\left\{\eta(t|\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}})\right\}\mathclose{}}]{}
> }{
>   \xrightarrow{{\operatorname{log}\mathopen{}\left\{{\lambda}(t|\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}})\right\}\mathclose{}}}
> }
> \underbrace{\eta(t|\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}})}_{\text{log-hazard}}
> = \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}} \cdot \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}} + \eta_0(t)$$
>
> Figure 1: Parallel structures of [GLMs](../chapters/Intro-to-GLMs.llms.md#def-glm) and survival models. Each row shows the transformation chain from the modeled quantity to the linear predictor $\eta(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}) = \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}} \cdot \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}} + \eta_0$, where $\eta_0$ denotes the model-specific intercept term, and $\eta_0(t)$ denotes the Cox PH baseline log-hazard term.

# 3 We use maximum likelihood estimation to fit models to data

- [likelihood](https://morrison-lab.github.io/sds/intro-MLEs.html#def-lik)
- [log-likelihood](https://morrison-lab.github.io/sds/intro-MLEs.html#def-loglik)
- [score function](https://morrison-lab.github.io/sds/intro-MLEs.html#def-score)
- [hessian](https://morrison-lab.github.io/mds/vector-calculus.html#def-hessian)

# 4 We use asymptotic normality of MLEs to quantify uncertainty about models

- [observed information matrix](https://morrison-lab.github.io/sds/intro-MLEs.html#def-oinf)
- [expected information matrix](https://morrison-lab.github.io/sds/intro-MLEs.html#def-einf)
- [standard error](https://morrison-lab.github.io/sds/estimation.html#def-SE)
- [confidence intervals](https://morrison-lab.github.io/sds/inference.html#def-confidence-interval)
- [p-values](https://morrison-lab.github.io/sds/inference.html#def-p-value)

# 5 We use (log) likelihood ratios to compare models

Sometimes we adjust these comparisons for model size ([AIC](../chapters/Linear-models-overview.llms.md#def-aic), [BIC](../chapters/Linear-models-overview.llms.md#def-bic))

# References

Back to top
