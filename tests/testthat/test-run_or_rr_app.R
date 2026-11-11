test_that("run_or_rr_app() builds a Shiny app without running it", {
  skip_if_not_installed("shiny")
  app <- run_or_rr_app()
  expect_s3_class(app, "shiny.appobj")
})
