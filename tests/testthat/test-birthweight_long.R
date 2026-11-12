test_that("birthweight_long() has one row per baby", {
  skip_if_not_installed("tidyr")
  bw <- birthweight_long()
  bw |>
    nrow() |>
    expect_identical(24L)
  expected_names <- c("id", "sex", "age", "weight", "male", "female")
  expect_named(bw, expected_names, ignore.order = TRUE)
  sex_levels <- c("female", "male")
  bw$sex |>
    levels() |>
    expect_identical(sex_levels)
  bw$male |>
    sum() |>
    expect_identical(12L)
  expect_identical(bw$male, !bw$female)
})

test_that("birthweight_long() keeps each sex's values", {
  skip_if_not_installed("tidyr")
  bw <- birthweight_long()
  wide <- dobson::birthweight
  boys <- dplyr::filter(bw, .data$male)
  girls <- dplyr::filter(bw, .data$female)
  expect_identical(boys$weight, wide$`boys weight`)
  expect_identical(girls$age, wide$`girls gestational age`)
})
