library(dplyr)
library(outliers)
library(e1071)

# Define the function to load and join datasets
join_datasets <- function(data_folder, exclude_files) {
  # List all .rda files in the folder
  files <- list.files(path = data_folder, pattern = "\\.rda$", full.names = TRUE)
  files <- files[!basename(files) %in% exclude_files]  # Exclude specified files
  
  datasets <- lapply(files, function(file) {
    load(file)
    dataset_name <- ls()[ls() != "file"]
    dataset <- get(dataset_name)
    
    # Rename 'ltla21code' to 'ltla21_code' in the specific dataset
    if (dataset_name == "hl_reception_overweight_obese" && "ltla21code" %in% names(dataset)) {
      names(dataset)[names(dataset) == "ltla21code"] <- "ltla21_code"
    }
    
    rm(list = dataset_name)
    dataset
  })
  
  # Perform the full join
  Reduce(function(x, y) full_join(x, y, by = "ltla21_code"), datasets)
}

#Run the function on data folder
data_folder <- "data"
exclude_files <- c(".RData", ".Rhistory", "dftest.rda", "reception_measurement_table_with_ltla.rda")
joined_data <- join_datasets(data_folder, exclude_files)

#Keep only required columns
joined_data <- joined_data |>
  select(-starts_with("ltla21_name"),
         -starts_with("Year"),
         "Bowel Cancer Screening" = `Screening uptake percentage.x`,
         "Breast Cancer Screening" = `Screening uptake percentage.y`,
         "Cervical Cancer Screening" = `Screening uptake percentage`,
         "Adult overweight obese" = `percentage_overweight_obese.x`,
         "Reception overweight obese" = `percentage_overweight_obese.y`)

#Create function to check for outliers, skew and normalise data
library(dplyr)
library(DescTools)  # For Grubbs' test
library(e1071)      # For skewness calculation

standardised <- function(dataset, value_column, ltla_column) {
  
  # Check if the value column exists
  if (!value_column %in% names(dataset)) {
    stop(paste("Column", value_column, "does not exist in the dataset."))
  }
  
  # Set up plotting layout to plot boxplot and density graph next to each other
  par(mfrow = c(1, 2))
  
  # Check for outliers
  # Create boxplot
  boxplot(dataset[[value_column]], main = paste("Boxplot of", value_column), cex.main = 0.5)
  
  # Run Grubbs' test
  grubbs_test <- grubbs.test(dataset[[value_column]])
  grubbs_p_value <- grubbs_test$p.value
  if (grubbs_p_value < 0.05) {
    print(paste("Outliers test: Statistically significant (p =", grubbs_p_value, ")"))
  } else {
    print(paste("Outliers test: Not statistically significant (p =", grubbs_p_value, ")"))
  }
  
  # Check for skewness
  # Create density plot
  plot(density(dataset[[value_column]]), main = paste("Density plot of", value_column), cex.main = 0.5)
  
  # Run Shapiro test
  skewness_value <- skewness(dataset[[value_column]], na.rm = TRUE)
  skew_test_p_value <- shapiro.test(dataset[[value_column]])$p.value
  if (skew_test_p_value < 0.05) {
    print(paste("Skewness test: Statistically significant (p =", skew_test_p_value, ", Skewness =", skewness_value, ")"))
  } else {
    print(paste("Skewness test: Not statistically significant (p =", skew_test_p_value, ", Skewness =", skewness_value, ")"))
  }
  
  # Standardize the data
  dataset <- dataset %>%
    dplyr::mutate(!!value_column := ((dataset[[value_column]] - mean(dataset[[value_column]], na.rm = TRUE)) / sd(dataset[[value_column]], na.rm = TRUE)) * -1)
  
  return(dataset)
}


# Assuming 'combined_dataset' is your large dataset
ltla_column <- "ltla21_code"

# List of columns to process (excluding ltla_column)
value_columns <- setdiff(names(joined_data), ltla_column)

# Process each column
for (value_column in value_columns) {
  cat("Processing column:", value_column, "\n")
  joined_data <- standardised(joined_data, value_column, ltla_column)
}

# Check the resulting dataset
print(head(joined_data))
