# ---- Load ----
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

# Scrape raw data
raw <-
  read_csv("https://www.healthmapswales.wales.nhs.uk/data-catalog-explorer/indicator/I171")

# ---- Clean data ----
asthma_unmatched <-
  raw |>
  select(
    ltla21_name = Name,
    asthma_admission_rate_per_100000 = `Asthma: Emergency Admission Rates (Age-Standardised) per 100K pop(FY 17/18)`
  ) |>
  filter(lad_name != "Wales") |>
  mutate(
    lad_name = if_else(
      lad_name == "The Vale of Glamorgan",
      "Vale of Glamorgan",
      lad_name
    )
  ) |>
  right_join(wales_lookup) |>
  relocate(ltla21_code) |>
  select(-ltla21_name)

write_rds(asthma, "data/vulnerability/health-inequalities/wales/healthy-people/asthma.rds")