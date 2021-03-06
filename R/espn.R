#' ESPN's win probability estimates from the last minute of the NCAA football 2016 and 2017 seasons.
#'
#' A dataset containing ESPN's win probability estimates from the last minute of the
#' NCAA football 2016 and 2017 seasons. The time stamps are not perfect, rather the probability that
#' occured closest to the time stamp was recorded from each game. The eventual result of the game is
#' also included in the dataset along with what year it came from.
#'
#' @format A data frame with 10314 rows and 4 variables:
#' \describe{
#' \item{p.tilde}{ESPN's win probability estimate.}
#' \item{home_win}{The eventual result of the game (if the home team won or not.)}
#' \item{time_left}{The amount of time left in the 4th quarter of the game when p.tilde was estimated.}
#' \item{year}{The year / season the probability was referring to.}
#' }
"espn"
