# ---- Load packages ----
library(tidyverse)
library(readxl)
library(httr)

# ---- Scrape URL for drug deaths ----
# ---- Source: https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/datasets/drugmisusedeathsbylocalauthority ----
drug_url <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/datasets/drugmisusedeathsbylocalauthority/current/2022localauthorities.xlsx"

# ---- Download and read URL as temp file ----
drug_temp_file <- tempfile(fileext = ".xlsx")
download.file(drug_url, drug_temp_file, mode = "wb")
drug_data <- read_excel(drug_temp_file)

# ---- Scrape URL for population ----
# ---- Source: https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationestimates/datasets/estimatesofthepopulationforenglandandwales
population_url <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/populationandmigration/populationestimates/datasets/estimatesofthepopulationforenglandandwales/mid20222023localauthorityboundaires/mye22tablesew2023geogsv2.xlsx"

# ---- Download and read URL as temp file ----
population_temp_file <- tempfile(fileext = ".xlsx")
download.file(population_url, population_temp_file, mode = "wb")
population_data <- read_excel(population_temp_file)

# ---- Reduce datasets to only include Wales ----
# ---- Drug dataset includes total number of deaths related to drug poisoning per Welsh local authority in 2022 ----
# ---- Population dataset includes estimated population of each Welsh local authority in 2022 ----
drug_wales <- read_excel(drug_temp_file, sheet = "Table 1", range = "A4:E432") |>
  filter(str_starts(`Area Codes`, "W0")) 
population_wales <- read_excel(population_temp_file, sheet = "MYE2 - Persons", range = "A8:D365") |>
  filter(str_starts(`Code`, "W0")) 

# ---- Merge datasets and clean ----
# ---- Drug poisoning death rate variable is drug poisoning related deaths per 1000 people ----
hl_drug_misuse <- drug_wales |>
  left_join(population_wales, by = c("Area Codes" = "Code")) |>
  select(where(~ all(!is.na(.)))) |>
  select(
    -`...4`,
    -`Name`,
    -`Geography`
  ) |>
  rename(
    "ltla21_code" = `Area Codes`,
  ) |>
  arrange(ltla21_code) |>
  mutate(
    "Drug poisoning death rate" = `2022` / `All ages` * 1000,
    Year = "2022"
  ) |>
  select(
    -`2022`,
    -`All ages`,
    ) 
 
# ---- Save output to data/ folder ----
usethis::use_data(hl_drug_misuse, overwrite = TRUE)
