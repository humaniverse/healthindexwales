# ---- Load packages ----
library(e1071)

# ---- Alcohol misuse skew ----
#Load dataset
load("data/hl_alcohol_misuse.rda")

#Check for skew
plot(density(hl_alcohol_misuse$`Alcohol death rate per 100,000`))
skewness_value <- skewness(hl_alcohol_misuse$`Alcohol death rate per 100,000`)
print(paste("Skewness:", skewness_value))

# ---- Drug misuse skew ----
#Load dataset
load("data/hl_drug_misuse.rda")

#Check for skew
plot(density(hl_drug_misuse$`Drug poisoning death rate`))
skewness_value <- skewness(hl_drug_misuse$`Drug poisoning death rate`)
print(paste("Skewness:", skewness_value))

# ---- Healthy eating skew ----
#Load dataset
load("data/hl_healthy_eating.rda")

#Check for skew
plot(density(hl_healthy_eating$`Percent adults who ate five fruit/veg yesterday`))
skewness_value <- skewness(hl_healthy_eating$`Percent adults who ate five fruit/veg yesterday`)
print(paste("Skewness:", skewness_value))

# ---- Physical activity skew ----
#Load dataset
load("data/hl_physical_activity.rda")

#Check for skew
plot(density(hl_physical_activity$`Percent adults active at least 150 minutes last week`))
skewness_value <- skewness(hl_physical_activity$`Percent adults active at least 150 minutes last week`)
print(paste("Skewness:", skewness_value))

# ---- Sedentary behaviour skew ----
#Load dataset
load("data/hl_sedentary_behaviour.rda")

#Check for skew
plot(density(hl_sedentary_behaviour$`Percent adults active less than 30 minutes last week`))
skewness_value <- skewness(hl_sedentary_behaviour$`Percent adults active less than 30 minutes last week`)
print(paste("Skewness:", skewness_value))

# ---- Smoking skew ----
#Load dataset
load("data/hl_smoking.rda")

#Check for skew
plot(density(hl_smoking$`Percentage smokers`))
skewness_value <- skewness(hl_smoking$`Percentage smokers`)
print(paste("Skewness:", skewness_value))

# ---- Early development skew ----
#Load dataset
load("data/hl_early_years_development.rda")

#Check for skew
plot(density(hl_early_years_development$`Percent pupils achieving expected level across four foundation phase tested areas`))
skewness_value <- skewness(hl_early_years_development$`Percent pupils achieving expected level across four foundation phase tested areas`)
print(paste("Skewness:", skewness_value))
