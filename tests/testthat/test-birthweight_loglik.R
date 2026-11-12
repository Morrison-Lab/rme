fit_birthweight <- function() {
  bw <- birthweight_long()
  bw$centered_age <- bw$age - 35
  stats::lm(weight ~ sex + sex:centered_age - 1, data = bw)
}

ols_coefs <- function(fit) {
  coefs <- stats::coef(fit)
  list(
    male_int = coefs[["sexmale"]],
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
    ols_coefs() |>
    do.call(what = birthweight_loglik) |>
    expect_equal(expected)
})

test_that("birthweight_loglik() drops when any coefficient leaves OLS", {
  skip_if_not_installed("tidyr")
  fit <- fit_birthweight()
  best_coefs <- ols_coefs(fit)
  best <- do.call(birthweight_loglik, best_coefs)
  for (name in names(best_coefs)) {
    for (shift in c(-5, 5)) {
      moved <- best_coefs
      moved[[name]] <- moved[[name]] + shift
      moved_loglik <- do.call(birthweight_loglik, moved)
      expect_gt(best, moved_loglik)
    }
  }
})

test_that("birthweight_loglik() rejects a coefficient that isn't a number", {
  valid <- list(
    male_int = 2651,
    male_slope = 112,
    female_int = 2422,
    female_slope = 130
  )
  two_values <- c(1, 2)
  no_value <- numeric(0)
  bad_values <- list(NA_real_, "1", two_values, no_value, Inf)
  for (name in names(valid)) {
    for (bad in bad_values) {
      coefs <- valid
      coefs[name] <- list(bad)
      birthweight_loglik |>
        do.call(args = coefs) |>
        expect_error(class = "rme_invalid_coef")
    }
  }
})
