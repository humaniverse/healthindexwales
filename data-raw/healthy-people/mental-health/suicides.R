# ---- Load packages ----
library(tidyverse)
library(httr)
library(readxl)
library(geographr)
library(sf)

# ---- Load functions from utils.R ----
source("R/utils.R")

# ---- Load data ----
# Load Welsh ltla codes and names from geographr 
wales_lookup <-
  boundaries_ltla21 |>
  as_tibble() |>
  select(starts_with("ltla21")) |>
  filter_codes(ltla21_code, "^W")

# Scrape URL and save dataset as tempfile
# Source: https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/datasets/suicidesbylocalauthority
GET(
  "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/datasets/suicidesbylocalauthority/current/suicidesbylocalauthority2022.xlsx",
  write_disk(tf <- tempfile(fileext = ".xslx"))
)

# ---- Clean data ----
# Table 2 contains suicide rates every 100,000 people age standardised
hpe_suicides <- read_excel(
  tf,
  sheet = "Table_2",
  range = "A8:F383"
) |>
  select(
    ltla21_code = `Area Code \r\n[note 2]`,
    suicides_per_100000 = `2020 to 2022 \r\nRate per 100,000 \r\n[note 4]`
  ) |>
  right_join(wales_lookup) |>
  select(-ltla21_name)

# ---- Save output to data/ folder ----
usethis::use_data(hpe_suicides, overwrite = TRUE)
