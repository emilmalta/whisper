#' Plot Wright-Fisher Simulations
#'
#' Generates a plot of Wright-Fisher simulations with specified parameters.
#'
#' @param num_sims Number of simulations to run.
#' @param show_hist Show distribution of allele frequencies at end of
#' simulations.
#' @param ... Parameters passed to \code{\link{wf_sim}} function.
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

wf_plot <- function(num_sims = 100L, show_hist = FALSE, ...) {

  if(num_sims < 1) stop("Invalid value of 'num_sims'")

  plot_df <- reframe(
    group_by(
      tibble(sim = 1:num_sims), sim),
    p = wf_sim(...), t = seq_along(p)
  )
  p1 <- ggplot2::ggplot(plot_df, ggplot2::aes(x = t, y = p, group = sim)) +
    ggplot2::geom_line(linewidth = .8, alpha = .5) +
    ggplot2::scale_y_continuous(labels = scales::percent, limits = c(0, 1)) +
    ggplot2::labs(
      title = "Wright-Fisher simulation of genetic drift",
      subtitle = "Allele freq. (A)",
      x = "Generation", y = "Allele freq."
    )

  if(show_hist) {
  p2 <- ggplot2::ggplot(
    data = dplyr::slice(dplyr::group_by(plot_df, sim), dplyr::n()),
    aes(p)) +
    ggplot2::geom_histogram(color = "white", binwidth = .025, boundary = 0) +
    ggplot2::scale_x_continuous(limits = c(0, 1), oob = scales::squish) +
    ggplot2::coord_flip() +
    ggplot2::theme(axis.title.y = ggplot2::element_blank()) +
    ggplot2::labs(
      subtitle = "Freq(A) distribution",
      y = "Count"
    ) +
    ggplot2::theme(
      axis.text.y = ggplot2::element_blank(),
      panel.grid.minor.x = ggplot2::element_blank()
    )

    print(p1 + p2 + patchwork::plot_layout(widths = c(.8, .2)))
  } else {
    print(p1)
  }


}
