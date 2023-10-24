# Data for Simultaneus Optimization of Several Response Variables

# From Derringer & Suich (1980)

# Response variables
# Y1: Abrasion index
# Y2: Modulus
# Y3: Elongation at break
# Y4: Hardness

# Factors
# X1: Silicate level
# X2: Silanium level
# X3: Sulfure level

data_tires <- data.frame(
  x1 = c(rep(c(-1, 1), 4), -1.63, 1.63, rep(0, 10)),
  x2 = c(rep(c(-1, -1, 1, 1), 2), 0, 0, -1.63, 1.63, rep(0, 8)),
  x3 = c(1, -1, -1, 1, -1, 1, 1, -1, 0, 0, 0, 0, -1.63, 1.63, 0, 0, 0, 0, 0, 0),
  Y1 = c(102, 120, 117, 198, 103, 132, 132, 139, 102, 154, 96,
         163, 116, 153, 133, 133, 140, 142, 145, 142),
  Y2 = c(900, 860, 800, 2294, 490, 1289, 1270, 1090, 770, 1690,
         700, 1540, 2184, 1784, 1300, 1300, 1145, 1090, 1260, 
         1344),
  Y3 = c(470, 410, 570, 240, 640, 270, 410, 380, 590, 260, 520,
         380, 520, 290, 380, 380, 430, 430, 390, 390),
  Y4 = c(67.5, 65, 77.5, 74.5, 62.5, 67, 78, 70, 76, 70, 63, 
         75, 65, 71, 70, 68.5, 68, 68, 69, 70)
  )

readr::write_csv(data_tires, file = "data/data_tires.csv")


