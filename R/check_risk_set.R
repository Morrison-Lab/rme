#' Check a risk-set size and event count
#'
#' Stops with a classed error unless every \code{n} is a finite positive
#' number and every \code{d} is between 0 and the matching \code{n}.
#'
#' @param n Number at risk.
#' @param d Number of events.
#'
#' @returns \code{NULL}, invisibly, when the inputs are valid.
#' @noRd
check_risk_set <- function(n, d) {
  n_bad <- !is.numeric(n) || anyNA(n) || any(!is.finite(n) | n <= 0)
  if (n_bad) {
    cli::cli_abort(
      "{.arg n} must contain only finite positive numbers.",
      class = "rme_invalid_n"
    )
  }
  d_bad <- !is.numeric(d) || anyNA(d) || any(d < 0 | d > n)
  if (d_bad) {
    cli::cli_abort(
      "{.arg d} must be between 0 and {.arg n}.",
      class = "rme_invalid_d"
    )
  }
  invisible(NULL)
}
