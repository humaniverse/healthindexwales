# ---- Load packages ----
library(dplyr)
library(outliers)
library(e1071)

# ---- Create function ----
standardised <- function(file_path, value_column, ltla_column) {
  
  #Load dataset
  load(file_path)
  
  #Extract dataset name (to get name as appears in global environment)
  dataset_name <- gsub("data/", "", file_path) #Removes "data/"
  dataset_name <- gsub(".rda", "", dataset_name) #Removes ".rda"
  
  #Get dataset variable dynamically
  dataset <- get(ls(pattern = dataset_name)) #Finds and retrieves object in R environment whose name matches string assigned to dataset_name
  
  #Set up plotting layout to plot boxplot and density graph next to each other
  par(mfrow = c(1, 2))
  
  #Check for outliers
  #Create boxplot
  boxplot(dataset[[value_column]], main = paste("Boxplot of", value_column), cex.main = 0.5) #Sets font size to 0.5 so all fits on plots pane
  
  #Run grubbs test
  grubbs_test <- grubbs.test(dataset[[value_column]])
  grubbs_p_value <- grubbs_test$p.value
  if (grubbs_p_value < 0.05) {
    print(paste("Outliers test: Statistically significant (p =", grubbs_p_value, ")"))
  } else {
    print(paste("Outliers test: Not statistically significant (p =", grubbs_p_value, ")"))
  } #Using 5% significance level
  
  # Check for skewness
  #Create density plot
  plot(density(dataset[[value_column]]), main = paste("Density plot of", value_column), cex.main = 0.5)
  
  #Run shapiro test - tests whether data normally distributed
  skewness_value <- skewness(dataset[[value_column]], na.rm = TRUE)
  skew_test_p_value <- shapiro.test(dataset[[value_column]])$p.value
  if (skew_test_p_value < 0.05) {
    print(paste("Skewness test: Statistically significant (p =", skew_test_p_value, ", Skewness =", skewness_value, ")"))
  } else {
    print(paste("Skewness test: Not statistically significant (p =", skew_test_p_value, ", Skewness =", skewness_value, ")"))
  } #Using 5% significance level
  
  # Standardize the data
  standardised_data <- dataset |>
    dplyr::mutate(z_score = ((dataset[[value_column]] - mean(dataset[[value_column]], na.rm = TRUE)) / sd(dataset[[value_column]], na.rm = TRUE)) * -1) |> #Create new column of z scores
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
