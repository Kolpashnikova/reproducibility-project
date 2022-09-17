#### Reproducibility Module Program ####


# 1. Load and Clean the GSS 2017 data

## - load the data file
## - recode housework variables into 1 = shared 0 = not equal
## - recode sex into a dummy variable (female = 1)
## - recode sex of the partner into a dummy variable (female = 1)
## - create a dummy variable for same-sex partners (same-sex = 1)
## - recode marital status to married or in common law and others (dummy, married or in common law = 1)
## - create midpoints for household income variable and take a log of it
## - recode education into a categorical variable (1 = high school or lower, 2 = 
## - college or trades, 3 = university of higher)
## - recode a dummy variable for those who report to have worked in the last 12 months
## - recode weights to add up to the actual sample size
## - recode provinces to QC, ON, AL, BC, and others

# to  all above in (1), run the following line:
source("src/cleaning.R")

# 2. Define the analytic sample

## -  keep only married or in common-law (resulting in 11576 obs)
## -  delete rows where all housework variables are missing (resulting in 11196 obs)
## -  create the dependent variable, which is the sum of all shared tasks
## -  keep only the variables we will need
## -  keep only complete cases (no nas) (resulting in 11004 obs)

# to  all above in (2), run the following line:
source("src/analytic_sample.R")

# 3. Table of descriptive statistic contrasted by heterosexual/same-sex couples

## -  defining values for categorical vars 
## -  add labels to variables 
## -  prepare descriptive table (weighted) 
## -  saving output in a Word document

# to  all above in (3), run the following line:
source("src/descriptive_stats.R")

# 4. Table of multivariate regression analysis (total and by groups)

## -  model for the total sample 
## -  model for heterosexual couples 
## -  model for same-sex couples 
## -  save output in a Word document 

# to  all above in (4), run the following line:
source("src/regression_models.R")

# the tables will be in the 'output' folder