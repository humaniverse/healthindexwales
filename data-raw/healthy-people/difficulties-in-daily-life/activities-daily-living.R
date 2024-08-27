# ---- Load packages ----
library(tidyverse)
library(httr)
library(statswalesr)
library(geographr)
library(sf)

# ---- Load data ----
# Load Welsh ltla codes from geographr 
wales_codes <-
  boundaries_ltla21 |>
  as_tibble() |>
  select(starts_with("ltla21_code")) |>
  filter_codes(ltla21_code, "W") |>
  pull(ltla21_code)

# Scrape data from stats wales
raw <- statswales_get_dataset("hlth5052")

# ---- Clean data ----
adl_unmatched <-
  raw |>
  as_tibble() |>
  select(
    lad_code = Area_Code,
    variable = Variable_ItemName_ENG,
    value = Data,
    measure = Measure_ItemName_ENG,
    standardisation = Standardisation_ItemName_ENG,
    year = Year_ItemName_ENG
  ) |>
  filter(variable == "Limited at all by longstanding illness") |>
  filter(year == "2018-19 & 2019-20") |>
  filter(measure == "Percentage of adults (16)") |>
  filter(standardisation == "Age standardised") |>
  select("ltla21_code" = lad_code,
         limited_adl_percentage = value) |> # Select only required columns
  arrange(ltla21_code) # Arrange in order of ltla code

# Only include ltla codes 
hpe_activities_daily_living <-
  adl_unmatched |>
  filter(ltla21_code %in% wales_codes)

# ---- Save output to data/ folder ----
usethis::use_data(hpe_activities_daily_living, overwrite = TRUE)