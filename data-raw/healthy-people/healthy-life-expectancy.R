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
  "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fhealthandsocialcare%2fhealthandlifeexpectancies%2fdatasets%2fhealthstatelifeexpectancyatbirthandatage65bylocalareasuk%2fcurrent/hsleatbirthandatage65byukla201618.xlsx",
  write_disk(tf <- tempfile(fileext = ".xlsx"))
)

# ---- Clean data ----
# Clean male data
hle_males <-
  read_excel(
    tf,
    sheet = "HE - Male at birth",
    range = "A4:I441"
  ) |>
  select(
    ltla21_code = `Area Codes`,
    healthy_life_expectancy_male = HLE
  ) |>
  right_join(wales_lookup) |>
  select(-ltla21_name)

# Clean female data
hle_females <-
  read_excel(
    tf,
    sheet = "HE - Female at birth",
    range = "A4:I441"
  ) |>
  select(
    ltla21_code = `Area Codes`,
    healthy_life_expectancy_female = HLE
  ) |>
  right_join(wales_lookup) |>
  select(-ltla21_name)

# Join male and female cleaned datasets
hle_joined <-
  hle_males |>
  left_join(hle_females)

# ---- Calculate female/male weighted population estimates ----
# Scrape population file URL
GET(
  "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/populationandmigration/populationestimates/datasets/populationestimatesforukenglandandwalesscotlandandnorthernireland/mid2019april2020localauthoritydistrictcodes/ukmidyearestimates20192020ladcodes.xls",
  write_disk(tf <- tempfile(fileext = ".xls"))
)

# Total population
raw_pop_total <-
  read_excel(
    tf,
    sheet = "MYE2 - Persons",
    range = "A5:D431"
  )

pop_total <-
  raw_pop_total |>
  select(
    ltla21_code = Code, pop_total = `All ages`
  ) |>
  right_join(wales_lookup) |>
  select(-ltla21_name)

# Male population 
raw_pop_male <-
  read_excel(
    tf,
    sheet = "MYE2 - Males",
    range = "A5:D431"
  )

pop_male <-
  raw_pop_male |>
  select(
    ltla21_code = Code, pop_male = `All ages`
  ) |>
  right_join(wales_lookup) |>
  select(-ltla21_name)

# Female population 
raw_pop_female <-
  read_excel(
    tf,
    sheet = "MYE2 - Females",
    range = "A5:D431"
  )

pop_female <-
  raw_pop_female |>
  select(
    ltla21_code = Code, pop_female = `All ages`
  ) |>
  right_join(wales_lookup) |>
  select(-ltla21_name)

# Calculate proportions
pop_proportions <-
  pop_total |>
  left_join(pop_male) |>
  left_join(pop_female) |>
  rowwise() |>
  mutate(
    proportion_male = pop_male / pop_total,
    proportion_female = pop_female / pop_total
  ) |>
  ungroup() |>
  select(ltla21_code, starts_with("proportion"))

# Compute population weighted mean HLE
hpe_healthy_life_expectancy <-
  hle_joined |>
  left_join(pop_proportions) |>
  rowwise(ltla21_code) |>
  summarise(
    healthy_life_expectancy = (healthy_life_expectancy_male * proportion_male) + (healthy_life_expectancy_female * proportion_female),
    .groups = "drop"
  )

# ---- Save output to data/ folder ----
usethis::use_data(hpe_healthy_life_expectancy, overwrite = TRUE)
