test_that("run_km_na_app() builds a Shiny app without running it", {
  skip_if_not_installed("shiny")
  skip_if_not_installed("ggplot2")
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

test_that("run_km_na_app() caps the events slider at the number at risk", {
  skip_if_not_installed("shiny")
  skip_if_not_installed("ggplot2")
  updates <- list()
  record_update <- function(session, input_id, ...) {
    update <- list(input_id = input_id, ...)
    updates[[length(updates) + 1]] <<- update
  }
  local_mocked_bindings(
    updateSliderInput = record_update,
    .package = "shiny"
  )
  app <- run_km_na_app()
  shiny::testServer(app, {
    session$setInputs(n = 20, d = 10)
    session$setInputs(n = 5)
  })
  last_update <- updates[[length(updates)]]
  expect_identical(last_update$input_id, "d")
  expect_identical(last_update$max, 5)
  expect_identical(last_update$value, 5)
})

test_that("run_km_na_app() waits to plot while d exceeds n", {
  skip_if_not_installed("shiny")
  skip_if_not_installed("ggplot2")
  app <- run_km_na_app()
  shiny::testServer(app, {
    session$setInputs(n = 20, d = 10)
    session$setInputs(n = 5)
    expect_error(output$plot1, class = "shiny.silent.error")
  })
})
