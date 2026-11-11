test_that("or_rr_plot() returns a ggplot with log-scaled axes", {
  skip_if_not_installed("ggplot2")
  p <- or_rr_plot(pi1 = 0.5, max_or = 10)
  expect_s3_class(p, "ggplot")
  x_limits <- ggplot2::layer_scales(p)$x$get_limits()
  limits <- 10^x_limits
  expected <- c(0.1, 10)
  expect_equal(limits, expected)
})
