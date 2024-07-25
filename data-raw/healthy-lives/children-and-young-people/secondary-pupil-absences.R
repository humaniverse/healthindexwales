# ---- Load packages ----
library(tidyverse)
library(httr)
library(readODS)
library(dplyr)
library(statswalesr)

# ---- Scrape secondary schools URL ----
download.file("https://www.gov.wales/sites/default/files/statistics-and-research/2023-10/absenteeism-from-secondary-schools-september-2022-to-august-2023-revised-936.ods", 
              destfile = "absenteeism.ods")
secondary_data <- read_ods("absenteeism.ods", sheet = 10, range = "A4:J92") |>
  filter(str_ends(Indicator, "missed")) |>
  select(`Local authority`,
         `Secondary percentage of absences` = `2022/23 [r]`
  )
secondary_data$`Local authority`[secondary_data$`Local authority` == "Cardiff [r]"] <- "Cardiff"

# ---- Scrape ltla lookup file ----
# Specify the URL
url <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/populationandmigration/migrationwithintheuk/datasets/userinformationenglandandwaleslocalauthoritytoregionlookup/june2020/lasregionew2021lookup.xlsx"

# Download the file to a temporary location
temp_file <- tempfile(fileext = ".xlsx")
download.file(url, temp_file, mode = "wb")
code_lookup <- read_excel(temp_file, range = "A5:D366")|>
  filter(str_starts(`LA code`, "W0")) 

# ---- Join ltla lookup to absence dataset ----
absence_data <- left_join(secondary_data, code_lookup, by = c("Local authority" = "LA name"))
