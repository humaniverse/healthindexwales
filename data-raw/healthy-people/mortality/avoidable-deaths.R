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
GET(
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fhealthandsocialcare%2fcausesofdeath%2fdatasets%2favoidablemortalitybylocalauthorityinenglandandwales%2f2019/avoidablemortalitybylocalauthority2019.xls",
  write_disk(tf <- tempfile(fileext = ".xls"))
)

# ---- Clean data ----
hpe_avoidable_deaths <-
  read_excel(
    tf,
    sheet = "Table 1 ",
    range = "B5:BS435"
  ) |>
  select(
    ltla21_code = `...1`,
    avoidable_deaths_per_100000 = `Rate per 100,000 population...67`
  ) |>
  right_join(wales_lookup) |>
  select(-ltla21_name)

# ---- Save output to data/ folder ----
usethis::use_data(hpe_avoidable_deaths, overwrite = TRUE)
