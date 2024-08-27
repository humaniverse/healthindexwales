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
  "https://www2.nphs.wales.nhs.uk/PubHObservatoryProjDocs.nsf/3653c00e7bb6259d80256f27004900db/920b258a5a6102fc802581a1003c196d/$FILE/PHOFDataDownload2017_v1.xlsx",
  write_disk(tf <- tempfile(fileext = ".xslx"))
)

# ---- Clean data ----
hpe_suicides <-
  read_excel(
    tf,
    sheet = "Wales, HB & LA most recent data" # Read sheet containing most recent data
  ) |>
  filter(Title == "Suicides, 2014 to 2018") |> # Filter to only include hip suicide variable
  select(
    ltla21_name = Area,
    suicides_per_100000 = `Area Value`
  ) |>
  mutate(suicides_per_100000 = as.double(suicides_per_100000)) |>
  right_join(wales_lookup) |>
  select(ltla21_code, suicides_per_100000)

# ---- Save output to data/ folder ----
usethis::use_data(hpe_suicides, overwrite = TRUE)
