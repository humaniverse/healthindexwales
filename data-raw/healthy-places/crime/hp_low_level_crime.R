# Load necessary libraries
library(tidyverse)
library(readxl)
library(janitor)
library(devtools)
library(usethis)

# Define URLs for datasets
ukcrimetables_url <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/crimeandjustice/datasets/recordedcrimedatabycommunitysafetypartnershiparea/yearendingdecember2023/csptablesyedec23.xlsx"
lookup_lda_cps_url <- "https://opendata.arcgis.com/api/v3/datasets/a90c5fce795e4df7af9f40d41f479405_0/downloads/data?format=csv&spatialRefId=4326&where=1%3D1"

# Create temporary file paths
temp_ukcrime_xlsx <- tempfile(fileext = ".xlsx")
temp_lookup_csv <- tempfile(fileext = ".csv")

# Download the files
download.file(ukcrimetables_url, temp_ukcrime_xlsx, mode = "wb")
download.file(lookup_lda_cps_url, temp_lookup_csv, mode = "wb")

# Read the downloaded files
ukcrimetables <- read_excel(temp_ukcrime_xlsx, sheet = 8, skip = 7)
lookup_data <- read_csv(temp_lookup_csv)

# Merging UK crime tables with LTLA dataset
ukcrimetables_with_ltla <- ukcrimetables |>
  left_join(lookup_data, by = c("Community Safety Partnership code" = "CSP23CD"))
# Filter data for Wales
hp_wales_crime <- ukcrimetables_with_ltla |>
  filter(grepl("^W", LAD23CD))

# Defining numeric columns and converting to numeric, replacing NA values with 0
numeric_columns <- c(
  "Violence against the person",
  "Sexual offences",
  "Robbery",
  "Theft from the person",
  "Criminal damage and arson",
  "Bicycle theft",
  "Shoplifting",
  "Population figures (mid-2022) - rounded to 100"
)

hp_wales_crime[numeric_columns] <- lapply(
  hp_wales_crime[numeric_columns],
  function(x) as.numeric(x) |> replace_na(0)
)

# Clean column names using janitor and rename LTLA columns
hp_wales_crime <- hp_wales_crime |>
  clean_names() |>
  rename(
    ltla21_code = lad23cd,
    ltla21_name = lad23nm
  )

# Calculate low-level crime per 1k population
hp_low_level_crimes <- hp_wales_crime |>
  mutate(
    low_level_crime_per_1k = (bicycle_theft + shoplifting),
    date = as.Date("2023-11-23")
  ) |>
  # Adjust Local Authority names and codes for Cwm Taf ("Combined Local Authority") into Merthyr Tydfil and Rhondda Cynon Taf
  mutate(
    ltla21_code = if_else(
      ltla21_name == "Combined Local Authority",
      case_when(
        row_number() == 18 ~ "W06000016",
        row_number() == 19 ~ "W06000024",
        TRUE ~ as.character(ltla21_code)
      ),
      as.character(ltla21_code)
    ),
    ltla21_name = if_else(
      ltla21_name == "Combined Local Authority",
      case_when(
        row_number() == 18 ~ "Rhondda Cynon Taf",
        row_number() == 19 ~ "Merthyr Tydfil",
        TRUE ~ as.character(ltla21_name)
      ),
      as.character(ltla21_name)
    )
  ) |>
  # Selecting only relevant columns for final output
  select(
    ltla21_code,
    ltla21_name,
    low_level_crime_per_1k,
    date
  )

# Saving using USETHIS function
usethis::use_data(hp_low_level_crimes, overwrite = TRUE)

