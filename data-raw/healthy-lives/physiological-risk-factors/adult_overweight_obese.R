# ---- Load packages ----
library(tidyverse)
library(devtools)
library(statswalesr)

# ---- Scrape data from stats wales ----
# source:https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/Community-Child-Health
df <- statswales_get_dataset("hlth5072")

# ---- Clean data ----
# Filtered dataset includes percentage of adults aged 16+ with a BMI classified as overweight (>25) (including obese) in Wales.
hl_adult_overweight_obese <- df |>
  filter(
    str_starts(Variable_Code, "Dvbmiowob2") & # Filters column for overweight/obese people
      str_starts(Year_ItemName_ENG, "2021-22 & 2022-23") & # Filters column for most recent data
      str_starts(Area_AltCode1, "W0") & # Filters column to only include Welsh ltlas
      str_starts(Measure_Code, "1") & # Filers for percentage of adults (rather than lower/upper confidence interval or sample)
      str_starts(Standardisation_Code, "agestand") # Filters for age standardised data
  ) |>
  select(
    "ltla21_code" = Area_AltCode1,
    "percentage_overweight_obese" = Data,
    "Year" = Year_ItemName_ENG
  ) |>
  arrange(ltla21_code) # Order by ltla code


# ---- Saving to the data/ folder ----
usethis::use_data(hl_adult_overweight_obese, overwrite = TRUE) 

