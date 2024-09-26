# ---- Load packages ----
library(tidyverse)
library(httr)
library(readODS)
library(dplyr)
library(readxl)

# ---- Scrape primary schools URL ----
# Source: https://www.gov.wales/absenteeism-primary-schools-september-2022-august-2023
temp_file = tempfile(fileext = ".ods")
download.file("https://www.gov.wales/sites/default/files/statistics-and-research/2024-03/absenteeism-from-primary-schools-september-2022-to-august-2023-113.ods", 
              destfile = temp_file, mode = "wb")

# ---- Clean primary data ----
primary_data <- read_ods(temp_file, sheet = 10, range = "A4:J92") |>
  filter(str_ends(Measure, "missed")) |> 
  select(`Local authority`,
         `primary_school_absence_percentage` = `2022/23`
  )

#Rename Vale of Glamorgan so it works for join
primary_data$`Local authority`[primary_data$`Local authority` == "The Vale of Glamorgan"] <- "Vale of Glamorgan"

# ---- Scrape ltla lookup file ----
# Specify the URL
# Source: https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/migrationwithintheuk/datasets/userinformationenglandandwaleslocalauthoritytoregionlookup
url <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/populationandmigration/migrationwithintheuk/datasets/userinformationenglandandwaleslocalauthoritytoregionlookup/june2020/lasregionew2021lookup.xlsx"

# Download the file to a temporary location
temp_file <- tempfile(fileext = ".xlsx")
download.file(url, temp_file, mode = "wb")

#Only include relevant columns
code_lookup <- read_excel(temp_file, range = "A5:D366")|>
  filter(str_starts(`LA code`, "W0")) 

# ---- Join ltla lookup to absence dataset ----
joined_data <- left_join(primary_data, code_lookup, by = c("Local authority" = "LA name"))

# ---- Clean joined dataset ----
hl_primary_pupil_absences <- joined_data |>
  select(ltla21_code = `LA code`,
         `primary_school_absence_percentage`) |>
  mutate(year = "2022/23") |> 
  arrange(ltla21_code)

# ---- Save output to data/ folder ----
usethis::use_data(hl_primary_pupil_absences, overwrite = TRUE)         
