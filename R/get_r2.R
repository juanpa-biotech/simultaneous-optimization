# Get a R^2 and adjusted R^2 from a linear model
get_r2 <- function(model){
  sum_model <- summary(model)
  round(
    c(R2 = sum_model$r.squared, adj.R2 = sum_model$adj.r.squared),
    3
  )
}
