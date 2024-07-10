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
alcohol_data <- read_excel(temp_file, sheet = "Table_2", range = "A7:G366") |>
  filter(str_starts(`Area Code \r\n[note 2]`, "W0")) |>
  select(where(~ all(!is.na(.)))) |>
  mutate_at(vars(`2020 to 2022 \r\nRate per 100,000 \r\n[note 4]`), as.numeric) |>
  select(
    -`2020 to 2022 \r\nNumber of deaths`,
    -`Local Authority District \r\n[note 2]`
  ) |>
  rename(
    "ltla21_code" = `Area Code \r\n[note 2]`,
    "Alcohol death rate per 100,000" = `2020 to 2022 \r\nRate per 100,000 \r\n[note 4]`
  ) |>
  mutate(Year = "2020-2022") |>
  arrange(ltla21_code)

# ---- Save output to data/ folder ----
save(alcohol_data, file = "~/Documents/BRC/health-index-wales/data/hl-alcohol-misuse.rda")
