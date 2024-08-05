# ---- Load necessary libraries ----
library(tidyverse)
library(readxl)
library(devtools)

# ---- Define paths and URLs ----
# Source: https://phw.nhs.wales/services-and-teams/child-measurement-programme/cmp-2022-23/
# File path for Child Measurement Programme Data 2022-2023 (CMP)
local_cmp_file_path <- "C:/Users/ZaraMorgan/Downloads/2. CMP_Data_2022_2023.xlsx"

# URL for the LTLA lookup file
ltla_url <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/populationandmigration/migrationwithintheuk/datasets/userinformationenglandandwaleslocalauthoritytoregionlookup/june2020/lasregionew2021lookup.xlsx"

# ---- Create a temporary file path for LTLA lookup ----
temp_ltla_file <- tempfile(fileext = ".xlsx")

# ---- Download the LTLA lookup file ----
download.file(ltla_url, temp_ltla_file, mode = "wb")

# ---- Read and filter the LTLA lookup file ----
code_lookup <- read_excel(temp_ltla_file, range = "A5:D366") |>
  filter(str_starts(`LA code`, "W0")) |>
  select(`LA code`, `LA name`)

# ---- Define unwanted geographies ----
unwanted_geographies <- c(
  "Wales", "Least deprived fifth", "Next least deprived",
  "Middle deprived", "Next most deprived", "Most deprived fifth",
  "Betsi Cadwaladr UHB", "Swansea Bay UHB", "Cwm Taf Morgannwg UHB",
  "Cardiff and Vale UHB", "Hywel Dda UHB", "Aneurin Bevan UHB"
)

# ---- Reading and filtering the CMP Data Excel file ----
# Read the CMP Data Excel file
child_weight_data_2022_2023 <- read_excel(local_cmp_file_path, sheet = "3b", skip = 3) |>
  filter(!Geography %in% unwanted_geographies) |>
  mutate(Geography = recode(Geography, "Powys THB" = "Powys"))
  
  # ---- Merging child_weight_data_2022_2023 with code_lookup ----
hl_reception_overweight_obese <- child_weight_data_2022_2023 |>
  left_join(code_lookup, by = c("Geography" = "LA name")) |>
  mutate(Year = "2022-2023") |>
  select(
    ltla21code = `LA code`,
    percentage_overweight_obese = `91st centile and above (%)`,
    Year
  )
  # ---- Saving to data/ folder using usethis:: ----
  usethis::use_data(hl_reception_overweight_obese, overwrite = TRUE)
