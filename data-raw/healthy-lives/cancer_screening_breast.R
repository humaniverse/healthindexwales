# ---- Load packages ----
library(tidyverse)
library(readxl)
library(httr)

# ---- Scrape URL ----
# ---- Source: https://phw.nhs.wales/services-and-teams/screening/breast-screening/programme-reports/uptake-coverage-by-local-authority-and-health-boards/ ----
url <- "https://phw.nhs.wales/services-and-teams/screening/breast-screening/programme-reports/uptake-coverage-by-local-authority-and-health-boards/uptake-coverage-by-local-authority-and-health-boards-as-at-may-2021/"

# ---- Download and read URL as temp file ----
temp_file <- tempfile(fileext = ".xlsx")
download.file(url, temp_file, mode = "wb")
excel_data <- read_excel(temp_file)

# ---- Clean dataset ----
cancer_screening_breast <- read_excel(temp_file, sheet = "UA", range = "B3:F25") |>
  select("LA name" = `Unitary Authority Name`,
         "Screening uptake percentage" = `Uptake %`) |>
  mutate(Year = "2021") # May 2021 Breast Cancer screening

#Rename Anglesey so it works for join
cancer_screening_breast$`LA name`[cancer_screening_breast$`LA name` == "Anglesey"] <- "Isle of Anglesey"

# ---- Scrape ltla lookup file ----
# Because dataset only include ltla names, we want ltla codes
# Specify the URL
# Source: https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/migrationwithintheuk/datasets/userinformationenglandandwaleslocalauthoritytoregionlookup
url <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/populationandmigration/migrationwithintheuk/datasets/userinformationenglandandwaleslocalauthoritytoregionlookup/june2020/lasregionew2021lookup.xlsx"

# Download the file to a temporary location
temp_file <- tempfile(fileext = ".xlsx")
download.file(url, temp_file, mode = "wb")

#Only include relevant columns
code_lookup <- read_excel(temp_file, range = "A5:D366")|>
  filter(str_starts(`LA code`, "W0")) |> # Only include Welsh ltlas
  select(`LA code`, `LA name`)

# ---- Join ltla lookup to screening dataset ----
#Filtered dataset includes percentage of women eligible for breast cancer screening, aged 50-70, who attended their screening
hl_cancer_screening_breast <- left_join(code_lookup, cancer_screening_breast, by = "LA name") |>
  select("ltla21_code" = `LA code`,
         `Screening uptake percentage`,
         `Year`) |>
  arrange(ltla21_code) # Arrange in order of ltla code

# ---- Save output to data/ folder ----
usethis::use_data(hl_cancer_screening_breast, overwrite = TRUE)
