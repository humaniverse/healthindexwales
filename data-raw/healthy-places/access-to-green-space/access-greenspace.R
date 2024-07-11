# Load packages
library(tidyverse)
library(geographr)
library(devtools)

# Get greenspace data
# Data source: https://fieldsintrust.org/insights/green-space-index
hp_greenspace_access <- lookup_ltla_ltla |>
  filter(str_starts(ltla21_code, "W0")) |>
  select(ltla21_code, ltla21_name) |>
  mutate(
    # provision_per_person:a metric indicating the amount of public greenspace available per person in a given area. For every 1000 people there should be approx. 2.4 ha of accessible land, measured in SQM.
    provision_per_person = c(26.90, 72.81, 26.25, 100.19, 32.67, 47.17, 20.30, 45.06, 51.57, 35.32, 46.07, 18.68, 37.15, 23.61, 24.09, 46.45, 34.92, 24.84, 23.39, 20.24, 36.66, 23.40),
  )

# Save the df as an .rda in the data/ folder
usethis::use_data(hp_greenspace_access, overwrite = TRUE)
