## Function that estimates gamma from a given vector of probability estimates
ecap_param_est <- function(prob_tilde, win_var, win_id, bias_indicator = F) {
  probs <- cbind.data.frame(p.tilde=prob_tilde, greater_half = ifelse(prob_tilde > 0.5, T, F), win_var = win_var)

  ## Make sure we return the probabilities in the original order
  probs$orig_order <- 1:nrow(probs)

  ## Convert all probabilities to between 0 and 1/2
  probs$p_flip <- sapply(probs$p.tilde, pFlip)
  probs <- probs[order(probs$p_flip),]

  ## For MLE Later -- obtain the win variable
  win_index <- which(probs$win_var == win_id)
  lose_index <- (1:length(win_var))[-win_index]

  ## Generate basis function / omega matrix from p.tilde
  # Get Knot Locations
  probs_flip <- probs$p_flip
  knot.range <- range(probs$p_flip)
  quantiles <- seq(knot.range[1]+0.0001, knot.range[2]-0.0001, length = 50)

  # Generate the basis matrix and its correspoding 1st and 2nd deriv's
  basis_0 <- myns(probs_flip, knots = quantiles, intercept = T, Boundary.knots = knot.range)
  basis_1 <- myns(probs_flip, knots = quantiles, deriv = 1, intercept = T, Boundary.knots = knot.range)
  basis_2 <- myns(probs_flip, knots = quantiles, deriv = 2, intercept = T, Boundary.knots = knot.range)
  basis_sum <- t(basis_0)%*%basis_0
  sum_b_d1 <- t(basis_1)%*%rep(1,nrow(basis_1))

  # We also want to calculate Omega on a fine grid of points
  fine_grid <- seq(0, 0.5, by=0.001)
  basis_fine_grid <- myns(fine_grid, knots = quantiles, intercept = T, Boundary.knots = knot.range)
  basis_fine_grid_d2 <- myns(fine_grid, knots = quantiles, deriv = 2, intercept = T, Boundary.knots = knot.range)
  omega <- (1/nrow(basis_fine_grid)) * (t(basis_fine_grid_d2) %*% basis_fine_grid_d2)

  ## Grid for the optimization algorithm
  pt <- c(seq(10^(-12), 0.5, by = 0.001), 0.5)
  basis_0.grid <- myns(pt, knots = quantiles, intercept = T, Boundary.knots = knot.range)
  basis_1.grid <- myns(pt, knots = quantiles, deriv = 1, intercept = T, Boundary.knots = knot.range)
  basis_sum.grid <- t(basis_0.grid)%*%basis_0.grid

  #### Adjustment 1: Risk function for lambda and grid for gamma. True p ####
  ## CV SET UP to get min value of lambda from risk function
  # Randomize the rows
  rows <- 1:nrow(basis_0)
  rows_rand <- rows[sample(rows)]

  ## Declate the number of groups that we want
  n.group <- 10
  ## Return a list with 10 approx equal vectors of rows.
  partitions <- split(rows_rand,
                      cut(rows_rand,quantile(rows_rand,(0:n.group)/n.group),
                          include.lowest=TRUE, labels=FALSE))

  for(jjj in 1:n.group) {
    partitions[[jjj]] <- rows_rand[partitions[[jjj]]]
  }

  ### Here we are going to pick the best value of lambda through cross validation
  risk_cvsplit <- lapply(1:n.group, function(j) {
    return(risk_cvsplit_fcn(j, partitions, basis_0, basis_1, probs$p_flip, lambda_grid, pt, omega, basis_0.grid, basis_1.grid))
  })

  r_cv_split_matrix <- do.call(cbind, risk_cvsplit)
  r_cv_split_vec <- apply(r_cv_split_matrix, 1, mean)
  names(r_cv_split_vec) <- lambda_grid

  ## Get the value of lambda that corresponds to the smallest risk
  lambda_opt <- lambda_grid[which.min(r_cv_split_vec)]
  if (is.na(lambda_opt_param) == F) {
    lambda_opt <- lambda_opt_param
  }

  ## 2D grid search for gamma and theta (1D if user specifies there is no bias)
  if (bias_indicator == F) {
    theta_grid <- 0
  }
  ## Iterate over every value of lambda and theta
  gamma_theta_matrix <- matrix(NA, ncol=length(theta_grid), nrow=length(gamma_grid))
  colnames(gamma_theta_matrix) <- theta_grid
  rownames(gamma_theta_matrix) <- gamma_grid

  for (i in 1:length(gamma_grid)) {
    g <- gamma_grid[i]
    for (j in 1:length(theta_grid)) {
      t <- theta_grid[j]
      score <- tweed.adj.fcn(lambda_opt, g, t, probs$p.tilde, probs$p_flip, pt,
                             probs, omega, basis_0, basis_1, basis_sum, basis_0.grid,
                             basis_1.grid, win_index, lose_index)
      gamma_theta_matrix[i,j] <- score
    }
  }

  ## Get the value of gamma and theta that maximized the MLE
  max_pair <- which(gamma_theta_matrix == max(gamma_theta_matrix), arr.ind = TRUE)
  gamma_opt <- gamma_grid[max_pair[1]]
  if (is.na(gamma_opt_param) == F) {
    gamma_opt <- gamma_opt_param
  }
  theta_opt <- theta_grid[max_pair[2]]

  params <- c(gamma_opt, theta_opt)
  names(params) <- c("Estimate of Corruption (gamma) ", "Estimate of Bias (theta)")

  return(params)
}















