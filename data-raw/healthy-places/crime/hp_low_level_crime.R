# Load necessary libraries
library(tidyverse)
library(readxl)
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

# Rename columns into snake_case for clarity
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
    homicide = `Homicide`,
    illegal_driving_death_or_serious_injury = `Death or serious injury caused by illegal driving`,
    violence_with_injury = `Violence with injury`,
    violence_without_injury = `Violence without injury`,
    stalking_and_harassment = `Stalking and harassment`,
    sexual_offences = `Sexual offences`,
    robbery = `Robbery`,
    theft_offences = `Theft offences`,
    burglary = `Burglary`,
    residential_burglary_per_1000_population = `Residential burglary (per 1,000 population)`,
    residential_burglary_per_1000_household = `Residential burglary (per 1,000 household)`,
    non_residential_burglary = `Non-residential burglary`,
    vehicle_offences = `Vehicle offences`,
    theft_person = `Theft from the person`,
    bicycle_theft = `Bicycle theft`,
    shoplifting = `Shoplifting`,
    all_other_theft_offences = `All other theft offences`,
    criminal_damage_and_arson = `Criminal damage and arson`,
    drug_offences = `Drug offences`,
    possession_of_weapons_offences = `Possession of weapons offences`,
    public_order_offences = `Public order offences`,
    miscellaneous_crimes_against_society = `Miscellaneous crimes against society`,
    lad23cd = `LAD23CD`,
    lad23nm = `LAD23NM`,
    csp23nm = `CSP23NM`,
    pfa23cd = `PFA23CD`,
    pfa23nm = `PFA23NM`,
    object_id = `ObjectId`
  )

# Calculate low-level crime score 
#Low Level Crime according to HIE is the sum of Bicycle Theft and Shoplifting.
##The score value is per 1000 persons (of the total population measured using the ONS mid year population estimates) and the lower the value the better.
hp_low_level_crimes <- hp_wales_crime |>
  mutate(
    low_level_crime_score = bicycle_theft + shoplifting
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
  # Selecting only relevant columns for final output
  select(
    local_authority_code,
    local_authority_name,
    low_level_crime_score
  )

#Saving using USETHIS function
usethis::use_data(hp_low_level_crimes, overwrite = TRUE)

