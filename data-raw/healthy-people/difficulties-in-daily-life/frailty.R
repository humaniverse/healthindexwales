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
hpe_frailty <-
  read_excel(
    tf,
    sheet = "Wales, HB & LA most recent data" # Read sheet containing most recent data
  ) |>
  filter(Title == "Hip fractures among older people, 2018/19") |> # Filter to only include hip fracture variable
  select(
    ltla21_name = Area,
    hip_fractures_per_100000 = `Area Value`
  ) |>
  mutate(hip_fractures_per_100000 = as.double(hip_fractures_per_100000)) |>
  right_join(wales_lookup) |>
  select(ltla21_code, hip_fractures_per_100000) |>
  arrange(ltla21_code)

# ---- Save output to data/ folder ----
usethis::use_data(hpe_frailty, overwrite = TRUE)
write_rds(hip_fractures, "data/vulnerability/health-inequalities/wales/healthy-people/frailty.rds")