#' Compare Kaplan-Meier and Nelson-Aalen estimates interactively
#'
#' Launches a Shiny app with sliders for the number of events and the number
#' at risk, drawing \code{\link{km_na_survival_plot}} for the chosen values.
#' The events slider's maximum follows the number at risk.
#'
#' @returns A \code{shiny.appobj}; printing it (as the console does) runs the
#'   app.
#' @export
#' @examples
#' if (interactive()) {
#'   run_km_na_app()
#' }
run_km_na_app <- function() {
  needed <- c("shiny", "ggplot2")
  rlang::check_installed(needed)
  d_input <- shiny::sliderInput(
    "d",
    "# events",
    value = 1,
    min = 1,
    max = 1,
    step = 1
  )
  n_input <- shiny::sliderInput(
    "n",
    "# at risk",
    value = 10,
    min = 1,
    max = 100,
    step = 1
  )
  title <- shiny::titlePanel("Nonparametric time-to-event models")
  plot_output <- shiny::plotOutput("plot1")
  ui <- shiny::fluidPage(title, d_input, n_input, plot_output)
  server <- function(input, output, session) {
    shiny::observeEvent(input$n, {
      d_value <- min(input$n, input$d)
      shiny::updateSliderInput(
        session,
        "d",
        max = input$n,
        value = d_value
      )
    })
    output$plot1 <- shiny::renderPlot({
      # Until the browser applies the update above, d can briefly exceed n.
      d_fits <- input$d <= input$n
      shiny::req(d_fits)
      km_na_survival_plot(d = input$d, n_max = input$n)
    })
  }
  shiny::shinyApp(ui = ui, server = server)
}
