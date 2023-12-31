% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wf_sim.R
\name{wf_sim}
\alias{wf_sim}
\title{Simulate Wright-Fisher Process with Selection and Mutation}
\usage{
wf_sim(
  n = 250,
  p = 0.5,
  t = 100L,
  mut_to = 0,
  mut_from = 0,
  fit_AA = 1,
  fit_Aa = 1,
  fit_aa = 1
)
}
\arguments{
\item{n}{Population size.}

\item{p}{Initial frequency of allele 'A'.}

\item{t}{Number of generations to simulate.}

\item{mut_to}{Mutation rate from allele 'a' to 'A'.}

\item{mut_from}{Mutation rate from allele 'A' to 'a'.}

\item{fit_AA}{Fitness of homozygous 'AA' genotype (default is 1).}

\item{fit_Aa}{Fitness of heterozygous 'Aa' genotype (default is 1).}

\item{fit_aa}{Fitness of homozygous 'aa' genotype (default is 1).}
}
\value{
A numeric vector representing the allele frequency over generations.
}
\description{
Simulates the Wright-Fisher process with selection and mutation to study the
dynamics of allele frequency changes in a population over time.
}
\examples{
wf_sim()

}
