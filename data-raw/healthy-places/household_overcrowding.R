# ---- Load packages ----
library(tidyverse)
library(readxl)
library(httr)

# ---- Scrape URL ----
# ---- Source: https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/housing/datasets/overcrowdingandunderoccupancybyhouseholdcharacteristicsenglandandwalescensus2021/census2021/hou04dataset.xlsx
url <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/housing/datasets/overcrowdingandunderoccupancybyhouseholdcharacteristicsenglandandwalescensus2021/census2021/hou04dataset.xlsx"

# ---- Download and read URL as temp file ----
temp_file <- tempfile(fileext = ".xlsx")
download.file(url, temp_file, mode = "wb")
overcrowding_raw <- read_excel(temp_file, sheet = 4, skip = 2)

# ---- Clean data ----
hp_household_overcrowding <- overcrowding_raw |>
  filter(str_starts(`Area code`, "W")) |>
  slice(2:23) |>
  rowwise() |>
  mutate(
    household_sum =
      sum(c_across(`Occupancy rating of -1 or less`:`Occupancy rating of +2 or more`), na.rm = TRUE)
  ) |>
  ungroup() |> # sum for number of households per LA
  select(`Area code`, `Occupancy rating of -1 or less`, `household_sum`) |>
  rename(
    ltla21_code = 1,
    overcrowding_occupancy_rating = 2
  ) |>
  mutate(
    percentage_households_overcrowding =
      (overcrowding_occupancy_rating / household_sum) * 100,
    year = "2021"
  ) |>
  select(`ltla21_code`, `percentage_households_overcrowding`, `year`)

# ---- Save output to data/ folder ----
usethis::use_data(hp_household_overcrowding, overwrite = TRUE)
