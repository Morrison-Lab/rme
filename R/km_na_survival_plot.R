#' Plot Kaplan-Meier and Nelson-Aalen conditional survival
#'
#' Graphs \code{\link{km_conditional_survival}} and
#' \code{\link{na_conditional_survival}} against the number at risk, for a
#' fixed number of events, so the two estimators can be compared.
#'
#' @param d Number of events, a positive whole number.
#' @param n_max Largest number at risk shown; the horizontal axis runs from
#'   \code{d} to \code{n_max}.
#'
#' @returns A \code{ggplot} object.
#' @export
#' @examplesIf requireNamespace("ggplot2", quietly = TRUE)
#' km_na_survival_plot(d = 1, n_max = 10)
km_na_survival_plot <- function(d = 1, n_max = 10) {
  check_risk_set(n_max, d)
  rlang::check_installed("ggplot2")
  km_of_n <- function(x) km_conditional_survival(n = x, d = d)
  na_of_n <- function(x) na_conditional_survival(n = x, d = d)
  km_layer <- ggplot2::geom_function(
    ggplot2::aes(col = "Kaplan-Meier"),
    fun = km_of_n
  )
  na_layer <- ggplot2::geom_function(
    ggplot2::aes(col = "Nelson-Aalen"),
    fun = na_of_n
  )
  ggplot2::ggplot() +
    na_layer +
    km_layer +
    ggplot2::xlim(d, n_max) +
    ggplot2::ylim(0, 1) +
    ggplot2::xlab("# at risk") +
    ggplot2::ylab("p(X>x|X>=x)") +
    ggplot2::labs(col = "Estimator") +
    ggplot2::theme_bw()
}
