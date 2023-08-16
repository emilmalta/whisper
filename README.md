
<!-- README.md is generated from README.Rmd. Please edit that file -->

# whisper

Simulate and visualise allele trajectories, using Wright-Fisher
simulation.

## Installation

You can install the development version of whisper from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("emilmalta/whisper")
```

Load the contents into R environment using

``` r
library(whisper)
```

## wf_sim()

The `wf_sim` function produves a vector of allele frequencies using WF
simulation. By default, population size is `250`, initial allele
frequency is `0.5`, and `100` generations are produced.

``` r
wf_sim()
#>   [1] 0.500 0.488 0.502 0.520 0.516 0.522 0.534 0.580 0.600 0.596 0.560 0.582
#>  [13] 0.580 0.606 0.616 0.618 0.640 0.640 0.664 0.656 0.660 0.654 0.624 0.638
#>  [25] 0.646 0.624 0.632 0.626 0.604 0.620 0.632 0.618 0.622 0.638 0.640 0.638
#>  [37] 0.664 0.662 0.640 0.592 0.604 0.610 0.634 0.604 0.592 0.566 0.580 0.596
#>  [49] 0.572 0.612 0.600 0.580 0.600 0.588 0.604 0.620 0.646 0.648 0.676 0.696
#>  [61] 0.686 0.668 0.672 0.666 0.648 0.672 0.666 0.698 0.722 0.730 0.762 0.738
#>  [73] 0.742 0.764 0.754 0.760 0.734 0.760 0.796 0.824 0.838 0.812 0.792 0.802
#>  [85] 0.792 0.768 0.784 0.758 0.762 0.776 0.808 0.830 0.858 0.848 0.846 0.860
#>  [97] 0.872 0.890 0.892 0.886
```

No mutation rates or selection by default. Mutation can be simulated
like so:

``` r
wf_sim(p = 1/250, mut_to = .8, mut_from = .1)
#>   [1] 0.004 0.816 0.892 0.884 0.894 0.908 0.898 0.904 0.884 0.890 0.882 0.896
#>  [13] 0.898 0.894 0.900 0.896 0.878 0.912 0.894 0.878 0.892 0.892 0.870 0.882
#>  [25] 0.894 0.910 0.888 0.912 0.882 0.902 0.852 0.884 0.872 0.890 0.890 0.888
#>  [37] 0.872 0.860 0.876 0.890 0.888 0.908 0.882 0.868 0.900 0.888 0.886 0.886
#>  [49] 0.902 0.896 0.900 0.888 0.876 0.892 0.878 0.902 0.916 0.896 0.898 0.912
#>  [61] 0.910 0.880 0.856 0.910 0.896 0.894 0.904 0.852 0.866 0.884 0.876 0.882
#>  [73] 0.902 0.896 0.906 0.882 0.888 0.898 0.878 0.890 0.888 0.884 0.876 0.884
#>  [85] 0.922 0.888 0.896 0.902 0.890 0.906 0.890 0.894 0.890 0.886 0.902 0.910
#>  [97] 0.910 0.916 0.908 0.904
```

Selection assumes a diploid organism, and genotype fitness is provided
for each:

``` r
# Dominant selection for A:
wf_sim(p = 1/250, fit_aa = .5)
#>   [1] 0.004 0.010 0.022 0.036 0.060 0.102 0.182 0.252 0.374 0.474 0.566 0.578
#>  [13] 0.618 0.730 0.764 0.770 0.804 0.822 0.876 0.878 0.882 0.908 0.914 0.930
#>  [25] 0.928 0.938 0.934 0.946 0.932 0.936 0.932 0.946 0.936 0.924 0.932 0.952
#>  [37] 0.948 0.956 0.956 0.960 0.966 0.980 0.990 0.992 0.986 0.992 0.994 0.998
#>  [49] 0.998 1.000 1.000 1.000 1.000 1.000 1.000 1.000 1.000 1.000 1.000 1.000
#>  [61] 1.000 1.000 1.000 1.000 1.000 1.000 1.000 1.000 1.000 1.000 1.000 1.000
#>  [73] 1.000 1.000 1.000 1.000 1.000 1.000 1.000 1.000 1.000 1.000 1.000 1.000
#>  [85] 1.000 1.000 1.000 1.000 1.000 1.000 1.000 1.000 1.000 1.000 1.000 1.000
#>  [97] 1.000 1.000 1.000 1.000
```

## wf_plot()

A ggplot of overlaid Wright-Fisher simulations can be made using
`wf_plot()`:

``` r
wf_plot(num_sims = 100)
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

Takes same parameters as the `wf_sim()` function:

``` r
wf_plot(p = 1/250, t = 25, fit_Aa = .5, fit_aa = .25) 
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" />

## wf_shiny()

Run `wf_shiny()` for an interactive app.
