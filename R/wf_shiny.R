#' Run interactive Wright-Fisher Genetic Drift Simulation
#'
#' @return Shiny app to interactively explore genetic drift simulations.
#' @export
#'
#' @examples
#' \dontrun{
#' wf_shiny()
#' }
#'
#' @seealso \code{\link{wf_plot}} for generating Wright-Fisher simulation plots.

wf_shiny <- function() {

  ui <- bslib::page_sidebar(
    title = "Wright-Fisher Genetic Drift",
    sidebar = bslib::sidebar(
      shiny::sliderInput("p", label = "Initial allele freq. (p)", min = 0, max = 1, value = .5, ticks = FALSE),
      shiny::sliderInput("n", label = "Population size (n)", min = 1, max = 500, value = 250, ticks = FALSE),
      shiny::sliderInput("t", label = "Number of generations", min = 1, max = 200, value = 100, ticks = FALSE),
      shiny::sliderInput("mut_to", label = "Mutation rate (a -> A)", min = 0, max = 1, value = 0, ticks = FALSE),
      shiny::sliderInput("mut_from", label = "Mutation rate (A -> a)", min = 0, max = 1, value = 0, ticks = FALSE),
      shiny::div(
        style = "display: flex; flex-direction: row;",
        shiny::numericInput("fit_AA", "Fit AA:", value = 1, step = .1),
        shiny::numericInput("fit_Aa", "Fit Aa:", value = 1, step = .1),
        shiny::numericInput("fit_aa", "Fit aa:", value = 1, step = .1)
      ),
      shiny::numericInput("num_sims", label = "Number of simulations", value = 100, min = 1),
      shiny::radioButtons("show_hist", label = "Histogram", choices = c("Show", "Hide"), selected = "Hide"),
      shiny::actionButton("reset", label = "Reset")
    ),
    bslib::card(shiny::plotOutput("simplot"))
  )

  server <- function(input, output, session) {

    input_values <- shiny::reactiveValues(
      p = 0.5,
      n = 250,
      t = 100,
      mut_from = 0,
      mut_to = 0,
      fit_AA = 1,
      fit_Aa = 1,
      fit_aa = 1,
      num_sims = 100,
      show_hist = "Hide"
    )

    shiny::observe({
      input_values$p <- input$p
      input_values$n <- input$n
      input_values$t <- input$t
      input_values$mut_from <- input$mut_from
      input_values$mut_to <- input$mut_to
      input_values$fit_AA <- input$fit_AA
      input_values$fit_Aa <- input$fit_Aa
      input_values$fit_aa <- input$fit_aa
      input_values$num_sims <- input$num_sims
      input_values$show_hist <- input$show_hist
    })

    output$simplot <- shiny::renderPlot({
      wf_plot(
        n = input_values$n,
        p = input_values$p,
        t = input_values$t,
        mut_from = input_values$mut_from,
        mut_to = input_values$mut_to,
        fit_AA = input_values$fit_AA,
        fit_Aa = input_values$fit_Aa,
        fit_aa = input_values$fit_aa,
        num_sims = input_values$num_sims,
        show_hist = input_values$show_hist == "Show"
      )
    })

    shiny::observeEvent(input$reset, {
      # Reset input_values to their default values
      input_values$p <- 0.5
      input_values$n <- 250
      input_values$t <- 100
      input_values$mut_from <- 0
      input_values$mut_to <- 0
      input_values$fit_AA <- 1
      input_values$fit_Aa <- 1
      input_values$fit_aa <- 1
    })

    shiny::observeEvent(input$reset, {
      # Reset all input values to their default values
      shiny::updateSliderInput(session, "p", value = 0.5)
      shiny::updateSliderInput(session, "n", value = 250)
      shiny::updateSliderInput(session, "t", value = 100)
      shiny::updateSliderInput(session, "mut_from", value = 0)
      shiny::updateSliderInput(session, "mut_to", value = 0)
      shiny::updateNumericInput(session, "fit_AA", value = 1)
      shiny::updateNumericInput(session, "fit_Aa", value = 1)
      shiny::updateNumericInput(session, "fit_aa", value = 1)
    })

  }
  shiny::shinyApp(ui, server)
}
