# Installing relevant packages
library(tidyverse)
library(readxl)
library(httr)

# Extracting relevant data sets from statswalesr
library(statswalesr)
rough_sleepers <- statswales_search(c("rough sleepers"))
glimpse(rough_sleepers)
homeless_datasets <- statswales_search(c("homeless"))
glimpse(homeless_datasets)

all_datasets <- statswales_get_dataset()
head(all_datasets)
all_datasets <- statswales_get_dataset_list()
head(all_datasets)
all_datasets <- statswales_catalogue()
head(all_datasets)
ls("package:statswalesr")
statswales_search(c("rough sleeping"))
statswales_search(c("homelessness"))


# Scrape data from stats Wales
# Source:https://statswales.gov.wales/v/P2SD
df <- statswales_get_dataset("HOUS0454")

# Scrape URL
# Source:https://statswales.gov.wales/v/P2SD
url <- "https://statswales.gov.wales/v/P2SD"

# Download and read URL as temp file
temp_file <- tempfile(fileext = ".xlsx")
download.file(url, temp_file, mode = "wb")
df <- read_excel(temp_file)
df <- read.csv(temp_file)

# Upload csv files for rough sleepers and population data
read.csv()
df <- rough_sleepers_data
head(population_df)
df <- rough_sleepers_data

# Need to filter to only include Welsh data (mid-2022 to mid-2023)
population_df <- population_df |>
  filter(location == "Wales")
str(population_df)
head(population_df)

population_df_wales <- population_df |>
  select(`...4`, `...5`, `...6`) |>
  slice(12:33)

# Now need to filter to only include data from June 2023 - June 2024
head(rough_sleepers_data)
rough_sleepers_data <- rough_sleepers_data |>
  select(`Housing > Homelessness > Homelessness accommodation provision and rough sleeping > Rough sleepers by local authority`, `...4`:`...16`) |>
  slice(4:25)

# Merge data sets to then calculate the % of people in each LA who are rough sleepers
