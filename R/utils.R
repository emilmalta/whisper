# Global variables
globalVariables(c("p", "sim"))


helper <- function(n = 250, p = .5, t = 100L, mut_to = 0, mut_from = 0,
                   fit_AA = 1, fit_Aa = 1, fit_aa = 1) {
  purrr::accumulate(
    .x = vector("numeric", t - 1),
    .f = ~ {
      # Calculate average fitness of the population
      fit_avg = .x ^ 2 * fit_AA + 2 * .x * (1 - .x) * fit_Aa + (1 - .x) ^ 2 * fit_aa

      # Calculate frequency after selection and mutation
      p_sel = (.x * (.x * fit_AA + (1 - .x) * fit_Aa)) / fit_avg
      p_sel_mut = (1 - mut_from ) * p_sel + (1 - p_sel) * mut_to

    },
    .init = p
  )
}

