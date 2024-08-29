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
# Source: https://www.ons.gov.uk/datasets/wellbeing-local-authority/editions/time-series/versions/4
GET(
  "https://download.ons.gov.uk/downloads/datasets/wellbeing-local-authority/editions/time-series/versions/4.xlsx",
  write_disk(tf <- tempfile(fileext = ".xlsx"))
)

# ---- Clean data ----
# The 'Average (mean)' estimate provides the score out of 0-10. The other estimates are
# thresholds (percentages) described in the QMI: https://www.ons.gov.uk/peoplepopulationandcommunity/wellbeing/methodologies/personalwellbeingintheukqmi
hpe_happiness <-
  read_excel(tf, sheet = "Dataset", skip = 2) |>
  filter(Estimate == "Average (mean)") |>
  filter(MeasureOfWellbeing == "Happiness") |>
  select(
    ltla21_code = `Geography code`,
    happiness_score_out_of_10 = `2022-23`
  ) |>
  right_join(wales_lookup) |>
  select(-ltla21_name)

# ---- Save output to data/ folder ----
usethis::use_data(hpe_happiness, overwrite = TRUE)
