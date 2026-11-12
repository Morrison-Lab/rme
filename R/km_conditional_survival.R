#' Kaplan-Meier conditional survival at one event time
#'
#' Returns the Kaplan-Meier estimate of the probability of surviving past an
#' event time, given survival up to it: \eqn{1 - d / n}, where \code{d}
#' events occur among \code{n} individuals at risk.
#'
#' @param n Number at risk, positive.
#' @param d Number of events, between 0 and \code{n}.
#'
#' @returns A numeric vector of conditional survival probabilities.
#' @seealso \code{\link{na_conditional_survival}}
#' @export
#' @examples
#' km_conditional_survival(n = 10, d = 1)
km_conditional_survival <- function(n, d = 1) {
  check_risk_set(n, d)
  1 - d / n
}
