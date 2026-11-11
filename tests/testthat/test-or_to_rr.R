test_that("or_to_rr() matches the ratio of the implied probabilities", {
  pi1 <- 0.4
  pi2 <- 0.5
  or <- (pi2 / (1 - pi2)) / (pi1 / (1 - pi1))
  rr <- or_to_rr(pi1 = pi1, or = or)
  expect_equal(rr, pi2 / pi1)
})

test_that("an odds ratio of 1 is a risk ratio of 1", {
  pi1 <- c(0.01, 0.5, 0.9)
  rr <- or_to_rr(pi1 = pi1, or = 1)
  ones <- rep(1, 3)
  expect_equal(rr, ones)
})

test_that("a rare outcome makes the risk ratio close to the odds ratio", {
  rr <- or_to_rr(pi1 = 1e-6, or = 2)
  expect_equal(rr, 2, tolerance = 1e-5)
})
