## Program


# 1. Load and Clean the GSS 2017 data

 - load at least the following libraries: library(dplyr), library(stargazer), library(gtsummary), library(flextable) -- the full package list is in renv.lock file
 - load the data file (gss-12M0025-E-2017-c-31_F1.csv) with only the following variables: COM_105, COM_110, COM_115, COM_120, COM_125, COM_130, COM_135, COM_140, COM_145, COM_150, COM_155, PRV, SEX, SEXPR, AGEC, MARSTAT, FAMINCG2, HSDSIZEC, EHG3_01B, WORKLYR, WGHT_PER
 - recode housework variables (COM_105-COM_155) into 1 = shared (values 3 and 4) 0 = not equal (values 1 and 2)
 - recode sex (SEX) into a dummy variable (female = 1)
 - recode sex of the partner (SEXPR) into a dummy variable (female = 1)
 - create a dummy variable for same-sex partners (same-sex = 1)
 - recode marital status (MARSTAT) to married or in common law and others (dummy, married or in common law = 1)
 - create midpoints for household income variable (FAMINCG2), except the highest group, which is just coded as 125000, and take a log of it
 - recode education (EHG3_01B) into a categorical variable (1 = high school or lower, 2 = 
 - college or trades, 3 = university of higher)
 - recode a dummy variable for those who report to have worked in the last 12 months (WORKLYR) (1 = working)
 - recode weights to add up to the actual sample size (divide WGHT_PER by its mean)
 - recode provinces (PRV) to QC, ON, AL, BC, and others (0 = Others, 1 = QC, 2 = ON, 3 = AL, 4 = BC)

# 2. Define the analytic sample

 -  keep only married or in common-law (resulting in 11576 obs) (married == 1)
 -  delete rows where *all* housework variables are missing (resulting in 11196 obs)
 -  create the dependent variable, which is the sum of all shared tasks
 -  keep only the variables we will need ("total_shared", "province", "female", "samesex", "AGEC", "married",
           "income", "HSDSIZEC", "education", "working", "weight")
 -  keep only complete cases (no nas) (resulting in 11004 obs)


# 3. Table of descriptive statistic contrasted by heterosexual/same-sex couples

 -  defining values for categorical vars -- transform them into factors and add labels 
 -  add labels to variables 
 -  prepare descriptive table (weighted) using survey::svydesign and tbl_svysummary
 -  tranform table to flextable (as_flex_table())
 -  saving table in a Word document (save_as_docx())

# 4. Table of multivariate regression analysis (total and by groups)

 -  model for the total sample (using lm with weights)
 -  model for heterosexual couples (using lm with weights)
 -  model for same-sex couples (using lm with weights)
 -  save output in a Word document (using stargazer)
