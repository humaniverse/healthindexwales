# ---- Load packages ----
library(dplyr)
library(outliers)
library(e1071)

# ---- Create function ----
standardised <- function(file_path, value_column, ltla_column) {
  
  #Load dataset
  load(file_path)
  
  #Extract dataset name
  dataset_name <- gsub("data/", "", file_path)
  dataset_name <- gsub(".rda", "", dataset_name)
  
  #Get dataset variable dynamically
  dataset <- get(ls(pattern = dataset_name))
  
  #Set up the plotting layout: 2 rows, 1 column
  par(mfrow = c(1, 2))
  
  #Check for outliers
  boxplot(dataset[[value_column]], main = paste("Boxplot of", value_column), cex.main = 0.5)
  grubbs_test <- grubbs.test(dataset[[value_column]])
  grubbs_p_value <- grubbs_test$p.value
  if (grubbs_p_value < 0.05) {
    print(paste("Outliers test: Statistically significant (p =", grubbs_p_value, ")"))
  } else {
    print(paste("Outliers test: Not statistically significant (p =", grubbs_p_value, ")"))
  }
  
  # Check for skewness
  plot(density(dataset[[value_column]]), main = paste("Density plot of", value_column), cex.main = 0.5)
  skewness_value <- skewness(dataset[[value_column]], na.rm = TRUE)
  skew_test_p_value <- shapiro.test(dataset[[value_column]])$p.value
  if (skew_test_p_value < 0.05) {
    print(paste("Skewness test: Statistically significant (p =", skew_test_p_value, ", Skewness =", skewness_value, ")"))
  } else {
    print(paste("Skewness test: Not statistically significant (p =", skew_test_p_value, ", Skewness =", skewness_value, ")"))
  }
  
  # Standardize the data
  library(dplyr)
  standardised_data <- dataset |>
    dplyr::mutate(z_score = ((dataset[[value_column]] - mean(dataset[[value_column]], na.rm = TRUE)) / sd(dataset[[value_column]], na.rm = TRUE)) * -1) |>
    dplyr::select(all_of(ltla_column), z_score)
}

# ---- Alcohol misuse standardised ----
hl_alcohol_misuse_standardised <- standardised("data/hl_alcohol_misuse.rda", 
                                                  "Alcohol death rate per 100,000", 
                                                  "ltla21_code")

# ---- Drug misuse standardised ----
hl_drug_misuse_standardised <- standardised("data/hl_drug_misuse.rda", 
                                            "Drug poisoning death rate", 
                                            "ltla21_code")

# ---- Healthy eating standardised ----
hl_healthy_eating_standardised <- standardised("data/hl_healthy_eating.rda", 
                                               "Percent adults who ate five fruit/veg yesterday", 
                                               "ltla21_code")

# ---- Physical activity standardised ----
hl_physical_activity_standardised <- standardised("data/hl_physical_activity.rda", 
                                                  "Percent adults active at least 150 minutes last week", 
                                                  "ltla21_code")

# ---- Sedentary behaviour standardised ----
hl_sedentary_behaviour_standardised <- standardised("data/hl_sedentary_behaviour.rda", 
                                                    "Percent adults active less than 30 minutes last week", 
                                                    "ltla21_code")

# ---- Smoking standardised ----
hl_smoking_standardised <- standardised("data/hl_smoking.rda", 
                                        "Percentage smokers", 
                                        "ltla21_code")

# ---- Early years standardised ----
hl_early_years_development_standardised <- standardised("data/hl_early_years_development.rda", 
                                                        "Percent pupils achieving expected level across four foundation phase tested areas", 
                                                        "ltla21_code")
