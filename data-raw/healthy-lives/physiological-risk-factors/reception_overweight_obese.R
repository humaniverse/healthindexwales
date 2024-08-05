# ---- Load necessary libraries ----
library(tidyverse)
library(devtools)
library(readxl)

# ---- Scraping data from excel ----
# Source: https://phw.nhs.wales/services-and-teams/child-measurement-programme/cmp-2022-23/

# ---- Create a temporary file path ----
temp_file <- tempfile(fileext = ".xlsx")

# ---- Copying excel file to temporary file ----
# Copy the original file to the temporary file to avoid modifying the original and for accessibility
file.copy("C:/Users/ZaraMorgan/Downloads/2. CMP_Data_2022_2023.xlsx", temp_file, overwrite = TRUE)

# ---- Define unwanted geographies ----
unwanted_geographies <- c(
  "Wales", "Least deprived fifth", "Next least deprived",
  "Middle deprived", "Next most deprived", "Most deprived fifth",
  "Betsi Cadwaladr UHB", "Swansea Bay UHB", "Cwm Taf Morgannwg UHB",
  "Cardiff and Vale UHB", "Hywel Dda UHB", "Aneurin Bevan UHB"
)

# ---- Reading and filtering Excel file ----
X2_CMP_Data_2022_2023 <- read_excel(temp_file, sheet = "3b", skip = 3) |>
  filter(!Geography %in% unwanted_geographies) |>
  mutate(Geography = recode(Geography, "Powys THB" = "Powys")) 

# ---- Scrape LTLA lookup file ----
# Specify the URL
# Source: https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/migrationwithintheuk/datasets/userinformationenglandandwaleslocalauthoritytoregionlookup
url <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/populationandmigration/migrationwithintheuk/datasets/userinformationenglandandwaleslocalauthoritytoregionlookup/june2020/lasregionew2021lookup.xlsx"

# ---- Download the file to a temporary location ----
temp_file <- tempfile(fileext = ".xlsx")
download.file(url, temp_file, mode = "wb")

# ---- Only include relevant columns ----
code_lookup <- read_excel(temp_file, range = "A5:D366") |>
  filter(str_starts(`LA code`, "W0")) |>
  select(`LA code`, `LA name`)

# ---- Merging X2_CMP_Data_2022_2023 with code_lookup ----
hl_reception_overweight_obese <- X2_CMP_Data_2022_2023 |>
  left_join(code_lookup, by = c("Geography" = "LA name")) |>
  mutate(Year = "2022-2023") |>
  select(
    ltla21code = `LA code`,
    percentage_overweight_obese = `91st centile and above (%)`,
    Year
  )

# ---- Saving to data folder using usethis:: function ----
usethis::use_data(hl_reception_overweight_obese, overwrite = TRUE)
