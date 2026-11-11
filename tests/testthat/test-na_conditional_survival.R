test_that("na_conditional_survival() is exp(-d / n)", {
  n <- c(10, 4)
  d <- c(1, 2)
  log_surv <- c(-0.1, -0.5)
  expected <- exp(log_surv)
  surv <- na_conditional_survival(n = n, d = d)
  expect_equal(surv, expected)
})

test_that("na_conditional_survival() exceeds the Kaplan-Meier value", {
  na <- na_conditional_survival(n = 10, d = 3)
  km <- km_conditional_survival(n = 10, d = 3)
  expect_gt(na, km)
})
