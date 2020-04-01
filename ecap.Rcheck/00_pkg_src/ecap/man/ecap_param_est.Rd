\name{ecap_param_est}
\alias{ecap_param_est}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
ECAP parameter estimation.
}
\description{
A function that takes in a vector of probability estimates and the results of each corresponding event. It returns an estimate of the level of corruption (gamma) and the level of bias (theta) in the estimates provided. These parameters are needed to preform the ECAP adjustment.

If you know or assume that the bias is 0, you can set bias_indicator = F and theta will always be estimated to be 0.
}
\usage{
ecap_param_est(x)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
%%     ~~Describe \code{x} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
Returns a numeric vector of length 2. The first value is an estimate of the corruption, gamma. The second value is an estimate of the bias (theta).
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
Bradley Rava. PhD Candidate in Statistics at the University of Southern California's Marshall School of Business. Department of Data Sciences and Operations.
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
## Random probability estimates and corresponding wins/losses
p <- runif(0, 1, 1000)
win_var <- rbinom(length(p), 1, p)

print(ecap_param_est(p, win_var, win_id = 1, bias_indicator = F))


% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
