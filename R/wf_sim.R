#' Simulate Wright-Fisher Process with Selection and Mutation
#'
#' Simulates the Wright-Fisher process with selection and mutation to study the
#' dynamics of allele frequency changes in a population over time.
#'
#' @param n Population size.
#' @param p Initial frequency of allele 'A'.
#' @param t Number of generations to simulate.
#' @param mut_to Mutation rate from allele 'a' to 'A'.
#' @param mut_from Mutation rate from allele 'A' to 'a'.
#' @param fit_AA Fitness of homozygous 'AA' genotype (default is 1).
#' @param fit_Aa Fitness of heterozygous 'Aa' genotype (default is 1).
#' @param fit_aa Fitness of homozygous 'aa' genotype (default is 1).
#'
#' @return A numeric vector representing the allele frequency over generations.
#' @export
#'
#' @examples
#' wf_sim()
#'
#' @importFrom purrr accumulate
#' @importFrom stats rbinom

wf_sim <- function(n = 250, p = .5, t = 100L, mut_to = 0, mut_from = 0,
                   fit_AA = 1, fit_Aa = 1, fit_aa = 1) {

  # Simulate allele frequency changes using purrr::accumulate
  allele_frequencies <- purrr::accumulate(
    .x = vector("numeric", t - 1),
    .f = ~ {
      # Calculate average fitness of the population
      fit_avg = .x ^ 2 * fit_AA + 2 * .x * (1 - .x) * fit_Aa + (1 - .x) ^ 2 * fit_aa

      # Calculate frequency after selection and mutation
      p_sel = (.x * (.x * fit_AA + (1 - .x) * fit_Aa)) / fit_avg
      p_sel_mut = (1 - mut_from ) * p_sel + (1 - p_sel) * mut_to

      # Generate next generation allele frequency
      rbinom(1, 2 * n, p_sel_mut) / (2 * n)
    },
    .init = p
  )

  return(allele_frequencies)
}
