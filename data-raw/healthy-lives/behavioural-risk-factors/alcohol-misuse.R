# ---- Load packages ----
library(tidyverse)
library(readxl)
library(httr)

# ---- Download data  ----
# Source: https://www.ons.gov.uk/peoplepopulationandcommunity/healthandsocialcare/causesofdeath/datasets/alcoholspecificdeathsintheukmaindataset ----
url <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/datasets/alcoholspecificdeathsinenglandandwalesbylocalauthority/current/alcoholspecificdeathsbylocalauthority2022.xlsx"

# Download and read URL as temp file 
temp_file <- tempfile(fileext = ".xlsx")
download.file(url, temp_file, mode = "wb")

# ---- Clean data ----
# Filtered dataset includes age standardised alcohol specific death rates per 100,000 people in Wales from 2020-2022
alcohol_misuse_raw <- read_excel(temp_file, sheet = "Table_2", range = "A7:G366") 

hl_alcohol_misuse <- alcohol_misuse_raw |>
  filter(str_starts(`Area Code \r\n[note 2]`, "W0")) |> 
  select(where(~ all(!is.na(.)))) |> 
  mutate_at(vars(`2020 to 2022 \r\nRate per 100,000 \r\n[note 4]`), as.numeric) |> 
  select(
    -`2020 to 2022 \r\nNumber of deaths`,
    -`Local Authority District \r\n[note 2]`
  ) |>
  rename(
    "ltla21_code" = `Area Code \r\n[note 2]`,
    "alcohol_death_rate_per_100k" = `2020 to 2022 \r\nRate per 100,000 \r\n[note 4]`
  ) |>
  mutate(Year = "2020-2022") |> 
  arrange(ltla21_code)

# ---- Save output to data/ folder ----
usethis::use_data(hl_alcohol_misuse, overwrite = TRUE)
