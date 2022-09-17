install.packages("renv")
library(renv)

renv::init()

install.packages("rlang")
library(rlang)
install.packages("survey")
library(survey)
install.packages("srvyr")
library(srvyr)
install.packages("gtsummary")
library(gtsummary)
install.packages("flextable")
library(flextable)
install.packages("stargazer")
library(stargazer)

renv::snapshot() 


renv::restore() 