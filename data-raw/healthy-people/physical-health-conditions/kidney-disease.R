# ---- Load packages ----
library(tidyverse)
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

# ---- Extract and clean ----
# Source: https://www.healthmapswales.wales.nhs.uk/data-catalog-explorer/indicator/I909/?geoId=G108&view=metadata
hpe_kidney_disease <- read.csv("data-raw/healthy-people/physical-health-conditions/kidney-disease.csv") |>
  select(
    ltla21_name = `NAME`,
    kidney_disease_mortality_per_100000 = `X2022` # Column contains urinary system deaths per 100,000, age standardised
  ) |>
  right_join(wales_lookup) |>
  select(ltla21_code, kidney_disease_mortality_per_100000) |>
  arrange(ltla21_code)

# ---- Save output to data/ folder ----
usethis::use_data(hpe_kidney_disease, overwrite = TRUE)