#### total model ####

model_1 <- lm(total_shared ~ samesex +
                female + AGEC + income +
                HSDSIZEC + education + 
                working + province, data = gss,
              weights = weight)

#### model for heterosexual couples ####

model_2 <- lm(total_shared ~ 
                female + AGEC + income +
                HSDSIZEC + education + 
                working + province, data = gss[ which(gss$samesex == "Heterosexual"), ],
              weights = weight)


#### model for same-sex couples ####


model_3 <- lm(total_shared ~ 
                female + AGEC + income +
                HSDSIZEC + education + 
                working + province, data = gss[ which(gss$samesex == "Same-sex"), ],
              weights = weight)


#### save output in a Word document ####

stargazer(model_1, model_2, model_3, title = "Table 2. Regression Models", type="text", out = "output/Table_2.doc")