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

test_that("km_conditional_survival() defaults to one event", {
  surv <- km_conditional_survival(10)
  expect_equal(surv, 0.9)
})

test_that("km_conditional_survival() rejects d outside 0 to n", {
  km_conditional_survival(n = 3, d = 5) |>
    expect_error(class = "rme_invalid_d")
  km_conditional_survival(n = 3, d = -1) |>
    expect_error(class = "rme_invalid_d")
  km_conditional_survival(n = 3, d = NA_real_) |>
    expect_error(class = "rme_invalid_d")
})

test_that("km_conditional_survival() rejects d and n of mismatched lengths", {
  n <- c(10, 4, 5)
  d <- c(1, 2)
  km_conditional_survival(n = n, d = d) |>
    expect_error(class = "rme_invalid_d")
  km_conditional_survival(n = 10, d = d) |>
    expect_error(class = "rme_invalid_d")
  no_events <- numeric(0)
  km_conditional_survival(n = 10, d = no_events) |>
    expect_error(class = "rme_invalid_d")
})

test_that("km_conditional_survival() rejects an empty or non-positive n", {
  km_conditional_survival(n = 0, d = 0) |>
    expect_error(class = "rme_invalid_n")
  km_conditional_survival(n = NA_real_) |>
    expect_error(class = "rme_invalid_n")
  empty_n <- numeric(0)
  km_conditional_survival(n = empty_n) |>
    expect_error(class = "rme_invalid_n")
})
