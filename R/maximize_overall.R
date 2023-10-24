# Optimization function
maximize_overall <- function(int_1 = c(-1.63, 1.63),
                             int_2 = c(-1.63, 1.63),
                             int_3 = c(-1.63, 1.63),
                             dObject = NULL, 
                             space = "square"){
  
  searchGrid <- expand.grid(
    x1 = seq(int_1[1], int_1[2], length.out = 5),
    x2 = seq(int_2[1], int_2[2], length.out = 5),
    x3 = seq(int_3[1], int_3[2], length.out = 5)
  )
  
  for(i in 1:dim(searchGrid)[1]){
    
    tmp <- optim(as.vector(searchGrid[i,]),
                 rsm_opt,
                 dObject = dObject,
                 space = space, 
                 control = list(fnscale = -1))
    
    if(i == 1) best <- tmp
    if(tmp$value > best$value) best <- tmp
  }
  
  best
}