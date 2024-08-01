# ---- Load packages ----
library(outliers)


# ---- Alcohol misuse outliers ----
#Load dataset
load("data/hl_alcohol_misuse.rda")

#Check for outliers
boxplot(hl_alcohol_misuse$`Alcohol death rate per 100,000`)
grubbs_test <- grubbs.test(hl_alcohol_misuse$`Alcohol death rate per 100,000`)
print(grubbs_test)

# ---- Drug misuse outliers ----
#Load dataset
load("data/hl_drug_misuse.rda")

#Check for outliers
boxplot(hl_drug_misuse$`Drug poisoning death rate`)
grubbs_test <- grubbs.test(hl_drug_misuse$`Drug poisoning death rate`)
print(grubbs_test)

# ---- Healthy eating outliers ----
#Load dataset
load("data/hl_healthy_eating.rda")

#Check for outliers
boxplot(hl_healthy_eating$`Percent adults who ate five fruit/veg yesterday`)
grubbs_test <- grubbs.test(hl_healthy_eating$`Percent adults who ate five fruit/veg yesterday`)
print(grubbs_test)

# ---- Physical activity outliers ----
#Load dataset
load("data/hl_physical_activity.rda")

#Check for outliers
boxplot(hl_physical_activity$`Percent adults active at least 150 minutes last week`)
grubbs_test <- grubbs.test(hl_physical_activity$`Percent adults active at least 150 minutes last week`)
print(grubbs_test)

# ---- Sedentary behaviour outliers ----
#Load dataset
load("data/hl_sedentary_behaviour.rda")

#Check for outliers
boxplot(hl_sedentary_behaviour$`Percent adults active less than 30 minutes last week`)
grubbs_test <- grubbs.test(hl_sedentary_behaviour$`Percent adults active less than 30 minutes last week`)
print(grubbs_test)

# ---- Smoking outliers ----
#Load dataset
load("data/hl_smoking.rda")

#Check for outliers
boxplot(hl_smoking$`Percentage smokers`)
grubbs_test <- grubbs.test(hl_smoking$`Percentage smokers`)
print(grubbs_test)

# ---- Early years outliers ----
#Load dataset
load("data/hl_early_years_development.rda")

#Check for outliers
boxplot(hl_early_years_development$`Percent pupils achieving expected level across four foundation phase tested areas`)
grubbs_test <- grubbs.test(hl_early_years_development$`Percent pupils achieving expected level across four foundation phase tested areas`)
print(grubbs_test)




