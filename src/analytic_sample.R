#### subsetting the data ####

# keep only married or in common-law (resulting in 11576 obs)
gss <- gss[ which(gss$married ==1), ]

# delete rows where all housework variables are missing (resulting in 11196 obs)
gss <- gss[!(is.na(gss$COM_105) & 
               is.na(gss$COM_110) &
               is.na(gss$COM_115) & 
               is.na(gss$COM_120) &
               is.na(gss$COM_125) &
               is.na(gss$COM_130) &
               is.na(gss$COM_135) &
               is.na(gss$COM_140) &
               is.na(gss$COM_145) &
               is.na(gss$COM_150) &
               is.na(gss$COM_155)), ]

# create the dependent variable, which is the sum of all shared tasks
gss <- gss %>%
  mutate(total_shared = select(., COM_105:COM_155) %>% rowSums(na.rm = TRUE))

# keep only the variables we will need
gss <- gss %>%
  select(c("total_shared", "province", "female", "samesex", "AGEC", "married",
           "income", "HSDSIZEC", "education", "working", "weight"))

# keep only complete cases (no nas) (resulting in 11004 obs)
gss <- gss[complete.cases(gss), ]