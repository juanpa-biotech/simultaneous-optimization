# Prediction function
rsm_opt <- function(x, dObject, space = "square"){
  
  df <- data.frame(x1 = x[1], x2 = x[2], x3 = x[3])
  
  y1 <- predict.lm(y1_m, df)
  y2 <- predict.lm(y2_m, df)
  y3 <- predict.lm(y3_m, df)
  y4 <- predict.lm(y4_m, df)
  
  out <- predict(dObject, data.frame(y1 = y1, y2 = y2, y3 = y3, y4 = y4))
  
  if(space == "circular" & sqrt(sum(x^2)) > 1.63) out <- 0
  else if(space == "square" & any(abs(x) > 1.63)) out <- 0 
  
  out
}