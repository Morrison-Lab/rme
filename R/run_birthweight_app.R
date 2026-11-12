#' Explore birthweight regression lines interactively
#'
#' Launches a Shiny app with sliders for each sex's intercept (expected
#' birthweight at 35 weeks) and slope, showing the log-likelihood from
#' \code{\link{birthweight_loglik}} and the lines from
#' \code{\link{birthweight_plot}}.
#' The sliders start at the least-squares estimates and span their 95\%
#' confidence intervals, which the app shows with the fitted model.
#'
#' @returns A \code{shiny.appobj}; printing it (as the console does) runs the
#'   app.
#' @export
#' @examples
#' if (interactive()) {
#'   run_birthweight_app()
#' }
run_birthweight_app <- function() {
  needed <- c("shiny", "ggplot2", "tidyr")
  rlang::check_installed(needed)
  bw <- birthweight_long()
  bw$centered_age <- bw$age - 35
  fit <- stats::lm(weight ~ sex + sex:centered_age - 1, data = bw)
  estimates <- stats::coef(fit)
  ci <- stats::confint(fit)
  coef_slider <- function(id, label, term) {
    ends <- round(ci[term, ])
    start <- round(estimates[[term]])
    shiny::sliderInput(
      id,
      label,
      min = ends[[1]],
      max = ends[[2]],
      value = start,
      width = "100%"
    )
  }
  male_int <- coef_slider("male_int", "Male intercept", "sexmale")
  male_slope <- coef_slider(
    "male_slope",
    "Male slope",
    "sexmale:centered_age"
  )
  female_int <- coef_slider("female_int", "Female intercept", "sexfemale")
  female_slope <- coef_slider(
    "female_slope",
    "Female slope",
    "sexfemale:centered_age"
  )
  sidebar <- shiny::sidebarPanel(
    width = 3,
    male_int,
    male_slope,
    female_int,
    female_slope
  )
  loglik_heading <- shiny::h3("Log-likelihood: ")
  loglik_output <- shiny::verbatimTextOutput("loglik")
  plot_output <- shiny::plotOutput("plot1")
  fit_heading <- shiny::h3("Least-squares fit: ")
  fit_output <- shiny::verbatimTextOutput("fit")
  main <- shiny::mainPanel(
    width = 9,
    loglik_heading,
    loglik_output,
    plot_output,
    fit_heading,
    fit_output
  )
  title <- shiny::titlePanel("Birthweight data: interactive")
  layout <- shiny::sidebarLayout(sidebar, main)
  ui <- shiny::fluidPage(title, layout)
  server <- function(input, output, session) {
    output$loglik <- shiny::renderPrint({
      birthweight_loglik(
        male_int = input$male_int,
        male_slope = input$male_slope,
        female_int = input$female_int,
        female_slope = input$female_slope,
        data = bw
      )
    })
    output$plot1 <- shiny::renderPlot({
      birthweight_plot(
        male_int = input$male_int,
        male_slope = input$male_slope,
        female_int = input$female_int,
        female_slope = input$female_slope,
        data = bw
      )
    })
    fit_summary <- summary(fit)
    output$fit <- shiny::renderPrint(fit_summary)
  }
  shiny::shinyApp(ui = ui, server = server)
}
