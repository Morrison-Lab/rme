test_that("na_conditional_survival() is exp(-d / n)", {
  n <- c(10, 4)
  d <- c(1, 2)
  log_surv <- c(-0.1, -0.5)
  expected <- exp(log_surv)
  surv <- na_conditional_survival(n = n, d = d)
  expect_equal(surv, expected)
})

test_that("na_conditional_survival() exceeds the KM value when d > 0", {
  na <- na_conditional_survival(n = 10, d = 3)
  km <- km_conditional_survival(n = 10, d = 3)
  expect_gt(na, km)
})

test_that("na_ and km_conditional_survival() are both 1 when d = 0", {
  na <- na_conditional_survival(n = 10, d = 0)
  km <- km_conditional_survival(n = 10, d = 0)
  expect_equal(na, 1)
  expect_equal(km, 1)
})

test_that("na_conditional_survival() checks its inputs", {
  na_conditional_survival(n = 3, d = 5) |>
    expect_error(class = "rme_invalid_d")
  na_conditional_survival(n = -2, d = 0) |>
    expect_error(class = "rme_invalid_n")
})
