% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ecap.R
\name{predict.ecap}
\alias{predict.ecap}
\title{Implementing the ECAP procedure}
\usage{
\method{predict}{ecap}(object, new_unadjusted, ...)
}
\arguments{
\item{object}{An object of class ecap.}

\item{new_unadjusted}{A numerical vector of unadjusted probabilities that you want to ECAP adjust.}

\item{...}{Additional arguments}
}
\value{
A vector of ECAP adjusted probability estimates.
}
\description{
Takes in an ECAP object and a new set of probability estimates that the user wishes to adjust. The model uses the
calibration from the ecap object to ECAP adjust the new probability estimates given to the function predict.
}
\examples{
\donttest{
set.seed(1)
p_obs <- runif(1000, 0, 1)
win_var <- rbinom(length(p_obs), 1, p_obs)
ecap_fit <- ecap(unadjusted_prob = p_obs, win_var = win_var, win_id = 1, bias_indicator = FALSE)

p_new <- runif(1000, 0, 1)
ecap_new <- predict(object=ecap_fit, new_unadjusted=p_new)
}
}
\references{
http://faculty.marshall.usc.edu/gareth-james/Research/Probs.pdf
}
\author{
Bradley Rava, Peter Radchenko and Gareth M. James.
}
