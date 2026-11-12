test_that("km_na_survival_plot() draws both estimators on [d, n_max]", {
  skip_if_not_installed("ggplot2")
  p <- km_na_survival_plot(d = 2, n_max = 20)
  expect_s3_class(p, "ggplot")
  scales <- ggplot2::layer_scales(p)
  x_limits <- scales$x$get_limits()
  y_limits <- scales$y$get_limits()
  expected_x <- c(2, 20)
  expected_y <- c(0, 1)
  expect_equal(x_limits, expected_x)
  expect_equal(y_limits, expected_y)
  built <- ggplot2::ggplot_build(p)
  curves <- built$data
  expect_length(curves, 2)
})

test_that("km_na_survival_plot() rejects more events than at risk", {
  km_na_survival_plot(d = 5, n_max = 3) |>
    expect_error(class = "rme_invalid_d")
})
