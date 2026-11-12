test_that("km_conditional_survival() is 1 - d / n", {
  n <- c(10, 4, 5)
  d <- c(1, 2, 0)
  expected <- c(0.9, 0.5, 1)
  surv <- km_conditional_survival(n = n, d = d)
  expect_equal(surv, expected)
})

test_that("km_conditional_survival() is 0 when all at risk have the event", {
  surv <- km_conditional_survival(n = 3, d = 3)
  expect_equal(surv, 0)
})

test_that("km_conditional_survival() rejects more events than at risk", {
  km_conditional_survival(n = 3, d = 5) |>
    expect_error(class = "rme_invalid_d")
  km_conditional_survival(n = 3, d = -1) |>
    expect_error(class = "rme_invalid_d")
})

test_that("km_conditional_survival() rejects a non-positive risk set", {
  km_conditional_survival(n = 0, d = 0) |>
    expect_error(class = "rme_invalid_n")
  km_conditional_survival(n = NA_real_) |>
    expect_error(class = "rme_invalid_n")
})
