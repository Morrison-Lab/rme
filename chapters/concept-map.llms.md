# Concept Map: Definitions and Results

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

This appendix shows how the definitions and [results](https://morrison-lab.github.io/mcs/proof-writing.html#def-theorem) (`def`, `thm`, `lem`, `cor`, `prp` callouts) in the notes depend on one another.

We say result $B$ is a **descendant** of result $A$ if $A$ is referenced inside the [statement](https://morrison-lab.github.io/mcs/proof-writing.html#def-proposition) or [proof](https://morrison-lab.github.io/mcs/proof-writing.html#def-proof) of $B$ (directly, or transitively through a chain of intermediate results). The more descendants a result has, the more of the rest of the notes rests on it — so descendant count is a rough measure of how foundational a result is.

The dependency graph is built by `data-raw/callout-graph.R`, which scans the source `.qmd` files and saves the result to `inst/extdata/callout-graph.rds`. This appendix reads that saved file rather than re-scanning the notes on every render, so **re-run that script whenever divs are added, removed, or re-titled** to refresh the diagram and [Table 1](#tbl-descendants).

Show R code

``` downlit
library(igraph)
library(ggraph)
library(ggrepel)

cg <- readRDS(here::here("inst/extdata/callout-graph.rds"))

type_levels <- c("def", "thm", "lem", "cor", "prp")
type_labels <- c(
  def = "Definition", thm = "Theorem", lem = "Lemma",
  cor = "Corollary", prp = "Proposition"
)
type_palette <- c(
  def = "#1b9e77", thm = "#d95f02", lem = "#7570b3",
  cor = "#e7298a", prp = "#66a61e"
)
```

There are 271 labeled definitions and results in the notes, connected by 129 direct dependency links.

# 1 Dependency diagram

[Figure 1](#fig-concept-map) shows the results that participate in at least one dependency link, laid out so that connected results sit near each other. Color encodes the type of result. Results with no detected dependency links are omitted from the diagram. Node labels are larger for results with more total descendants, so the most foundational results are visually prominent. The most foundational results (most descendants) appear near the center; peripheral results have no or few descendants. Long names are abbreviated in the diagram; [Table 1](#tbl-descendants) gives each result’s full name. Labels are shifted to avoid overlap; a grey line connects a shifted label to its node position. Zoom in with Ctrl+scroll (or pinch on mobile) to read individual labels.

> **NOTE:**
>
> Show R code
>
> ``` downlit
> connected <- cg$nodes$id[cg$nodes$id %in% c(cg$edges$from, cg$edges$to)]
> core <- graph_from_data_frame(
>   cg$edges,
>   vertices = cg$nodes[cg$nodes$id %in% connected, ],
>   directed = TRUE
> )
> V(core)$type <- factor(V(core)$type, levels = type_levels)
>
> set.seed(204)
> # Use Fruchterman-Reingold for angular arrangement (connected nodes cluster
> # together), then override each node's radius so the most foundational nodes
> # land near the center.
> fr_layout <- create_layout(core, layout = "fr", niter = 2000)
> n_desc_vals <- V(core)$n_desc
> fr_angle <- atan2(fr_layout$y, fr_layout$x)
> # log1p radius: nodes with more descendants land closer to center (r = 0);
> # nodes with 0 descendants land at the periphery (r = 1). The log scale
> # compresses the high end so the few top hubs don't crowd the center, and
> # pulls nodes with even a handful of descendants well off the outer rim.
> max_desc <- max(n_desc_vals)
> target_r <- 1 - log1p(n_desc_vals) / log1p(max_desc)
> layout <- fr_layout
> layout$x <- target_r * cos(fr_angle)
> layout$y <- target_r * sin(fr_angle)
>
> # Abbreviate long node labels for the diagram only (the descendants table
> # keeps the full titles). First drop synonym lists -- the text after the first
> # comma -- so e.g. "Expectation, expected value, population mean" becomes
> # "Expectation". Then apply curated short forms for the few names that are
> # still long; extend this map as needed.
> layout$label <- sub(",.*$", "", layout$title)
> short_forms <- c("def-hazard" = "Hazard")
> hit <- match(layout$name, names(short_forms))
> layout$label <- ifelse(is.na(hit), layout$label, short_forms[hit])
> layout$label <- stringr::str_wrap(layout$label, width = 15)
>
> ggraph(layout) +
>   geom_edge_link(
>     arrow = arrow(length = unit(1.8, "mm"), type = "closed"),
>     end_cap = circle(2, "mm"),
>     edge_alpha = 0.25, edge_width = 0.3
>   ) +
>   geom_label_repel(
>     data = as.data.frame(layout),
>     aes(x = x, y = y, label = label, fill = type, size = n_desc),
>     inherit.aes = FALSE,
>     # point.size = NA: suppress the dot so the label itself is the node;
>     # ggrepel still repels labels away from each other to avoid overlap.
>     point.size = NA,
>     color = "white",
>     fontface = "bold",
>     max.overlaps = Inf,
>     force = 3,
>     force_pull = 1,
>     box.padding = unit(0.15, "lines"),
>     label.padding = unit(0.1, "lines"),
>     label.r = unit(0.05, "lines"),
>     label.size = 0.1,
>     alpha = 0.88,
>     segment.color = "grey60",
>     segment.alpha = 0.5,
>     segment.size = 0.3,
>     min.segment.length = unit(0.5, "lines"),
>     seed = 204
>   ) +
>   scale_fill_manual(
>     values = type_palette, labels = type_labels, name = "Type", drop = FALSE
>   ) +
>   scale_size_continuous(range = c(8.0, 16.0), guide = "none") +
>   theme_void() +
>   theme(legend.position = "bottom")
> ```
>
> [![](concept-map_files/figure-revealjs/concept-map-ggraph-1.png)](concept-map_files/figure-revealjs/concept-map-ggraph-1.png "Figure 1: Dependency structure of the definitions and results in the notes. An arrow points from a result to each result that uses it. Color indicates result type (see legend). Label font size is proportional to the number of total descendants; results with more descendants appear closer to the center.")
>
> Figure 1: Dependency structure of the definitions and results in the notes. An arrow points from a result to each result that uses it. Color indicates result type (see legend). Label font size is proportional to the number of total descendants; results with more descendants appear closer to the center.

# 2 Descendants of each result

[Table 1](#tbl-descendants) lists every result that has at least one descendant, sorted by the number of total descendants (direct or transitive).

> **NOTE:**
>
> Show R code
>
> ``` downlit
> ranked <- cg$nodes[cg$nodes$n_desc >= 1, ]
> ranked <- ranked[order(-ranked$n_desc, ranked$id), ]
>
> descendant_table <- data.frame(
>   Result               = ranked$title,
>   Type                 = type_labels[ranked$type],
>   `Direct descendants`  = ranked$n_direct,
>   `Total descendants`   = ranked$n_desc,
>   check.names = FALSE, row.names = NULL, stringsAsFactors = FALSE
> )
>
> knitr::kable(descendant_table, format = "pipe", align = "llrr")
> ```
>
> | Result | Type | Direct descendants | Total descendants |
> |:---|:---|---:|---:|
> | Odds | Definition | 4 | 14 |
> | Odds as a function of probability | Theorem | 4 | 13 |
> | log-odds | Definition | 3 | 10 |
> | Potential mean | Definition | 2 | 8 |
> | Derivative of odds function | Theorem | 3 | 8 |
> | Probability as a function of odds | Theorem | 4 | 8 |
> | Causal marginal risk | Definition | 5 | 7 |
> | Derivative of log-odds by odds | Lemma | 1 | 7 |
> | Conditional predicted risk | Definition | 3 | 6 |
> | logit function | Definition | 3 | 6 |
> | Derivative of odds w.r.t. log-odds | Lemma | 2 | 6 |
> | Derivative of log-odds by odds | Theorem | 1 | 6 |
> | First-order interval failure probability | Definition | 3 | 5 |
> | One-way random-effects model | Definition | 5 | 5 |
> | Risk-set score total | Definition | 2 | 5 |
> | Causal marginal risk under identification assumptions | Theorem | 3 | 5 |
> | Derivative of log-odds by probability | Theorem | 2 | 5 |
> | G-computation | Definition | 3 | 4 |
> | Hazard function, hazard rate, hazard rate function | Definition | 3 | 4 |
> | Derivative of odds in terms of probability | Theorem | 1 | 4 |
> | Derivative of inverse odds function | Theorem | 1 | 4 |
> | Proportional-hazards decomposition of the hazard | Theorem | 1 | 4 |
> | expit, logistic, inverse-logit | Definition | 2 | 3 |
> | inverse odds function | Definition | 2 | 3 |
> | Proportional-hazards first-order interval failure probability | Definition | 1 | 3 |
> | Cox proportional hazards model | Definition | 1 | 3 |
> | Point-mass optimality of the profile baseline hazard | Lemma | 1 | 3 |
> | Derivative of probability w.r.t. log-odds | Theorem | 3 | 3 |
> | Marginal risk as a conditional expectation | Theorem | 3 | 3 |
> | Odds via the odds function | Corollary | 1 | 2 |
> | Cox-Snell generalized residuals | Definition | 2 | 2 |
> | Leverage for a GLM | Definition | 2 | 2 |
> | Observed marginal risk | Definition | 2 | 2 |
> | Odds function | Definition | 1 | 2 |
> | Odds ratio | Definition | 2 | 2 |
> | Pearson residual | Definition | 1 | 2 |
> | Cox PH partial likelihood | Definition | 2 | 2 |
> | Risk Score | Definition | 1 | 2 |
> | Derivative of log-odds with respect to coefficients | Lemma | 2 | 2 |
> | Simplified expression for inverse odds function | Lemma | 1 | 2 |
> | Odds from log-odds | Lemma | 1 | 2 |
> | One minus inverse-odds | Lemma | 2 | 2 |
> | Profile likelihood in terms of point masses | Lemma | 2 | 2 |
> | Single-subject failure probability in a risk set | Lemma | 2 | 2 |
> | Consistency of g-computation | Theorem | 2 | 2 |
> | Inverse-odds function inverts the odds function | Corollary | 1 | 1 |
> | Akaike Information Criterion (AIC) | Definition | 1 | 1 |
> | Collapsibility | Definition | 1 | 1 |
> | conditional hazard | Definition | 1 | 1 |
> | Deviation of an observation from its subpopulation mean | Definition | 1 | 1 |
> | Difference in covariate patterns | Definition | 1 | 1 |
> | Difference in log-odds | Definition | 1 | 1 |
> | Estimated Risk Score | Definition | 1 | 1 |
> | Hat matrix | Definition | 1 | 1 |
> | Per-interval likelihood factor | Definition | 1 | 1 |
> | Martingale Residual | Definition | 1 | 1 |
> | Predicted value | Definition | 1 | 1 |
> | Risk Set | Definition | 1 | 1 |
> | Relative risk ratios | Definition | 1 | 1 |
> | Standardized Pearson residual | Definition | 1 | 1 |
> | Survival function | Definition | 1 | 1 |
> | Censored-data likelihood | Lemma | 1 | 1 |
> | Difference in log-odds | Lemma | 1 | 1 |
> | Difference of log-hazards between two covariate patterns | Lemma | 1 | 1 |
> | General formula for odds ratios in logistic regression | Lemma | 1 | 1 |
> | Profile maximum likelihood estimate of each point mass | Lemma | 1 | 1 |
> | The whether-a-failure-occurs factor | Lemma | 1 | 1 |
> | Exact discretization of the survival factor | Lemma | 1 | 1 |
> | Expected mean squares in the one-way random-effects model | Theorem | 1 | 1 |
> | Expressions for expit function | Theorem | 1 | 1 |
> | Expanded expression for logit | Theorem | 1 | 1 |
> | Log-odds as a function of probability | Theorem | 1 | 1 |
> | Odds ratios are reversible | Theorem | 1 | 1 |
> | Probability as a function of log-odds | Theorem | 1 | 1 |
> | Moments of the one-way random-effects model | Theorem | 1 | 1 |
> | Mean and variance of residuals | Theorem | 1 | 1 |
>
> Table 1: All results with at least one descendant, sorted by number of total descendants (most-foundational first).

Back to top
