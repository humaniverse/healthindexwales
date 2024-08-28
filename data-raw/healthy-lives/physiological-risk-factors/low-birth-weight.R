# ---- Loading libraries ----
library(tidyverse)
library(devtools)
library(statswalesr)

# ---- Scrape data from stats wales ----
# source:https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/Community-Child-Health
df <- statswales_get_dataset("hlth1211")

# ---- Cleaning the dataset ----
# filtered dataset includes percentage of low weight births (< 2500g) in Wales
hl_low_birth_weight <- df |>
  filter(str_starts(Year_ItemName_ENG, "2023") &
    str_starts(Area_AltCode1, "W0") & # Filters column by local authority
    str_starts(Measure_ItemNotes_ENG, "Percentage of singleton births")) |>
  select(
    "ltla21_code" = Area_AltCode1,
    "Low birth weight" = Data,
    "Year" = Year_ItemName_ENG
  ) |>
  arrange(ltla21_code)

# ---- Saving to the data/ folder ----
usethis::use_data(hl_low_birth_weight, overwrite = TRUE)
