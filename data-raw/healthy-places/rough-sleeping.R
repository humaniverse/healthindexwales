# ---- Load libraries ----
library(tidyverse)
library(geographr)

# ---- Read csv files for rough sleepers and population data ----
# Source: https://statswales.gov.wales/Catalogue/Housing/Homelessness/homelessness-accommodation-provision-and-rough-sleeping/roughsleepers-by-localauthority.
# Data needs to be manually downloaded and saved in the raw-data/ folder
rough_sleepers_raw <- read_csv("data-raw/healthy-places/living-conditions/raw-data/rough_sleepers_data.csv")

# Source: https://statswales.gov.wales/Catalogue/Population-and-Migration/Population/Estimates/Local-Authority/populationestimates-by-localauthority-year.
# Data needs to be manually downloaded and saved in the raw-data/ folder
population_raw <- read_csv("data-raw/healthy-places/living-conditions/raw-data/export.csv")

population <- population_raw |>
  select(`...4`, `...13`) |> # Include mid-year 2023 data only
  slice(12:33)

rough_sleepers <- rough_sleepers_raw |>
  select(1, `...4`:`...16`) |> # Include data from June 2023 - June 2024 only
  slice(4:25)

# ---- Merge rough sleepers and population dataset ----
rough_sleepers <- rough_sleepers |>
  rename(ltla22_name = 1) |>
  mutate(across(`...4`:`...16`, as.numeric)) |>
  rowwise() |>
  mutate(year_sum = sum(c_across(`...4`:`...16`), na.rm = TRUE)) |>
  ungroup() # sum for number of rough sleepers per LA June 2023 to June 2024

population <- population |>
  rename(ltla22_name = 1) |>
  mutate(across(`...13`, as.numeric))

hp_rough_sleepers <- rough_sleepers |>
  left_join(population, by = c("ltla22_name")) |>
  mutate(
    percentage =
      (year_sum / `...13.y`) * 100
  ) |>
  mutate(
    rough_sleepers_per_1k_population = percentage * 1000,
    year = "2023-2024"
  ) |>
  rename(ltla22_name = 1) |>
  left_join(lookup_ltla22_ltla23, by = c("ltla22_name")) |>
  select(
    ltla22_code,
    rough_sleepers_per_1k_population,
    year
  )

# ---- Save output to data/ folder ----
usethis::use_data(hp_rough_sleepers, overwrite = TRUE)
