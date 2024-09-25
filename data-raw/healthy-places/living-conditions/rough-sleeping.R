# ---- Loading  libraries ----
library(tidyverse)
library(geographr)
library(here)

# ---- Read csv files for rough sleepers and population data ----
# Source: https://statswales.gov.wales/Catalogue/Housing/Homelessness/homelessness-accommodation-provision-and-rough-sleeping/roughsleepers-by-localauthority. 
# Data needs to be manually downloaded and saved in the raw-data/ folder
rough_sleepers <- read_csv(here("data-raw", "healthy-places", "living-conditions", "raw-data", "rough_sleepers_data.csv"))


# Source: https://statswales.gov.wales/Catalogue/Population-and-Migration/Population/Estimates/Local-Authority/populationestimates-by-localauthority-year.
# Data needs to be manually downloaded and saved in the raw-data/ folder
population <- read_csv(here("data-raw", "healthy-places", "living-conditions", "raw-data", "export.csv"))

# Filter to include mid-year 2023 data
population <- population |>
  select(`...4`, `...13`) |>
  slice(12:33)

# Filter to include data from June 2023 - June 2024 
rough_sleepers <- rough_sleepers |>
  select(1, `...4`:`...16`) |>
  slice(4:25) 

# ---- Merge rough sleepers and population dataset ----
# sleepers, and clean
rough_sleepers <- rough_sleepers |>
  rename(local_authority = 1) |>
  mutate(across(`...4`:`...16`, as.numeric)) |>
  rowwise() |>
  mutate(year_sum = sum(c_across(`...4`:`...16`), na.rm = TRUE)) |>
  ungroup() # sum for number of rough sleepers per LA June 2023 to June 2024

population <- population |>
  rename(local_authority = 1) |>
  mutate(across(`...13`, as.numeric))

hp_rough_sleepers <- rough_sleepers |>
  left_join(population, by = c("local_authority"))

# Remove monthly columns from June-2023 to June 2024
hp_rough_sleepers <- hp_rough_sleepers |>
  select(-2:-14) |>
  mutate(
    percentage =
      (hp_rough_sleepers$year_sum / hp_rough_sleepers$...13.y) * 100
  ) |>
  mutate(per_1000_pop = percentage * 1000)

# Rename columns and reformat into 'LA ID, data, date'
hp_rough_sleepers <- hp_rough_sleepers |>
  rename(rough_sleepers_per_1000 = 5)

hp_rough_sleepers <- hp_rough_sleepers |>
  mutate(year = "2023-2024") |>
  select(-2:-4) |>
  rename(ltla22_name = 1) |>
  left_join(lookup_ltla22_ltla23, by = c("ltla22_name")) |>
  select(-1, -5, -6) |>
  select(3, everything())

# ---- Save output to data/ folder ----
usethis::use_data(hp_rough_sleepers, overwrite = TRUE)
