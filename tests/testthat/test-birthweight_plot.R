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
  # The line at 35 weeks passes through each sex's intercept, and each
  # line has its own sex's colour (group 1 is female, group 2 male).
  line_order <- order(lines$group)
  at_center <- lines$intercept + lines$slope * 35
  chosen_intercepts <- c(2422, 2651)
  expect_equal(at_center[line_order], chosen_intercepts)
  points <- built$data[[1]]
  female_colour <- points$colour[points$group == 1][[1]]
  male_colour <- points$colour[points$group == 2][[1]]
  sex_colours <- c(female_colour, male_colour)
  expect_identical(lines$colour[line_order], sex_colours)
})

test_that("birthweight_plot() colours the lines when sex is character", {
  skip_if_not_installed("ggplot2")
  skip_if_not_installed("tidyr")
  bw <- birthweight_long()
  bw$sex <- as.character(bw$sex)
  plot <- birthweight_plot(2651, 112, 2422, 130, data = bw)
  built <- ggplot2::ggplot_build(plot)
  point_colours <- unique(built$data[[1]]$colour)
  line_colours <- built$data[[2]]$colour
  expect_setequal(line_colours, point_colours)
})

test_that("birthweight_plot() rejects a non-finite coefficient", {
  birthweight_plot(Inf, 112, 2422, 130) |>
    expect_error(class = "rme_invalid_coef")
})
