# ---- Load packages ----
library(tidyverse)
library(readxl)
library(httr)

# ---- Scrape URL ----
# ---- Source: https://www.ons.gov.uk/peoplepopulationandcommunity/healthandsocialcare/causesofdeath/datasets/alcoholspecificdeathsintheukmaindataset ----
url <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/datasets/alcoholspecificdeathsinenglandandwalesbylocalauthority/current/alcoholspecificdeathsbylocalauthority2022.xlsx"

# ---- Download and read URL as temp file ----
temp_file <- tempfile(fileext = ".xlsx")
download.file(url, temp_file, mode = "wb")
excel_data <- read_excel(temp_file)

# ---- Clean data ----
# Filtered dataset includes age standardised alcohol specific death rates per 100,000 people in Wales from 2020-2022
hl_alcohol_misuse <- read_excel(temp_file, sheet = "Table_2", range = "A7:G366") |> # Select correct tab on excel spreadsheet
  filter(str_starts(`Area Code \r\n[note 2]`, "W0")) |> # Filter column to only include welsh ltlas
  select(where(~ all(!is.na(.)))) |> # Exclude columns with NA valuess
  mutate_at(vars(`2020 to 2022 \r\nRate per 100,000 \r\n[note 4]`), as.numeric) |> # Convert columm from character to numeric
  select(
    -`2020 to 2022 \r\nNumber of deaths`,
    -`Local Authority District \r\n[note 2]` # Select only the necessary columns
  ) |>
  rename(
    "ltla21_code" = `Area Code \r\n[note 2]`,
    "Alcohol death rate per 100,000" = `2020 to 2022 \r\nRate per 100,000 \r\n[note 4]`
  ) |>
  mutate(Year = "2020-2022") |> # Create column for year
  arrange(ltla21_code)

# ---- Save output to data/ folder ----
usethis::use_data(hl_alcohol_misuse, overwrite = TRUE)
