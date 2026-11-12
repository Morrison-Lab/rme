test_that("birthweight_plot() draws the points and one line per sex", {
  skip_if_not_installed("ggplot2")
  skip_if_not_installed("tidyr")
  plot <- birthweight_plot(
    male_int = 2651,
    male_slope = 112,
    female_int = 2422,
    female_slope = 130
  )
  expect_s3_class(plot, "ggplot")
  built <- ggplot2::ggplot_build(plot)
  lines <- built$data[[2]]
  lines |>
    nrow() |>
    expect_identical(2L)
  # The line at 35 weeks passes through each sex's intercept.
  at_center <- lines$intercept + lines$slope * 35
  chosen_intercepts <- c(2422, 2651)
  expect_setequal(at_center, chosen_intercepts)
})

test_that("birthweight_plot() rejects a non-finite coefficient", {
  birthweight_plot(Inf, 112, 2422, 130) |>
    expect_error(class = "rme_invalid_coef")
})
