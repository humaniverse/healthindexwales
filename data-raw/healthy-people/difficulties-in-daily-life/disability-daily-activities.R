# ---- Load packages ----
library(readr)
library(httr)
library(dplyr)
library(geographr)
library(sf)

# ---- Load functions from utils.R ----
source("R/utils.R")

# ---- Load data ----
# Load Welsh ltla codes from geographr 
wales_codes <-
  boundaries_ltla21 |>
  as_tibble() |>
  select(starts_with("ltla21_code")) |>
  filter_codes(ltla21_code, "W") |>
  pull(ltla21_code)

# Load raw data
# The NOMIS API query creator was used to generate the url in the GET request:
# Source: https://www.nomisweb.co.uk/datasets/apsnew
# Data Set: Annual Population Survery
# Indicator: % aged 16-64 who are EA core or work-limiting disabled
raw <- read_csv("http://www.nomisweb.co.uk/api/v01/dataset/NM_17_5.data.csv?geography=1946157401,1946157395,1946157400,1946157397,1946157392,1946157390,1946157385...1946157387,1946157384,1946157383,1946157399,1946157403,1946157394,1946157404,1946157391,1946157389,1946157398,1946157393,1946157402,1946157396,1946157388,2013265930&date=latest&variable=1733&measures=20599,21001,21002,21003&select=date_name,geography_name,geography_code,variable_name,measures_name,obs_value,obs_status_name")

# ---- Clean data ----
# Keep vars of interest
disability_raw <-
  raw |>
  select(
    ltla21_code = GEOGRAPHY_CODE,
    measures_name = MEASURES_NAME,
    disability_daily_activities_percent = OBS_VALUE
  ) |>
  filter(measures_name == "Variable") |>
  select(-measures_name)

# Remove Wales summary
hpe_disability <-
  disability_raw |>
  filter(ltla21_code != "W92000004")

# Check ltla codes match
if (!setequal(hpe_disability$ltla21_code, wales_codes)) {
  stop("LAD codes do not match")
}

# ---- Save output to data/ folder ----
usethis::use_data(hpe_disability, overwrite = TRUE)
