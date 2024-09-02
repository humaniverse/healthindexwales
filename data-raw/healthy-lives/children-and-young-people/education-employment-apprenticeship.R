# ---- Load packages ----
library(tidyverse)
library(readxl)

# ---- Load dataset and filter ----
# Participation rate under 20 is participation rate for under 20 year olds in the 2009/10 student cohort in post-16 (after Key Stage 4) Education and Training 
# Participation rate is calculated using census data population count by local authority, with participation measured against the Welsh national average of 100. Participation rates above 100 reflect high participation rates, below 100 low participation rates
eea_data <- read_excel("data-raw/healthy-lives/children-and-young-people/over_16.xlsx") |>
  filter(!str_starts(...1, "Wales")) |> # Get rid of row for Wales
  select("LA name" = `...1`, # Select only required columns
         "Participation rate under 20" = `Post-16 learners aged under 20`)

# Rename Vale of Glamorgan so it works for join
eea_data$`LA name`[eea_data$`LA name` == "The Vale of Glamorgan"] <- "Vale of Glamorgan"

# ---- Scrape ltla lookup file ----
# Because the dataset only includes ltla names, we need ltla codes
# Specify the URL
# Source: https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/migrationwithintheuk/datasets/userinformationenglandandwaleslocalauthoritytoregionlookup
url <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/populationandmigration/migrationwithintheuk/datasets/userinformationenglandandwaleslocalauthoritytoregionlookup/june2020/lasregionew2021lookup.xlsx"

# Download the file to a temporary location
temp_file <- tempfile(fileext = ".xlsx")
download.file(url, temp_file, mode = "wb")

# Only include relevant columns
code_lookup <- read_excel(temp_file, range = "A5:D366")|>
  filter(str_starts(`LA code`, "W0")) |> # Filter to only include Welsh ltlas
  select(`LA code`, `LA name`)

# ---- Join ltla lookup to education employment apprenticeship dataset ----
hl_education_employment_apprenticeship <- left_join(code_lookup, eea_data, by = "LA name") |>
  select("ltla21_code" = `LA code`,
         `Participation rate under 20`) |>
  mutate(Year = "2009/2010") |> # Create year column
  arrange(ltla21_code) # Arrange in order of ltlas

# ---- Save output to data/ folder ----
usethis::use_data(hl_education_employment_apprenticeship, overwrite = TRUE)    
