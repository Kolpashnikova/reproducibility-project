install.packages("renv")
library(renv)

renv::init()

install.packages("rlang")
library(rlang)

renv::snapshot() 


renv::restore() 