#' Explore odds ratios and risk ratios interactively
#'
#' Launches a Shiny app with a slider for the baseline probability and a box
#' for the largest odds ratio shown, drawing \code{\link{or_rr_plot}} for the
#' chosen values.
#'
#' @returns A \code{shiny.appobj}; printing it (as the console does) runs the
#'   app.
#' @export
#' @examples
#' if (interactive()) {
#'   run_or_rr_app()
#' }
run_or_rr_app <- function() {
  needed <- c("shiny", "ggplot2")
  rlang::check_installed(needed)
  pi1_input <- shiny::sliderInput(
    "pi1",
    label = "baseline probability",
    min = 0.00001,
    max = 0.99999,
    value = 0.5
  )
  or_max_input <- shiny::numericInput(
    "or_max",
    label = "max OR",
    min = 0.0001,
    value = 10
  )
  plot_output <- shiny::plotOutput("plot1")
  title <- shiny::titlePanel("OR-RR")
  ui <- shiny::fluidPage(title, pi1_input, or_max_input, plot_output)
  server <- function(input, output, session) {
    output$plot1 <- shiny::renderPlot({
      or_rr_plot(input$pi1, input$or_max)
    })
  }
  shiny::shinyApp(ui = ui, server = server)
}
