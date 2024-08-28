# ---- Loading Libraries ----
library(tidyverse)
library(devtools)
library(statswalesr)

# ---- Scrape data from stats wales ----
# source:https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/Community-Child-Health
df <- statswales_get_dataset("hlth5072")

# ---- Cleaning the dataset ----
# Filtered dataset includes percentage of adults aged 16+ with a BMI (>25) classified as overweight (including obese) in Wales.
hl_adult_overweight_obese <- df |>
  filter(
    str_starts(Variable_Code, "Dvbmiowob2") & # % of individuals who are overweight (including obese) BMI 25+
      str_starts(Year_ItemName_ENG, "2021-22 & 2022-23") & # The years the data was collected, spanning a 2 year period
      str_starts(Area_AltCode1, "W0") & # Filters column by local authority
      str_starts(Measure_ItemNotes_ENG, "mean not % where stated") & # when the percentage is not stated, the mean value is used instead
      str_starts(Measure_Code, "1") & # Measuring the percentage of adults (age 16+)
      str_starts(Standardisation_Code, "agestand") # The standardised age
  ) |>
  select(
    "ltla21_code" = Area_AltCode1,
    "Adult overweight obese" = Data,
    "Year" = Year_ItemName_ENG
  ) |>
  arrange(ltla21_code)


# ---- Saving to the data/ folder ----
usethis::use_data(hl_adult_overweight_obese, overwrite = TRUE) 

