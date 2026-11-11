#' Convert an odds ratio to a risk ratio
#'
#' Given the baseline probability \code{pi1} and an odds ratio comparing a
#' second group to the baseline, returns the risk (probability) ratio
#' \eqn{\pi_2 / \pi_1}.
#'
#' @param pi1 Baseline probability, strictly between 0 and 1.
#' @param or Odds ratio, positive.
#'
#' @returns A numeric vector of risk ratios.
#' @export
#' @examples
#' or_to_rr(pi1 = 0.01, or = 2)
#' or_to_rr(pi1 = 0.4, or = 1.5)
or_to_rr <- function(pi1, or) {
  odds1 <- pi1 / (1 - pi1)
  odds2 <- or * odds1
  pi2 <- odds2 / (1 + odds2)
  pi2 / pi1
}
