# Load necessary libraries
library(tidyverse)
library(readxl)
library(devtools)

# File paths
ukcrime_file <- 
  "C:/Users/ZaraMorgan/Downloads/ukcrimetables.xlsx"
ukcrime_rda <- 
  "C:/Users/ZaraMorgan/Downloads/ukcrimetables.rds"
lookup_file <- 
  "C:/Users/ZaraMorgan/OneDrive - British Red Cross Society/Local_Authority_District_to_CSPs_to_Police_Force_Areas_(December__2023)_Lookup_.xlsx"

# Load the UK crime table and save as RDA
ukcrimetables <- read_excel(ukcrime_file, sheet = 8, 
                            skip = 7)
save(ukcrimetables, file = ukcrime_rda)

# Load the RDA file back into R
load(ukcrime_rda)

# Lookup file
lookup_lda_cps <- read_excel(lookup_file)

# Left join ukcrimetables with lookup table
ukcrimetables_with_ltla <- ukcrimetables |>
  left_join(lookup_lda_cps, by = c("Community Safety Partnership code" = "CSP23CD"))

# Filter data for Wales
walescrimetables <- ukcrimetables_with_ltla |>
  filter(grepl("^W", LAD23CD))
# Selecting numeric columns
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

# Converting to numeric
walescrimetables[numeric_columns] <- lapply(
  walescrimetables[numeric_columns],
  function(x) {
    as.numeric(x) |> replace_na(0)
  }
)

# Temporarily rename columns for easier reference
walescrimetables <- walescrimetables |>
  rename(
    violence_person = `Violence against the person`,
    sexual_offences = `Sexual offences`,
    theft_person = `Theft from the person`,
    criminal_damage = `Criminal damage and arson`,
    bicycle_theft = `Bicycle theft`
  )

# Perform the mutation
walescrimetables <- walescrimetables |>
  mutate(
    personal_crimes = violence_person + sexual_offences + Robbery + theft_person + criminal_damage,
    low_level_crime = bicycle_theft + Shoplifting
  )
# Changing row names to represent CWM TAF specific LOAS
walescrimetables[18, "Local Authority code"] <- "W06000016"
walescrimetables[18, "Local Authority name"] <- "Rhondda Cynon Taf"

walescrimetables[19, "Local Authority code"] <- "W06000024"
walescrimetables[19, "Local Authority name"] <- "Merthyr Tydfil"

# Keep only the specified columns in the final dataframe
final_walescrimetables <- walescrimetables |>
  select(
    `Local Authority code` = `Local Authority code`,
    `Local Authority name` = `Local Authority name`,
    personal_crimes,
    low_level_crime
  )

# Save the final dataframe
save(final_walescrimetables, file = "final_walescrimetables.rda")