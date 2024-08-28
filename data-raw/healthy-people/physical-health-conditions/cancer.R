# ---- Load packages ----
library(tidyverse)
library(httr)
library(statswalesr)
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

# Scrape data from StatsWales
raw <-
  statswales_get_dataset("wimd1911")

# ---- Clean data ----
hpe_cancer <-
  raw |>
  as_tibble() |>
  select(
    ltla21_code = LocalAuthority_Code,
    variable = Indicator_ItemName_ENG,
    value = Data
  ) |>
  filter(variable == "Cancer incidence (rate per 100,000)") |>
  right_join(wales_lookup) |>
  select(ltla21_code, cancer_incidence_per_100000 = value)

# ---- Save output to data/ folder ----
usethis::use_data(hpe_cancer, overwrite = TRUE)