#### defining categorical vars ####

gss$province <- factor(gss$province, labels = c("Other", "QC", "ON", "AL", "BC"))
gss$female <- factor(gss$female, labels = c("Male", "Female"))
gss$samesex <- factor(gss$samesex, labels = c("Heterosexual", "Same-sex"))
gss$married <- factor(gss$married, labels = c("Married"))
gss$education <- factor(gss$education, labels = c("High school or less", "College or trade", "University or above"))
gss$working <- factor(gss$working, labels = c("Non-working", "Working"))

#### preparing for output ####

attr(gss$province, "label") <- "Province"
attr(gss$female, "label") <- "Female"
attr(gss$samesex, "label") <- "Same-sex"
attr(gss$AGEC, "label") <- "Age"
attr(gss$married, "label") <- "Married"
attr(gss$income, "label") <- "Log(Household Income)"
attr(gss$HSDSIZEC, "label") <- "Household Size"
attr(gss$education, "label") <- "Education"
attr(gss$working, "label") <- "Working"
attr(gss$weight, "label") <- "Survey Weights"

#### descriptive table (weighted) ####

tbl_svysummary <-
  survey::svydesign(~1, data = gss, weights = ~weight) %>%
  tbl_svysummary(by = samesex, percent = "column", include = c(AGEC, income, HSDSIZEC, 
                                                               female, education, working, province),
                 type = list(AGEC ~ 'continuous',
                             income ~ 'continuous',
                             HSDSIZEC ~ 'continuous'),
                 statistic = list(all_continuous() ~ "{mean} ({sd})",
                                  all_categorical() ~ "{n} ({p}%)"),
                 digits = list(all_continuous() ~ 3,
                               all_categorical() ~ 0)) %>%
  modify_caption("Table 1. Descriptive Statistics") %>%
  as_flex_table()

tbl_svysummary

#### saving output ####

save_as_docx(tbl_svysummary, path = "output/Table_1.docx")