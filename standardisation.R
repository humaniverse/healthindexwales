# ---- Load packages ----
library(tidyverse)
library(psych)

# ---- Alcohol misuse standardised ----
#Load dataset
load("data/hl_alcohol_misuse.rda")

# ---- Calculate z score ----
hl_alcohol_misuse_standardised <- hl_alcohol_misuse |>
  mutate(alcohol_misuse_z_score = ((`Alcohol death rate per 100,000` - mean(hl_alcohol_misuse$`Alcohol death rate per 100,000`, na.rm = TRUE)) / sd(hl_alcohol_misuse$`Alcohol death rate per 100,000`, na.rm = TRUE))*-1) |>
  select(ltla21_code, alcohol_misuse_z_score)

# ---- Drug misuse standardised ----
#Load dataset
load("data/hl_drug_misuse.rda")

# ---- Calculate z score ----
hl_drug_misuse_standardised <- hl_drug_misuse |>
  mutate(drug_misuse_z_score = ((`Drug poisoning death rate` - mean(hl_drug_misuse$`Drug poisoning death rate`, na.rm = TRUE)) / sd(hl_drug_misuse$`Drug poisoning death rate`, na.rm = TRUE))*-1) |>
  select(ltla21_code, drug_misuse_z_score)

# ---- Healthy eating standardised ----
#Load dataset
load("data/hl_healthy_eating.rda")

# ---- Calculate z score ----
hl_healthy_eating_standardised <- hl_healthy_eating |>
  mutate(healthy_eating_z_score = (`Percent adults who ate five fruit/veg yesterday` - mean(hl_healthy_eating$`Percent adults who ate five fruit/veg yesterday`, na.rm = TRUE)) / sd(hl_healthy_eating$`Percent adults who ate five fruit/veg yesterday`, na.rm = TRUE)) |>
  select(ltla21_code, healthy_eating_z_score)

# ---- Physical activity standardised ----
#Load dataset
load("data/hl_physical_activity.rda")

# ---- Calculate z score ----
hl_physical_activity_standardised <- hl_physical_activity |>
  mutate(physical_activity_z_score = (`Percent adults active at least 150 minutes last week` - mean(hl_physical_activity$`Percent adults active at least 150 minutes last week`, na.rm = TRUE)) / sd(hl_physical_activity$`Percent adults active at least 150 minutes last week`, na.rm = TRUE)) |>
  select(ltla21_code, physical_activity_z_score)

# ---- Sedentary behaviour standardised ----
#Load dataset
load("data/hl_sedentary_behaviour.rda")

# ---- Calculate z score ----
hl_sedentary_behaviour_standardised <- hl_sedentary_behaviour |>
  mutate(sedentary_behaviour_z_score = ((`Percent adults active less than 30 minutes last week` - mean(hl_sedentary_behaviour$`Percent adults active less than 30 minutes last week`, na.rm = TRUE)) / sd(hl_sedentary_behaviour$`Percent adults active less than 30 minutes last week`, na.rm = TRUE))*-1) |>
  select(ltla21_code, sedentary_behaviour_z_score)

# ---- Smoking standardised ----
#Load dataset
load("data/hl_smoking.rda")

# ---- Calculate z score ----
hl_smoking_standardised <- hl_smoking |>
  mutate(smoking_z_score = ((`Percentage smokers` - mean(hl_smoking$`Percentage smokers`, na.rm = TRUE)) / sd(hl_smoking$`Percentage smokers`, na.rm = TRUE))*-1) |>
  select(ltla21_code, smoking_z_score)

# ---- Join standardised datasets ----
hl_behavioural_risk_factors <- hl_alcohol_misuse_standardised |>
  left_join(hl_drug_misuse_standardised, by = "ltla21_code") |>
  left_join(hl_healthy_eating_standardised, by = "ltla21_code") |>
  left_join(hl_physical_activity_standardised, by = "ltla21_code") |>
  left_join(hl_sedentary_behaviour_standardised, by = "ltla21_code") |>
  left_join(hl_smoking_standardised, by = "ltla21_code") |>
  select(-ltla21_code)

# ---- Run factor analysis ----
fa_behavioural_risk_factors <- fa(r = hl_behavioural_risk_factors, nfactors = 1, rotate = "varimax")
print(fa_behavioural_risk_factors$loadings)

# Convert to a dataframe with proper column names
loadings_df <- as.data.frame(fa_behavioural_risk_factors$loadings)
loadings_df$variable <- rownames(loadings_df)

# Rename columns if necessary
colnames(loadings_df) <- c("MR1", "variable")

# Plot
ggplot(loadings_df, aes(x = variable, y = MR1)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  theme_minimal() +
  labs(title = "Factor Loadings for MR1", y = "Loading", x = "Variable")
