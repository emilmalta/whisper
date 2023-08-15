#' Plot Wright-Fisher Simulations
#'
#' Generates a plot of Wright-Fisher simulations with specified parameters.
#'
#' @param ... Parameters passed to \code{\link{wf_sim}} function.
#' @param num_sims Number of simulations to run.
#'
#' @details Generates a plot of Wright-Fisher simulations using
#' provided parameters. It uses the \code{\link{wf_sim}} function to simulate
#'   genetic drift across generations and plots allele trajectory.
#'
#' @return ggplot showing allele frequencies over generations.
#' @export
#'
#' @examples
#' wf_plot()
#' wf_plot(p = 1/250, fit_aa = .8)
#' wf_plot(p = 1/250, mut_to = .05, mut_from = .03)
#'
#' @importFrom ggplot2 ggplot aes geom_line scale_y_continuous labs
#' @importFrom dplyr tibble group_by mutate reframe
#' @importFrom scales percent

wf_plot <- function(..., num_sims = 100) {

  argg <- c(as.list(environment()), list(...))
  subtitle <- paste0(names(argg), ": ", unlist(argg), collapse = ", ")

  plot_df <- reframe(
    group_by(
      tibble(sim = 1:num_sims), sim),
    p = wf_sim(...), t = seq_along(p)
  )

  ggplot(plot_df, aes(x = t, y = p, group = sim)) +
    geom_line(alpha = .25) +
    scale_y_continuous(labels = scales::percent, limits = c(0, 1)) +
    labs(title = "Wright-Fisher simulation of genetic drift",
         caption = subtitle,
         x = "Generation", y = "Allele freq.")
}
