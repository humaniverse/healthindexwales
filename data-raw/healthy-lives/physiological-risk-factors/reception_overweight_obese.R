# ---- Load necessary libraries ----
library(tidyverse)
library(readxl)
library(devtools)

# ---- Load the LTLA code to name lookup file ----
# URL for the LTLA lookup file
ltla_url <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/populationandmigration/migrationwithintheuk/datasets/userinformationenglandandwaleslocalauthoritytoregionlookup/june2020/lasregionew2021lookup.xlsx"

temp_ltla_file <- tempfile(fileext = ".xlsx")

download.file(ltla_url, temp_ltla_file, mode = "wb")

# ---- Read and filter the LTLA lookup file ----
code_lookup <- read_excel(temp_ltla_file, range = "A5:D366") |>
  filter(str_starts(`LA code`, "W0")) |>
  select(`LA code`, `LA name`)

# ---- Reading and filtering the CMP Data Excel file ----
# Source: https://phw.nhs.wales/services-and-teams/child-measurement-programme/cmp-2022-23/

cmp_url <- "https://phw.nhs.wales/services-and-teams/child-measurement-programme/cmp-2022-23/2-cmp-data-2022-2023/"

temp_cmp <- tempfile(fileext = ".xlsx")

download.file(cmp_url, temp_cmp, mode = "wb")

# Remove unwanted geographies in the datatable
unwanted_geographies <- c(
  "Wales", "Least deprived fifth", "Next least deprived",
  "Middle deprived", "Next most deprived", "Most deprived fifth",
  "Betsi Cadwaladr UHB", "Swansea Bay UHB", "Cwm Taf Morgannwg UHB",
  "Cardiff and Vale UHB", "Hywel Dda UHB", "Aneurin Bevan UHB"
)

child_weight_data_2022_2023 <- read_excel(temp_cmp, sheet = "3b", skip = 3) |>
  filter(!Geography %in% unwanted_geographies) |>
  mutate(Geography = recode(Geography, "Powys THB" = "Powys"))

# ---- Merging child_weight_data_2022_2023 with code_lookup ----
hl_reception_overweight_obese <- child_weight_data_2022_2023 |>
  left_join(code_lookup, by = c("Geography" = "LA name")) |>
  mutate(Year = "2022-2023") |>
  select(
    ltla21_code = `LA code`,
    `Reception overweight obese` = `91st centile and above (%)`,
    Year
  )
# ---- Saving to data/ folder using usethis:: ----
usethis::use_data(hl_reception_overweight_obese, overwrite = TRUE)