# Load packages
library(tidyverse)
library(geographr)
library(devtools)
# Load lookup dataset
lookup_ltla_ltla

# Filter the dataset for Welsh local authorities - LTLA code and LTLA name
# Data source: https://fieldsintrust.org/insights/green-space-index
hp_greenspace_access <- lookup_ltla_ltla |>
  filter(str_starts(ltla21_code, "W0")) |>
  select(ltla21_code, ltla21_name) |>
  mutate(
# provision_per_person:a metric indicating the amount of public greenspace in available per person in a given area. For every 1000 people there should be approx. 2.4 ha of accessible land, measured in SQM.
    provision_per_person = c(26.90, 72.81, 26.25, 100.19, 32.67, 47.17, 20.30, 45.06, 51.57, 35.32, 46.07, 18.68, 37.15, 23.61, 24.09, 46.45, 34.92, 24.84, 23.39, 20.24, 36.66, 23.40),
# outside_10min_walk: the population that are not within a 10 minute walk of a public greenspace.
    outside_10min_walk = c(22108, 30094, 13826, 16744, 15135, 14011, 31324, 34659, 50909, 25060, 25060, 17663, 7147, 8906, 13449, 15610, 3671, 5005, 22252, 24935, 49696, 3019),
# forecast_population_2024: forecasted number of people in an area in 2024.
    forecast_population_2024 = c(69931, 1258522, 119121, 95753, 157058, 134391, 70873, 126897, 189830, 248749, 143780, 148031, 136716, 370051, 242163, 18002, 68810, 94232, 96396, 160105, 133393, 60494),
# meets_min_greenspace_standards: does this area meet the minimum requirement for provision per person? a binary indicator where 0 is "no" and 1 is "yes".
    meets_min_greenspace_standards = c(0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0)
  )

# Save the df as an .rda in the data/ folder
usethis::use_data(hp_greenspace_access, overwrite = TRUE)


