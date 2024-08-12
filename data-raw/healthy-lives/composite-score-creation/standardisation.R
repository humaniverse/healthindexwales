# ---- Step 1: Standardise data ----

# ---- Load packages ----
library(dplyr)
library(outliers)
library(e1071)
library(DescTools)
library(ggpubr)
library(ggplot2)
library(MASS)
library(psych)
library(ggcorrplot)
library(factoextra)

# ---- Join all healthy lives datasets ----
#Create a function to load and join datasets
join_datasets <- function(data_folder, exclude_files) {
  #List all .rda files in the folder
  files <- list.files(path = data_folder, pattern = "\\.rda$", full.names = TRUE) #Gets all rda files from data folder
  files <- files[!basename(files) %in% exclude_files]  #Exclude specific files
  
  datasets <- lapply(files, function(file) {
    load(file)
    dataset_name <- ls()[ls() != "file"]
    dataset <- get(dataset_name) #Reads each file in the folder, lists and retrieves each dataset
    
    #Rename 'ltla21code' to 'ltla21_code' in the reception overweight/obese dataset
    if (dataset_name == "hl_reception_overweight_obese" && "ltla21code" %in% names(dataset)) {
      names(dataset)[names(dataset) == "ltla21code"] <- "ltla21_code" 
    }
    rm(list = dataset_name) #Removes datasets from environment
    dataset
  })
  
  #Perform the full join
  Reduce(function(x, y) full_join(x, y, by = "ltla21_code"), datasets) #Merges all datasets by ltla column
}

#Run the function on data folder
data_folder <- "data"
exclude_files <- c("dftest.rda", "reception_measurement_table_with_ltla.rda", "hp_greenspace_access.rda", "hp_low_level_crimes.rda", "hp_personal_crime.rda") #Exclude files not from healthy lives
joined_data <- join_datasets(data_folder, exclude_files)

#Keep only required columns and rename unclear columns
joined_data <- joined_data |>
  dplyr::select(-starts_with("ltla21_name"),
         -starts_with("Year"),
         -starts_with("Hib"),  #The vaccination columns all had very high correlation so I only kept diphtheria
         -starts_with("Pneumococcal"),
         -starts_with("Polio"),
         -starts_with("Tetanus"),
         -starts_with("Whooping"),
         -starts_with("Men"),
         -starts_with("MMR"),
         "Adult overweight/obese" = `percentage_overweight_obese.x`,
         "Alcohol misuse" = `Alcohol death rate per 100,000`,
         "Bowel Cancer Screening" = `Screening uptake percentage.x`,
         "Breast Cancer Screening" = `Screening uptake percentage.y`,
         "Cervical Cancer Screening" = `Screening uptake percentage`,
         "Diphteria vaccination" = `Diphtheria percentage coverage by 2nd birthday`,
         "Drug misuse" = `Drug poisoning death rate`,
         "Early years development" = `Percent pupils achieving expected level across four foundation phase tested areas`,
         "Education employment apprenticeship" = `Participation rate under 20`,
         "Healthy eating" = `Percent adults who ate five fruit/veg yesterday`,
         "Literacy score" = `Literacy Point Score`,
         "Low birth weight" = `percentage_low_birth_weights`,
         "Numeracy score" = `Numeracy Point Score`,
         "Physical activity" = `Percent adults active at least 150 minutes last week`,
         "Primary absences" = `Primary percentage of absences`,
         "Reception overweight/obese" = `percentage_overweight_obese.y`,
         "Secondary absences" = `Secondary percentage of absences`,
         "Sedentary behaviour" = `Percent adults active less than 30 minutes last week`,
         "Smoking" = `Percentage smokers`,
         "Teenage pregnancy" = `Percentage teenage pregnancies`)
         

# ---- Create function to check for outliers and skew, then standardise ----
standardised <- function(dataset, value_column, ltla_column) {
  
  #Check for outliers
  grubbs_test <- grubbs.test(dataset[[value_column]])
  grubbs_p_value <- grubbs_test$p.value
  if (grubbs_p_value < 0.05) {
    print(paste("Outliers test: Statistically significant (p =", grubbs_p_value, ")"))
  } else {
    print(paste("Outliers test: Not statistically significant (p =", grubbs_p_value, ")"))
  }
  
  #Create boxplot 
  p1 <- ggplot(dataset, aes(x = "", y = !!sym(value_column))) +
    geom_boxplot() +
    labs(title = paste("Boxplot of", value_column)) +
    theme_minimal()
  
  #Create density plot 
  p2 <- ggplot(dataset, aes(x = !!sym(value_column))) +
    geom_density() +
    labs(title = paste("Density plot of", value_column)) +
    theme_minimal()
  
  #Arrange plots side by side
  ggarrange(p1, p2, ncol = 2, nrow = 1)
  
  #Check for skewness
  skewness_value <- skewness(dataset[[value_column]], na.rm = TRUE)
  skew_test_p_value <- shapiro.test(dataset[[value_column]])$p.value
  if (skew_test_p_value < 0.05) {
    print(paste("Skewness test: Statistically significant (p =", skew_test_p_value, ", Skewness =", skewness_value, ")"))
    
    #Apply Box-Cox transformation if skewness is significant
    #Box-Cox used as was found to be best transformation to reduce skew for drug misuse variable
    boxcox_result <- boxcox(dataset[[value_column]] ~ 1, plotit = FALSE)
    lambda <- boxcox_result$x[which.max(boxcox_result$y)]
    dataset[[value_column]] <- (dataset[[value_column]]^lambda - 1) / lambda
    
    #Check again for skewness after transformation
    skew_test_p_value <- shapiro.test(dataset[[value_column]])$p.value
    skewness_value <- skewness(dataset[[value_column]], na.rm = TRUE)
    print(paste("After Box-Cox transformation: Skewness test: p =", skew_test_p_value, ", Skewness =", skewness_value))
  } else {
    print(paste("Skewness test: Not statistically significant (p =", skew_test_p_value, ", Skewness =", skewness_value, ")"))
  }
  
  #Standardize the data
  dataset <- dataset |>
    dplyr::mutate(!!sym(value_column) := (dataset[[value_column]] - mean(dataset[[value_column]], na.rm = TRUE)) / sd(dataset[[value_column]], na.rm = TRUE))
  
  return(dataset)
}

#Assign ltla_column string to ltla21_code variable
ltla_column <- "ltla21_code"

#List of columns to use in function, excluding ltla column
value_columns <- setdiff(names(joined_data), ltla_column)

#Run loop using 'standardised' function on each column
for (value_column in value_columns) {
  cat("Processing column:", value_column, "\n")
  joined_data <- standardised(joined_data, value_column, ltla_column)
}

#Adjust direction
standardised_data <- joined_data |>
  mutate(across(c(`Alcohol misuse`,
                  `Drug misuse`,
                  `Sedentary behaviour`,
                  `Smoking`,
                  `Primary absences`,
                  `Secondary absences`,
                  `Teenage pregnancy`,
                  `Low birth weight`,
                  `Adult overweight/obese`,
                  `Reception overweight/obese`), 
                ~ . * -1)) |>
  dplyr::select(-starts_with("ltla21_code"))

#Add z scores to create composite score
composite_score <- standardised_data|>
  mutate(`Composite score` = rowSums(across(everything())))
