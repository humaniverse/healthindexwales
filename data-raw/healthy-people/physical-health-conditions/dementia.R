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
# Source: https://www.healthmapswales.wales.nhs.uk/data-catalog-explorer/indicator/I1462/?view=metadata
hpe_dementia <- read.csv("data-raw/healthy-people/physical-health-conditions/dementia.csv") |>
  select(
    ltla21_name = `NAME`,
    dementia_mortality_per_100000 = `X2022` # Column contains dementia and alzheimers deaths per 100,000, age standardised
  ) |>
  right_join(wales_lookup) |>
  select(ltla21_code, dementia_mortality_per_100000) |>
  arrange(ltla21_code)

# ---- Save output to data/ folder ----
usethis::use_data(hpe_dementia, overwrite = TRUE)
