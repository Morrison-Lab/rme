#' Plot the risk ratio against the odds ratio
#'
#' Graphs the risk ratio implied by each odds ratio for a fixed baseline
#' probability, on log scales, with the line \eqn{RR = OR} and the line
#' \eqn{RR = 1} for reference.
#'
#' @param pi1 Baseline probability, strictly between 0 and 1.
#' @param max_or Largest odds ratio shown; the axes run from
#'   \code{1 / max_or} to \code{max_or}.
#'
#' @returns A \code{ggplot} object.
#' @export
#' @examplesIf requireNamespace("ggplot2", quietly = TRUE)
#' or_rr_plot(pi1 = 0.5, max_or = 10)
or_rr_plot <- function(pi1, max_or = 3) {
  pi1_bad <- !rlang::is_scalar_double(pi1) || is.na(pi1) ||
    pi1 <= 0 || pi1 >= 1
  if (pi1_bad) {
    cli::cli_abort(
      "{.arg pi1} must be a single number strictly between 0 and 1.",
      class = "rme_invalid_pi1"
    )
  }
  max_or_bad <- !is.numeric(max_or) || length(max_or) != 1 ||
    is.na(max_or) || max_or <= 1
  if (max_or_bad) {
    cli::cli_abort(
      "{.arg max_or} must be a single number greater than 1.",
      class = "rme_invalid_max_or"
    )
  }
  rlang::check_installed("ggplot2")
  limits <- c(1 / max_or, max_or)
  rr_of_or <- function(x) or_to_rr(pi1 = pi1, or = x)
  ggplot2::ggplot() +
    ggplot2::geom_function(fun = rr_of_or) +
    ggplot2::xlab("Odds ratio, OR") +
    ggplot2::ylab("Risk ratio, RR") +
    ggplot2::theme_bw() +
    ggplot2::geom_abline(
      ggplot2::aes(intercept = 0, slope = 1, col = "RR=OR")
    ) +
    ggplot2::geom_hline(ggplot2::aes(yintercept = 1, col = "RR=1")) +
    ggplot2::scale_y_continuous(transform = "log10", limits = limits) +
    ggplot2::scale_x_continuous(transform = "log10", limits = limits)
}
