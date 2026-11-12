test_that("run_km_na_app() builds a Shiny app without running it", {
  skip_if_not_installed("shiny")
  app <- run_km_na_app()
  expect_s3_class(app, "shiny.appobj")
})

test_that("run_km_na_app() renders the plot for the chosen inputs", {
  skip_if_not_installed("shiny")
  skip_if_not_installed("ggplot2")
  app <- run_km_na_app()
  shiny::testServer(app, {
    session$setInputs(n = 20, d = 3)
    plot <- output$plot1
    expect_match(plot$src, "^data:image/png;base64,")
  })
})
