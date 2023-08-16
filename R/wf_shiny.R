wf_shiny <- function() {

  ui <- bslib::page_sidebar(
    title = "Wright-Fisher Genetic Drift",
    sidebar = bslib::sidebar(
      shiny::sliderInput("p", label = "Initial allele freq. (p)", min = 0, max = 1, value = .5, ticks = FALSE),
      shiny::sliderInput("n", label = "Population size (n)", min = 1, max = 500, value = 250, ticks = FALSE),
      shiny::sliderInput("mut_from", label = "Mutation rate (A -> a)", min = 0, max = 1, value = 0, ticks = FALSE),
      shiny::sliderInput("mut_to", label = "Mutation rate (a -> A)", min = 0, max = 1, value = 0, ticks = FALSE),
      shiny::div(
        style = "display: flex; flex-direction: row;",
        shiny::numericInput("fit_AA", "Fit AA:", value = 1, step = .1),
        shiny::numericInput("fit_Aa", "Fit Aa:", value = 1, step = .1),
        shiny::numericInput("fit_aa", "Fit aa:", value = 1, step = .1)
      ),
      shiny::numericInput("num_sims", label = "Number of simulations", value = 100)
    ),
    bslib::card(shiny::plotOutput("simplot"))
  )

  server <- function(input, output, session) {
    output$simplot <-
      shiny::renderPlot(
        wf_plot(
          n = input$n,
          p = input$p,
          mut_from = input$mut_from,
          mut_to = input$mut_to,
          fit_AA = input$fit_AA,
          fit_Aa = input$fit_Aa,
          fit_aa = input$fit_aa,
          num_sims = input$num_sims)
      )
  }

  shiny::shinyApp(ui, server)
}
