# Load necessary libraries
library(tidyverse)
library(readxl)
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

# Merge UK crime tables with LTLA dataset
ukcrimetables_with_ltla <- ukcrimetables |>
  left_join(lookup_data, by = c("Community Safety Partnership code" = "CSP23CD"))

# Filter data for Wales
hp_wales_crime <- ukcrimetables_with_ltla |>
  filter(grepl("^W", LAD23CD))

# Define numeric columns and convert to numeric, replacing NA values with 0
numeric_columns <- c(
  "Violence against the person",
  "Sexual offences",
  "Robbery",
  "Theft from the person",
  "Criminal damage and arson",
  "Population figures (mid-2022) - rounded to 100"
)

hp_wales_crime[numeric_columns] <- lapply(
  hp_wales_crime[numeric_columns],
  function(x) as.numeric(x) |> replace_na(0)
)

# Rename columns for clarity
hp_wales_crime <- hp_wales_crime |>
  rename(
    police_force_area_code = `Police Force Area code`,
    police_force_area_name = `Police Force Area name`,
    community_safety_partnership_code = `Community Safety Partnership code`,
    community_safety_partnership_name = `Community Safety Partnership name`,
    local_authority_code = `Local Authority code`,
    local_authority_name = `Local Authority name`,
    population_2022 = `Population figures (mid-2022) - rounded to 100`,
    total_recorded_crime = `Total recorded crime\r\n (excluding fraud)`,
    violence_person = `Violence against the person`,
    sexual_offences = `Sexual offences`,
    robbery = `Robbery`,
    theft_person = `Theft from the person`,
    criminal_damage_and_arson = `Criminal damage and arson`,
    lad23cd = `LAD23CD`,
    lad23nm = `LAD23NM`,
    csp23nm = `CSP23NM`,
    pfa23cd = `PFA23CD`,
    pfa23nm = `PFA23NM`,
    object_id = `ObjectId`
  )

# Calculate personal crime score 
# Personal crime score according to the HIE is the sum of Violence against the person, Sexual offences, and Robbery.
#The score value is per 1000 persons (of the total population measured using the ONS mid year population estimates) and the lower the value the better.
hp_personal_crimes <- hp_wales_crime |>
  mutate(
    personal_crime_score = violence_person + sexual_offences + robbery
  ) |>
  # Adjust Local Authority names and codes for Cwm Taf ("Combined Local Authority") into Merthyr Tydfil and Rhondda Cynon Taf
  mutate(
    local_authority_code = if_else(
      local_authority_name == "Combined Local Authority",
      case_when(
        row_number() == 18 ~ "W06000016",
        row_number() == 19 ~ "W06000024",
        TRUE ~ as.character(local_authority_code)
      ),
      as.character(local_authority_code)
    ),
    local_authority_name = if_else(
      local_authority_name == "Combined Local Authority",
      case_when(
        row_number() == 18 ~ "Rhondda Cynon Taf",
        row_number() == 19 ~ "Merthyr Tydfil",
        TRUE ~ as.character(local_authority_name)
      ),
      as.character(local_authority_name)
    )
  ) |>
  # Select only relevant columns for final dataframe
  select(
    local_authority_code,
    local_authority_name,
    personal_crime_score
  )

# Save the data using USETHIS function
usethis::use_data(hp_personal_crimes, overwrite = TRUE)
