# Functions for desirability graphs

# Generate a matrix with desirability predictions within the experimental region
d_matrix <- function(model_1, model_2, model_3, model_4, 
                     dObject,  c3 = -1, l_x = c(-1, 1), by = 0.1){
  
  x <- seq(l_x[1], l_x[2], by = by)
  lx <- length(x)
  
  data_x <- expand.grid(x1 = x, x2 = x, x3 = c3)
  
  y_1 <- predict(y1_m, data_x)
  y_2 <- predict(y2_m, data_x)
  y_3 <- predict(y3_m, data_x)
  y_4 <- predict(y4_m, data_x)
  
  d_m <- predict(D_overall, data.frame(Y1 = y_1, Y2 = y_2, Y3 = y_3, Y4 = y_4))
  dim(d_m) <- c(lx, lx)
  
  list(d_m = d_m, x = x)
}

# Deploys a contour plot for desirability within the experimental region
contour_d <- function(data = NULL, main = " ",  xlab = "x1", ylab = "x2"){
  
  filled.contour(
    z = data$d_m, x = data$x, y = data$x, 
    color.palette = colorRamps::matlab.like,
    plot.title = title(main = main, xlab = xlab, ylab = ylab, cex.lab = 1.5, 
                       cex.main = 1.5),
    plot.axes = {
      axis(1, cex.axis = 1.5)
      axis(2, cex.axis = 1.5)
    }
  )
}