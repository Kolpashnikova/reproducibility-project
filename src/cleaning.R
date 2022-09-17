#### loading GSS ####

# create a folder "data" and copy the data files into it

# read the csv file
# and select variables
# COM_* are housework tasks sharing variables
gss <- read.csv('data/gss-12M0025-E-2017-c-31_F1.csv') %>%
  select(c(PUMFID, COM_105, COM_110, COM_115, COM_120, COM_125, 
           COM_130, COM_135, COM_140, COM_145, COM_150, 
           COM_155, PRV, SEX, SEXPR, AGEC, MARSTAT, FAMINCG2, 
           HSDSIZEC, EHG3_01B, WORKLYR, WGHT_PER))

#### variable re-coding ####

# recode housework variables into 1 = shared 0 = not equal
gss <- gss %>% mutate_at(c("COM_105", "COM_110", "COM_115", 
                           "COM_120", "COM_125", 
                           "COM_130", "COM_135", "COM_140", 
                           "COM_145", "COM_150", "COM_155"),
                         funs(recode(., `1`=0, `2`=0, `3`=1, `4`=1)))

gss <- gss %>% mutate(female = SEX - 1)
gss <- gss %>% mutate(sp_female = SEXPR,
                      sp_female = case_when(SEXPR == 0 ~ NA_real_,
                                            SEXPR == 1 ~ 0,
                                            SEXPR == 2 ~ 1))


gss <- gss %>% mutate(married = MARSTAT,
                      married = case_when(MARSTAT < 3 ~ 1,
                                          MARSTAT > 2 & MARSTAT <= 6 ~ 0,
                                          MARSTAT > 90 ~ NA_real_))

gss <- gss %>% mutate(income = FAMINCG2,
                      income = case_when(FAMINCG2 == 1 ~ 12500,
                                         FAMINCG2 == 2 ~ 37500,
                                         FAMINCG2 == 3 ~ 62500,
                                         FAMINCG2 == 4 ~ 87500,
                                         FAMINCG2 == 5 ~ 112500,
                                         FAMINCG2 == 6 ~ 125000)) %>%
  mutate(income = log(income))


gss <- gss %>% mutate(education = EHG3_01B,
                      education = case_when(EHG3_01B < 3 ~ 1,
                                            EHG3_01B > 2 & EHG3_01B <= 6 ~ 2,
                                            EHG3_01B > 5 & EHG3_01B < 8 ~ 3,
                                            EHG3_01B > 90 ~ NA_real_))

gss <- gss %>% mutate(working = WORKLYR,
                      working = case_when(WORKLYR == 2 ~ 0,
                                          WORKLYR == 1 ~ 1,
                                          WORKLYR > 2 ~ NA_real_))

gss$weight <- gss$WGHT_PER/mean(gss$WGHT_PER)

gss <- gss %>% mutate(samesex = case_when(female == 1 & sp_female == 1 ~ 1,
                                          female == 0 & sp_female == 0 ~ 1,
                                          female == 1 & sp_female == 0 ~ 0,
                                          female == 0 & sp_female == 1 ~ 0))


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

gss <- gss %>%
  mutate(total_shared = select(., COM_105:COM_155) %>% rowSums(na.rm = TRUE))

# keep only the variables we will need
gss <- gss %>%
  select(c("total_shared", "PRV", "female", "samesex", "AGEC", "married",
           "income", "HSDSIZEC", "education", "working", "weight"))

# keep only complete cases (no nas) (resulting in 11004 obs)
gss <- gss[complete.cases(gss), ]