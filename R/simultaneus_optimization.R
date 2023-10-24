# Simultaneus Optimization
library(readr)
library(desirability)
library(rsm)
source("R/get_r2.R")
source("R/contour_d.R")

# Import data ------------------------------------------------------
data_tires <- read_csv("data/data_tires.csv")

# Models -----------------------------------------------------------
y1_m  <- rsm(Y1 ~ SO(x1, x2, x3), data = data_tires)
y2_m  <- rsm(Y2 ~ SO(x1, x2, x3), data = data_tires)
y3_m  <- rsm(Y3 ~ SO(x1, x2, x3), data = data_tires)
y4_m  <- rsm(Y4 ~ SO(x1, x2, x3), data = data_tires)

# Table with R-squared for each model --------------------------------
y1_r2 <- get_r2(y1_m)
y2_r2 <- get_r2(y2_m)
y3_r2 <- get_r2(y3_m) 
y4_r2 <- get_r2(y4_m)

r2t <- t(data.frame(y1_m = y1_r2, y2_m = y2_r2, y3_m = y3_r2, y4_m = y4_r2))
r2t

# Simultaneous Optimization ------------------------------------------------

# Source for optimization functions
source("R/rsm_opt.R")
source("R/maximize_overall.R")

# Define desirability functions for each response variable
D_y1 <- dMax(120, 170)
D_y2 <- dMax(1000, 1300)
D_y3 <- dTarget(400, 500, 600)
D_y4 <- dTarget(60, 67.5, 75)
D_overall <- dOverall(D_y1, D_y2, D_y3, D_y4)

# Obtain the overall optimization point
overall_opt <- maximize_overall(dObject = D_overall)
overall_opt

# Optimal point as a data frame
data_opt <- data.frame(
  x1 = overall_opt$par[1],
  x2 = overall_opt$par[2],
  x3 = overall_opt$par[3]
  )

# Predict each response at overall optimization point
y1_opt <- predict.lm(y1_m, data_opt)
y2_opt <- predict.lm(y2_m, data_opt)
y3_opt <- predict.lm(y3_m, data_opt)
y4_opt <- predict.lm(y4_m, data_opt)

# Response predictions in a data frame
res_opt <- data.frame(y1_opt, y2_opt, y3_opt, y4_opt)
rownames(res_opt) <- "Optimal responses"
round(res_opt, 2)

# Optimal desirability values 
d1_opt <- predict(D_y1, y1_opt)
d2_opt <- predict(D_y2, y2_opt)
d3_opt <- predict(D_y3, y3_opt)
d4_opt <- predict(D_y4, y4_opt)

d_opts <- data.frame(d1_opt, d2_opt, d3_opt, d4_opt)
rownames(d_opts) <- "Optimal desiabilities"
round(d_opts, 3)

# Make some contour graphs for global desirability 
source("R/contour_d.R")

# Desirability at x3 = -1
dpx3_1 <- d_matrix(y1_m, y2_m, y3_m, y4_m, D_overall, 
                   c3 = -1, l_x = c(-1.6, 1.6))
contour_d(dpx3_1, main = "x3 = -1")

# Desirability at x3 = 0
dpx3_2 <- d_matrix(y1_m, y2_m, y3_m, y4_m, D_overall, 
                   c3 = 0, l_x = c(-1.6, 1.6))
contour_d(dpx3_2, main = "x3 = 0")

# Desirability at x3 = 1
dpx3_3 <- d_matrix(y1_m, y2_m, y3_m, y4_m, D_overall, 
                   c3 = 1, l_x = c(-1.6, 1.6))
contour_d(dpx3_3, main = "x3 = 1")
