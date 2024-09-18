# Installing relevant packages
library(tidyverse)
library(readxl)
library(httr)
library(dplyr)
library(geographr)

# Extracting relevant data sets from statswalesr
# library(statswalesr)
# statswales_search(c("rough sleeping"))
# statswales_search(c("homelessness"))

# 
# # Scrape data from stats Wales
# # Source:https://statswales.gov.wales/v/P2SD
# df <- statswales_get_dataset("HOUS0454")

# Upload csv files for rough sleepers and population data
#read.csv()
#df <- rough_sleepers_data
#head(population_df)
#df <- rough_sleepers_data

# Need to filter to only include Welsh data (mid-2023)
# population_df <- population_df |>
#   filter(location == "Wales")
# str(population_df)
# head(population_df)

population_df_wales <- population_df |>
  select(`...4`, `...5`, `...6`) |>
  slice(12:33)
population_df_wales <- population_df_wales[, -2]

# Now need to filter to only include data from June 2023 - June 2024
head(rough_sleepers_data)
rough_sleepers_data <- rough_sleepers_data |>
#select(`Housing > Homelessness > Homelessness accommodation provision and rough sleeping > Rough sleepers by local authority`, `...4`:`...16`) |>
  slice(4:25)

# Merge data sets to then calculate the % of people in each LA who are rough sleepers, and clean
# To make this easier, I need to rename the first column in each data frame to local_authority
names(rough_sleepers_data)[1] <- "local_authority"
names(population_df_wales)[1] <- "local_authority"

rough_sleepers_data <- rough_sleepers_data |>
  mutate(across(`...4`:`...16`, as.numeric))

rough_sleepers_data <- rough_sleepers_data |>
  rowwise() |>
  mutate(year_sum = sum(c_across(`...4`:`...16`), na.rm = TRUE)) |>
  ungroup() # sum for number of rough sleepers per LA June 2023 to June 2024
 
 population_df_wales <- population_df_wales |>
   mutate(across(`...6`, as.numeric))
 
 
 hp_rough_sleepers <- rough_sleepers_data |>
   left_join(population_df_wales, by = c("local_authority"))

 # Then remove monthly columns from June-2023 to June 2024, keeping the calculated mean (year_av)
 hp_rough_sleepers <- hp_rough_sleepers[, -2:-16]
 
 #Rename population column
 names(hp_rough_sleepers)[3] <- "pop_av"
 
 
 # Now to calculate the % of how many people in each Welsh LA are rough sleepers. A new column will then be created to show this data.
 hp_rough_sleepers <- hp_rough_sleepers |>
   mutate(percentage = (hp_rough_sleepers$year_sum / hp_rough_sleepers$pop_av) * 100)

 hp_rough_sleepers <- hp_rough_sleepers |>
   mutate(per_1000_pop = percentage * 1000)
 
 # Now to make the data tidy - rename columns and reformat into 'LA ID, data, date'
 names(hp_rough_sleepers)[5] <- "rough_sleepers_per_1000"
 
 hp_rough_sleepers <- hp_rough_sleepers |>
   mutate(year = "2023-2024")
 
 hp_rough_sleepers <- hp_rough_sleepers[, -2:-4]
 
names(hp_rough_sleepers)[1] <- "ltla22_name"

hp_rough_sleepers <- hp_rough_sleepers |>
  left_join(lookup_ltla22_ltla23, by = c("ltla22_name"))

# Now to remove extra columns and reorganise
hp_rough_sleepers <- hp_rough_sleepers[, -1]
hp_rough_sleepers <- hp_rough_sleepers[, -3]
hp_rough_sleepers <- hp_rough_sleepers[, -4]


hp_rough_sleepers <- hp_rough_sleepers |>
  select(ltla23_code, everything())
