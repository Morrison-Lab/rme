test_that("run_birthweight_app() builds a Shiny app without running it", {
  skip_if_not_installed("shiny")
  skip_if_not_installed("ggplot2")
  skip_if_not_installed("tidyr")
  app <- run_birthweight_app()
  expect_s3_class(app, "shiny.appobj")
})

test_that("run_birthweight_app() shows the log-likelihood and the plot", {
  skip_if_not_installed("shiny")
  skip_if_not_installed("ggplot2")
  skip_if_not_installed("tidyr")
  app <- run_birthweight_app()
  shiny::testServer(app, {
    session$setInputs(
      male_int = 2651,
      male_slope = 112,
      female_int = 2422,
      female_slope = 130
    )
    expected <- birthweight_loglik(2651, 112, 2422, 130)
    expected_text <- format(expected)
    expect_match(output$loglik, expected_text, fixed = TRUE)
    plot <- output$plot1
    expect_match(plot$src, "^data:image/png;base64,")
    expect_match(output$fit, "sexmale")
  })
})
