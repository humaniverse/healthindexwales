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
exclude_files <- c("dftest.rda", "reception_measurement_table_with_ltla.rda", "hp_greenspace_access.rda", "hp_low_level_crimes.rda", "hp_personal_crime.rda", "composite_score.rda") #Exclude files not from healthy lives
joined_data <- join_datasets(data_folder, exclude_files)

#Keep only required columns and rename unclear columns
joined_data <- joined_data |>
  dplyr::select(-starts_with("ltla21_name"),
         -starts_with("Year"),
         "Adult_overweight_obese" = `percentage_overweight_obese.x`,
         "Alcohol_misuse" = `Alcohol death rate per 100,000`,
         "Bowel_Cancer_Screening" = `Screening uptake percentage.x`,
         "Breast_Cancer_Screening" = `Screening uptake percentage.y`,
         "Cervical_Cancer_Screening" = `Screening uptake percentage`,
         "Diphteria_vaccination" = `Diphtheria percentage coverage by 2nd birthday`,
         "Drug_misuse" = `Drug poisoning death rate`,
         "Early_years_development" = `Percent pupils achieving expected level across four foundation phase tested areas`,
         "Education_employment_apprenticeship" = `Participation rate under 20`,
         "Healthy_eating" = `Percent adults who ate five fruit/veg yesterday`,
         "Hib_vaccination" = `Hib percentage coverage by 2nd birthday`,
         "Literacy_score" = `Literacy Point Score`,
         "Low_birth_weight" = `percentage_low_birth_weights`,
         "MeningitisB_vaccination" = `Meningitis B percentage coverage by 2nd birthday`,
         "MMR_vaccination" = `MMR percentage coverage by 2nd birthday`,
         "Numeracy_score" = `Numeracy Point Score`,
         "Physical_activity" = `Percent adults active at least 150 minutes last week`,
         "Pneumococcal_vaccination" = `Pneumococcal percentage coverage by 2nd birthday`,
         "Polio_vaccination" = `Polio percentage coverage by 2nd birthday`,
         "Primary_absences" = `Primary percentage of absences`,
         "Reception_overweight_obese" = `percentage_overweight_obese.y`,
         "Secondary_absences" = `Secondary percentage of absences`,
         "Sedentary_behaviour" = `Percent adults active less than 30 minutes last week`,
         "Smoking" = `Percentage smokers`,
         "Teenage_pregnancy" = `Percentage teenage pregnancies`,
         "Tetanus_vaccination" = `Tetanus percentage coverage by 2nd birthday`,
         "Whooping_cough_vaccination" = `Whooping cough percentage coverage by 2nd birthday`)
         

#Define standardisation function
standardised <- function(dataset, value_column) {
  dataset |>
    mutate(!!sym(value_column) := 
             (.[[value_column]] - mean(.[[value_column]], na.rm = TRUE)) / 
             sd(.[[value_column]], na.rm = TRUE))
}

#Define columns to adjust (multiply by -1 after standardization)
columns_to_adjust <- c("Alcohol_misuse", "Drug_misuse", "Sedentary_behaviour",
                       "Smoking", "Primary_absences", "Secondary_absences",
                       "Teenage_pregnancy", "Low_birth_weight",
                       "Adult_overweight_obese", "Reception_overweight_obese")

#Define columns to standardize (including the ones that will be adjusted)
columns_to_standardize <- names(joined_data)[!names(joined_data) %in% c("ltla21_code")]

#Standardize all columns, then adjust the specified columns
standardised_data <- joined_data |>
  #Standardize all specified columns
  mutate(across(all_of(columns_to_standardize), 
                ~ ( . - mean(., na.rm = TRUE)) / sd(., na.rm = TRUE))) |>
  #Adjust columns by multiplying by -1
  mutate(across(all_of(columns_to_adjust), ~ . * -1)) |>
  #Remove the 'ltla21_code' column
  dplyr::select(-ltla21_code)

#Add z scores to create composite score
composite_score <- standardised_data |>
  mutate(`Composite score` = rowSums(across(everything()))) |>
  mutate(`Behavioural risk composite score` = `Alcohol_misuse` + `Drug_misuse` + `Healthy_eating` + `Sedentary_behaviour` + `Physical_activity` + `Smoking`) |>
  mutate(`Children & young people composite score` = `Early_years_development` + `Primary_absences` + `Secondary_absences` + `Numeracy_score` + `Literacy_score` + `Teenage_pregnancy` + `Education_employment_apprenticeship`) |>
  mutate(`Physiological risk factors composite score` = `Low_birth_weight` + `Reception_overweight_obese` + `Adult_overweight_obese`) |>
  mutate(`Protective measures composite score` = `Bowel_Cancer_Screening` + `Cervical_Cancer_Screening` + `Breast_Cancer_Screening` + `Diphteria_vaccination` + `Hib_vaccination` + `MeningitisB_vaccination` + `Polio_vaccination` + `Tetanus_vaccination` + `MMR_vaccination` + `Pneumococcal_vaccination` + `Whooping_cough_vaccination`)
  
# ---- Save output to data/ folder ----
usethis::use_data(composite_score, overwrite = TRUE)
