#' Log-likelihood of a birthweight model with chosen coefficients
#'
#' Evaluates the Gaussian log-likelihood of a linear model for the
#' birthweight data with a separate intercept and slope for each sex:
#' \deqn{E[Y | X] = \alpha_s + \beta_s (a - 35),}{
#' E[Y | X] = a_s + b_s (age - 35),}
#' where \eqn{s}{s} is the baby's sex and \eqn{a}{age} its gestational age in
#' weeks.
#' The residual standard deviation is estimated from the residuals of the
#' chosen coefficients as \eqn{\sqrt{RSS / (n - 4)}}{sqrt(RSS / (n - 4))},
#' dividing by the residual degrees of freedom \eqn{n - 4}{n - 4} rather
#' than by \eqn{n}{n}, so at the least-squares estimates the result is
#' slightly below the maximized likelihood.
#'
#' @param male_int,female_int Expected birthweight in grams at 35 weeks.
#' @param male_slope,female_slope Change in expected birthweight in grams
#'   per week of gestational age.
#' @param data The data, as returned by \code{\link{birthweight_long}}.
#'
#' @returns The log-likelihood, a single number.
#' @export
#' @examplesIf requireNamespace("tidyr", quietly = TRUE)
#' birthweight_loglik(
#'   male_int = 2651,
#'   male_slope = 112,
#'   female_int = 2422,
#'   female_slope = 130
#' )
birthweight_loglik <- function(
  male_int,
  male_slope,
  female_int,
  female_slope,
  data = birthweight_long()
) {
  check_birthweight_coefs(male_int, male_slope, female_int, female_slope)
  centered_age <- data$age - 35
  mean_weight <- ifelse(
    data$male,
    male_int + male_slope * centered_age,
    female_int + female_slope * centered_age
  )
  resid <- data$weight - mean_weight
  df_resid <- nrow(data) - 4
  sigma <- sqrt(sum(resid^2) / df_resid)
  densities <- stats::dnorm(resid, mean = 0, sd = sigma, log = TRUE)
  sum(densities)
}
