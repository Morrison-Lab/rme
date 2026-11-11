#' Convert a risk ratio to an odds ratio
#'
#' Given the baseline probability `pi1` and a risk (probability) ratio
#' comparing a second group to the baseline, returns the odds ratio.
#'
#' @param pi1 Baseline probability, strictly between 0 and 1.
#' @param rr Risk ratio, positive, small enough that the second group's
#'   probability, `pi1` times the risk ratio, stays below 1.
#'
#' @returns A numeric vector of odds ratios.
#' @export
#' @examples
#' rr_to_or(pi1 = 0.01, rr = 2)
#' rr_to_or(pi1 = 0.4, rr = 1.25)
rr_to_or <- function(pi1, rr) {
  pi2 <- rr * pi1
  odds1 <- pi1 / (1 - pi1)
  odds2 <- pi2 / (1 - pi2)
  odds2 / odds1
}
