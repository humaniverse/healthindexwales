# ---- Load packages ----
library(tidyverse)
library(readxl)
library(httr)

# ---- Scrape URL ----
# ---- Source: https://www.ons.gov.uk/peoplepopulationandcommunity/healthandsocialcare/causesofdeath/datasets/alcoholspecificdeathsintheukmaindataset ----
url <- "https://phw.nhs.wales/services-and-teams/screening/bowel-screening/programme-reports/uptake-coverage-by-local-authority-and-health-boards/bsw-uptake-by-ua-and-hb-2021-22/"

# ---- Download and read URL as temp file ----
temp_file <- tempfile(fileext = ".xls")
download.file(url, temp_file, mode = "wb")
excel_data <- read_excel(temp_file)

# ---- Clean dataset ----
cancer_screening_bowel <- read_excel(temp_file, sheet = "UA", range = "B3:F25") |>
  select("LA name" = `Unitary Authority Name`,
         "Screening uptake percentage" = `Uptake %`) |> #Only select ltla column and percentage screenings column
  mutate(Year = "2021-2022") #Financial year

# ---- Scrape ltla lookup file ----
# Specify the URL
#Source: https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/migrationwithintheuk/datasets/userinformationenglandandwaleslocalauthoritytoregionlookup
url <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/populationandmigration/migrationwithintheuk/datasets/userinformationenglandandwaleslocalauthoritytoregionlookup/june2020/lasregionew2021lookup.xlsx"

# Download the file to a temporary location
temp_file <- tempfile(fileext = ".xlsx")
download.file(url, temp_file, mode = "wb")

#Only include relevant columns
code_lookup <- read_excel(temp_file, range = "A5:D366")|>
  filter(str_starts(`LA code`, "W0")) |>
  select(`LA code`, `LA name`)

# ---- Join ltla lookup to screening dataset ----
#Filtered dataset includes percentage of people eligible for bowel cancer screening, aged 58-74, who attended their screening
hl_cancer_screening_bowel <- left_join(code_lookup, cancer_screening_bowel, by = "LA name") |>
  select("ltla21_code" = `LA code`,
         `Screening uptake percentage`,
         `Year`) |>
  arrange(ltla21_code)

# ---- Save output to data/ folder ----
usethis::use_data(hl_cancer_screening_bowel, overwrite = TRUE)
