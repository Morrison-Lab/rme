test_that("run_or_rr_app() builds a Shiny app without running it", {
  skip_if_not_installed("shiny")
  app <- run_or_rr_app()
  expect_s3_class(app, "shiny.appobj")
})

test_that("run_or_rr_app() renders the plot for the chosen inputs", {
  skip_if_not_installed("shiny")
  skip_if_not_installed("ggplot2")
  app <- run_or_rr_app()
  shiny::testServer(app, {
    session$setInputs(pi1 = 0.2, or_max = 5)
    plot <- output$plot1
    expect_match(plot$src, "^data:image/png;base64,")
  })
})
