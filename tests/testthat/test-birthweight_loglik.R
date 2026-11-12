fit_birthweight <- function() {
  bw <- birthweight_long()
  bw$centered_age <- bw$age - 35
  stats::lm(weight ~ sex + sex:centered_age - 1, data = bw)
}

ols_loglik <- function(fit, shift = 0) {
  coefs <- stats::coef(fit)
  birthweight_loglik(
    male_int = coefs[["sexmale"]] + shift,
    male_slope = coefs[["sexmale:centered_age"]],
    female_int = coefs[["sexfemale"]],
    female_slope = coefs[["sexfemale:centered_age"]]
  )
}

test_that("birthweight_loglik() matches its closed form at the OLS fit", {
  skip_if_not_installed("tidyr")
  fit <- fit_birthweight()
  resid <- stats::resid(fit)
  rss <- sum(resid^2)
  n <- 24
  sigma2 <- rss / (n - 4)
  log_term <- log(2 * pi * sigma2)
  expected <- -n / 2 * log_term - rss / (2 * sigma2)
  fit |>
    ols_loglik() |>
    expect_equal(expected)
})

test_that("birthweight_loglik() is largest at the OLS coefficients", {
  skip_if_not_installed("tidyr")
  fit <- fit_birthweight()
  best <- ols_loglik(fit)
  higher <- ols_loglik(fit, shift = 50)
  lower <- ols_loglik(fit, shift = -50)
  expect_gt(best, higher)
  expect_gt(best, lower)
})

test_that("birthweight_loglik() rejects a missing or non-numeric coefficient", {
  birthweight_loglik(NA_real_, 112, 2422, 130) |>
    expect_error(class = "rme_invalid_coef")
  birthweight_loglik("2651", 112, 2422, 130) |>
    expect_error(class = "rme_invalid_coef")
  two_values <- c(1, 2)
  birthweight_loglik(two_values, 112, 2422, 130) |>
    expect_error(class = "rme_invalid_coef")
})
