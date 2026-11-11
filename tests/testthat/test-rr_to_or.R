test_that("rr_to_or() inverts or_to_rr()", {
  pi1 <- c(0.01, 0.2, 0.4)
  or <- c(0.5, 2, 3)
  rr <- or_to_rr(pi1 = pi1, or = or)
  or_back <- rr_to_or(pi1 = pi1, rr = rr)
  expect_equal(or_back, or)
})

test_that("rr_to_or() gives the worked example's odds ratio", {
  or <- rr_to_or(pi1 = 0.4, rr = 1.25)
  expect_equal(or, 1.5)
})
