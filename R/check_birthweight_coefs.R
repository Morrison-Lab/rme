#' Check the coefficients of a birthweight model
#'
#' Stops with a classed error unless each of the four coefficients is a
#' single finite number.
#'
#' @inheritParams birthweight_loglik
#'
#' @returns \code{NULL}, invisibly, when the inputs are valid.
#' @noRd
check_birthweight_coefs <- function(
  male_int,
  male_slope,
  female_int,
  female_slope
) {
  coefs <- list(male_int, male_slope, female_int, female_slope)
  is_finite_scalar <- function(x) {
    is.numeric(x) && length(x) == 1 && is.finite(x)
  }
  coef_ok <- vapply(coefs, is_finite_scalar, TRUE)
  coefs_bad <- !all(coef_ok)
  if (coefs_bad) {
    cli::cli_abort(
      "Each intercept and slope must be a single finite number.",
      class = "rme_invalid_coef"
    )
  }
  invisible(NULL)
}
