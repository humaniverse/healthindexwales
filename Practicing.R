library(dplyr)
library(outliers)
library(e1071)

# Define the function to load and join datasets
join_datasets <- function(data_folder, exclude_files) {
  # List all .rda files in the folder
  list.files(path = data_folder, pattern = "\\.rda$", full.names = TRUE) |>
    (\(files) files[!basename(files) %in% exclude_files])() |>  # Exclude specified files
    lapply(\(file) {
      load(file)
      dataset_name <- ls()[ls() != "file"]
      dataset <- get(dataset_name)
      rm(list = dataset_name)
      dataset
    }) |>
    (\(datasets) Reduce(\(x, y) full_join(x, y, by = "ltla21_code"), datasets))()
}

# Specify the folder containing the datasets and the files to exclude
data_folder <- "data"
exclude_files <- c(".RData", ".Rhistory", "dftest.rda")

# Call the function and store the result
result <- join_datasets(data_folder, exclude_files)

result_filtered <- result |>
  select(-starts_with("ltla21_name"),
         -starts_with("Year")) 

