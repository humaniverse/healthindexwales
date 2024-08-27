# ---- Step 1: Standardise data ----

# ---- Load packages ----
library(dplyr)
library(readxl)
library(tidyverse)

# ---- Join all healthy lives datasets ----
# Create a function to load and join datasets
join_datasets <- function(data_folder, exclude_files) {
  # List all .rda files in the folder
  files <- list.files(path = data_folder, pattern = "\\.rda$", full.names = TRUE) #Gets all rda files from data folder
  files <- files[!basename(files) %in% exclude_files]  #Exclude specific files
  
  datasets <- lapply(files, function(file) {
    load(file)
    dataset_name <- ls()[ls() != "file"]
    dataset <- get(dataset_name) #Reads each file in the folder, lists and retrieves each dataset
    
    # Rename 'ltla21code' to 'ltla21_code' in the reception overweight/obese dataset
    if (dataset_name == "hl_reception_overweight_obese" && "ltla21code" %in% names(dataset)) {
      names(dataset)[names(dataset) == "ltla21code"] <- "ltla21_code" 
    }
    rm(list = dataset_name) #Removes datasets from environment
    dataset
  })
  
  # Perform the full join
  Reduce(function(x, y) full_join(x, y, by = "ltla21_code"), datasets) # Merges all datasets by ltla column
}

# Run the function on data folder
data_folder <- "data"
exclude_files <- c("dftest.rda", "reception_measurement_table_with_ltla.rda", "hp_greenspace_access.rda", "hp_low_level_crimes.rda", "hp_personal_crime.rda", "hl_composite_score.rda") # Exclude files not from healthy lives
joined_data <- join_datasets(data_folder, exclude_files)

# Keep only required columns and rename unclear columns
# Add Combined_vaccination column
joined_data <- joined_data |>
  mutate(`6 in 1 vaccination` = (
    `Diphtheria percentage coverage by 2nd birthday` + 
      `Tetanus percentage coverage by 2nd birthday` + 
      `Whooping cough percentage coverage by 2nd birthday` + 
      `Polio percentage coverage by 2nd birthday` + 
      `Hib percentage coverage by 2nd birthday`) / 5)

# Keep only required columns and rename unclear columns, making sure to position Combined_vaccination correctly
joined_data <- joined_data |>
  dplyr::select(
    -`Diphtheria percentage coverage by 2nd birthday`,
    -`Tetanus percentage coverage by 2nd birthday`,
    -`Whooping cough percentage coverage by 2nd birthday`,
    -`Polio percentage coverage by 2nd birthday`,
    -`Hib percentage coverage by 2nd birthday`,
    -starts_with("ltla21_name"),
    -starts_with("Year"),
    "6 in 1 vaccination",
    "Adult overweight obese" = `percentage_overweight_obese.x`,
    "Alcohol misuse" = `Alcohol death rate per 100,000`,
    "Bowel Cancer Screening" = `Screening uptake percentage.x`,
    "Breast Cancer Screening" = `Screening uptake percentage.y`,
    "Cervical Cancer Screening" = `Screening uptake percentage`,
    "Drug misuse" = `Drug poisoning death rate`,
    "Early years development" = `Percent pupils achieving expected level across four foundation phase tested areas`,
    "Education employment apprenticeship" = `Participation rate under 20`,
    "Healthy eating" = `Percent adults who ate five fruit/veg yesterday`,
    "Literacy score" = `Literacy Point Score`,
    "Low birth weight" = `percentage_low_birth_weights`,
    "MeningitisB vaccination" = `Meningitis B percentage coverage by 2nd birthday`,
    "MMR vaccination" = `MMR percentage coverage by 2nd birthday`,
    "Numeracy score" = `Numeracy Point Score`,
    "Physical activity" = `Percent adults active at least 150 minutes last week`,
    "Pneumococcal vaccination" = `Pneumococcal percentage coverage by 2nd birthday`,
    "Primary absences" = `Primary percentage of absences`,
    "Reception overweight obese" = `percentage_overweight_obese.y`,
    "Secondary absences" = `Secondary percentage of absences`,
    "Sedentary behaviour" = `Percent adults active less than 30 minutes last week`,
    "Smoking" = `Percentage smokers`,
    "Teenage pregnancy" = `Percentage teenage pregnancies`
  )

# Define standardisation function
standardised <- function(dataset, value_column) {
  dataset |>
    mutate(!!sym(value_column) := 
             (.[[value_column]] - mean(.[[value_column]], na.rm = TRUE)) / 
             sd(.[[value_column]], na.rm = TRUE))
}

# Define columns to adjust (multiply by -1 after standardization)
columns_to_adjust <- c("Alcohol misuse", "Drug misuse", "Sedentary behaviour",
                       "Smoking", "Primary absences", "Secondary absences",
                       "Teenage pregnancy", "Low birth weight",
                       "Adult overweight obese", "Reception overweight obese")

# Define columns to standardize (including the ones that will be adjusted)
columns_to_standardize <- names(joined_data)[!names(joined_data) %in% c("ltla21_code")]

# Standardize all columns, then adjust the specified columns
standardised_data <- joined_data |>
  # Standardize all specified columns
  mutate(across(all_of(columns_to_standardize), 
                ~ ( . - mean(., na.rm = TRUE)) / sd(., na.rm = TRUE))) |>
  # Adjust columns by multiplying by -1
  mutate(across(all_of(columns_to_adjust), ~ . * -1))

# Create the composite score so 100 is welsh average
composite_score <- standardised_data |>
  mutate(across(all_of(columns_to_standardize), ~ . * 10 + 100)) 

# Add composite score column and subdomain columns
composite_score <- composite_score |>
  mutate(`Composite score` = rowSums(across(-ltla21_code)) / 23) |>
  mutate(`Behavioural risk score` = (`Alcohol misuse` + `Drug misuse` + `Healthy eating` + `Physical activity` + `Sedentary behaviour` + `Smoking`) / 6) |>
  mutate(`Children & young people score` = (`Early years development` + `Primary absences` + `Secondary absences` + `Literacy score` + `Numeracy score` + `Teenage pregnancy` + `Education employment apprenticeship`) / 7) |>
  mutate(`Physiological risk factors score` = (`Low birth weight` + `Reception overweight obese` + `Adult overweight obese`) / 3) |>
  mutate(`Protective measures score` = (`6 in 1 vaccination` + `MMR vaccination` + `Pneumococcal vaccination` + `MeningitisB vaccination` + `Bowel Cancer Screening` + `Breast Cancer Screening` + `Cervical Cancer Screening`) / 7)

# Add ltla names
# Scrape ltla lookup file
# Specify the URL
# Source: https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/migrationwithintheuk/datasets/userinformationenglandandwaleslocalauthoritytoregionlookup
url <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/populationandmigration/migrationwithintheuk/datasets/userinformationenglandandwaleslocalauthoritytoregionlookup/june2020/lasregionew2021lookup.xlsx"

# Download the file to a temporary location
temp_file <- tempfile(fileext = ".xlsx")
download.file(url, temp_file, mode = "wb")

# Only include relevant columns
code_lookup <- read_excel(temp_file, range = "A5:D366")|>
  filter(str_starts(`LA code`, "W0")) |>
  dplyr::select(`LA code`, `LA name`)

# Merge to composite score dataset
hl_composite_score <- left_join(code_lookup, composite_score, by = c("LA code" = "ltla21_code")) |>
  rename(
    ltla21_code = `LA code`,
    ltla21_name = `LA name`
  )
  
# ---- Save output to data/ folder ----
usethis::use_data(hl_composite_score, overwrite = TRUE)
