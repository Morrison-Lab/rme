#' Nelson-Aalen conditional survival at one event time
#'
#' Returns the Nelson-Aalen estimate of the probability of surviving past an
#' event time, given survival up to it: \eqn{\exp(-d / n)}, where \code{d}
#' events occur among \code{n} individuals at risk.
#'
#' @inheritParams km_conditional_survival
#'
#' @returns A numeric vector of conditional survival probabilities.
#' @seealso \code{\link{km_conditional_survival}}
#' @export
#' @examples
#' na_conditional_survival(n = 10, d = 1)
na_conditional_survival <- function(n, d = 1) {
  check_risk_set(n, d)
  hazard_increment <- d / n
  exp(-hazard_increment)
}
