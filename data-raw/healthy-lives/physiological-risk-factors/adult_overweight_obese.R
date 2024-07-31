# ---- loading libraries ----
library(tidyverse)
library(devtools)
library(statswalesr)

# ---- scrape data from stats wales ----
# source:https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/Community-Child-Health
df <- statswales_get_dataset("hlth5072")

# ---- cleaning the dataset ----
# filtered dataset includes percentage of adults aged 16+ with a BMI (>25) classified as overweight (including obese) in Wales
hl_adult_overweight_obese <- df |>
  filter(
    str_starts(Variable_Code, "Dvbmiowob2") &
      str_starts(Year_ItemName_ENG, "2021-22 & 2022-23") &
      str_starts(Area_AltCode1, "W0") & # filters column by local authority
      str_starts(Measure_ItemNotes_ENG, "mean not % where stated") &
      str_starts(Measure_Code, "1") &
      str_starts(Standardisation_Code, "agestand")
  ) |>
  select(
    "ltla21_code" = Area_AltCode1,
    "Percentage_overweight_obese" = Data,
    "Year" = Year_ItemName_ENG
  ) |>
  arrange(ltla21_code)


# ---- saving to the data/ folder ----
usethis::use_data(hl_adult_overweight_obese, overwrite = TRUE)
