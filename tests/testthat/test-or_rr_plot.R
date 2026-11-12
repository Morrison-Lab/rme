test_that("or_rr_plot() returns a ggplot with log-scaled axes", {
  skip_if_not_installed("ggplot2")
  p <- or_rr_plot(pi1 = 0.5, max_or = 10)
  expect_s3_class(p, "ggplot")
  scales <- ggplot2::layer_scales(p)
  x_limits <- scales$x$get_limits()
  y_limits <- scales$y$get_limits()
  expected <- c(-1, 1)
  expect_equal(x_limits, expected)
  expect_equal(y_limits, expected)
})

test_that("or_rr_plot() draws the curve and both reference lines", {
  skip_if_not_installed("ggplot2")
  p <- or_rr_plot(pi1 = 0.5, max_or = 10)
  geom_class <- function(layer) class(layer$geom)[1]
  geoms <- vapply(p$layers, geom_class, "")
  expected <- c("GeomFunction", "GeomAbline", "GeomHline")
  expect_equal(geoms, expected, ignore_attr = "names")
})

test_that("or_rr_plot() rejects a baseline probability outside (0, 1)", {
  or_rr_plot(pi1 = 1) |>
    expect_error(class = "rme_invalid_pi1")
  or_rr_plot(pi1 = NA_real_) |>
    expect_error(class = "rme_invalid_pi1")
  or_rr_plot(pi1 = "0.5") |>
    expect_error(class = "rme_invalid_pi1")
})

test_that("or_rr_plot() rejects max_or of 1 or less", {
  or_rr_plot(pi1 = 0.5, max_or = 0.5) |>
    expect_error(class = "rme_invalid_max_or")
  or_rr_plot(pi1 = 0.5, max_or = NA) |>
    expect_error(class = "rme_invalid_max_or")
  or_rr_plot(pi1 = 0.5, max_or = Inf) |>
    expect_error(class = "rme_invalid_max_or")
})
