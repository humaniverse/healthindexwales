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
# Source: https://www.ons.gov.uk/peoplepopulationandcommunity/healthandsocialcare/causesofdeath/datasets/avoidablemortalitybylocalauthorityinenglandandwales
GET(
  "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/healthandsocialcare/causesofdeath/datasets/avoidablemortalitybylocalauthorityinenglandandwales/2022/avoidablemortalitybylocalauthority2022postcheckgc.xlsx",
  write_disk(tf <- tempfile(fileext = ".xlsx"))
)
  
# ---- Clean data ----
hpe_avoidable_deaths <-  read_excel(
  tf,
  sheet = "Table_1",
  range = "A7:CE1075"
) |>
  filter(str_starts(`Sex`, "Persons")) |>
  select(
    ltla21_code = `Area Code`,
    avoidable_deaths_per_100000 = `Rate per 100,000 population\r\n2020-2022`
  ) |>
  right_join(wales_lookup) |>
  select(-ltla21_name)

# ---- Save output to data/ folder ----
usethis::use_data(hpe_avoidable_deaths, overwrite = TRUE)
