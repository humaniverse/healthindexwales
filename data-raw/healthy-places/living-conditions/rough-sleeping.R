# ---- Loading  libraries ----
library(tidyverse)
library(geographr)
library(here)

# ---- Read csv files for rough sleepers and population data ----
# Source: https://statswales.gov.wales/Catalogue/Housing/Homelessness/homelessness-accommodation-provision-and-rough-sleeping/roughsleepers-by-localauthority. 
# Data needs to be manually downloaded and saved in the raw-data/ folder
rough_sleepers_data <- read_csv(here("data-raw", "healthy-places", "living-conditions", "raw-data", "rough_sleepers_data.csv"))


# Source: https://statswales.gov.wales/Catalogue/Population-and-Migration/Population/Estimates/Local-Authority/populationestimates-by-localauthority-year.
# Data needs to be manually downloaded and saved in the raw-data/ folder
population_df_wales <- read_csv(here("data-raw", "healthy-places", "living-conditions", "raw-data", "export.csv"))

# Filter to include mid-year 2023 data
population_df_wales <- population_df_wales |>
  select(`...4`, `...13`) |>
  slice(12:33)

# Filter to include data from June 2023 - June 2024 
rough_sleepers_data <- rough_sleepers_data |>
  select(1, `...4`:`...16`) |>
  slice(4:25) 

# ---- Merge data sets to  calculate the % of people in each LA who are rough ----
# sleepers, and clean
# Rename first column in each data frame to local_authority ---
names(rough_sleepers_data)[1] <- "local_authority"
names(population_df_wales)[1] <- "local_authority"

rough_sleepers_data <- rough_sleepers_data |>
  mutate(across(`...4`:`...16`, as.numeric))

rough_sleepers_data <- rough_sleepers_data |>
  rowwise() |>
  mutate(year_sum = sum(c_across(`...4`:`...16`), na.rm = TRUE)) |>
  ungroup() # sum for number of rough sleepers per LA June 2023 to June 2024

population_df_wales <- population_df_wales |>
  mutate(across(`...13`, as.numeric))

hp_rough_sleepers <- rough_sleepers_data |>
  left_join(population_df_wales, by = c("local_authority"))

# Remove monthly columns from June-2023 to June 2024
hp_rough_sleepers <- hp_rough_sleepers[, -2:-14]

# Calculate % of how many people in each Welsh LA are rough sleepers. New
# column created to show this data.
hp_rough_sleepers <- hp_rough_sleepers |>
  mutate(
    percentage =
      (hp_rough_sleepers$year_sum / hp_rough_sleepers$...13.y) * 100
  )

hp_rough_sleepers <- hp_rough_sleepers |>
  mutate(per_1000_pop = percentage * 1000)

# ---- Rename columns and reformat into 'LA ID, data, date' ----
names(hp_rough_sleepers)[5] <- "rough_sleepers_per_1000"

hp_rough_sleepers <- hp_rough_sleepers |>
  mutate(year = "2023-2024")

hp_rough_sleepers <- hp_rough_sleepers |>
  select(-2:-4) |>
  rename(ltla22_name = 1)

hp_rough_sleepers <- hp_rough_sleepers |>
  left_join(lookup_ltla22_ltla23, by = c("ltla22_name"))

hp_rough_sleepers <- hp_rough_sleepers |>
  select(-1, -5, -6)

hp_rough_sleepers <- hp_rough_sleepers |>
  select(3, everything())

# ---- Save output to data/ folder ----
usethis::use_data(hp_rough_sleepers, overwrite = TRUE)
