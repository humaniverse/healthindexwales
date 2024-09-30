library(tidyverse)
library(geographr)
library(httr)
library(readxl)
library(readODS)

# ---- Scrape URL ----
# ---- Source: https://assets.publishing.service.gov.uk/media/641c5cdb5155a200136ad550/children-in-low-income-families-local-area-statistics-2014-to-2022.ods
url <- "https://assets.publishing.service.gov.uk/media/641c5cdb5155a200136ad550/children-in-low-income-families-local-area-statistics-2014-to-2022.ods"

# ---- Download and read URL as temp file ----
temp_ods <- tempfile(fileext = ".ods")
GET(url, write_disk(temp_ods, overwrite = TRUE))
child_poverty_raw <- read_ods(temp_ods, sheet = 8, skip = 9)

# ---- Clean data ----
hp_child_poverty <- child_poverty_raw |>
  filter(str_starts(`Area Code`, "W")) |>
  select(`Area Code`, `Percentage of children \nFYE 2022\n(%)\n[p] [note 3]`) |>
  rename(
    percentage_children_absolute_poverty = 2,
    ltla21_code = 1
  ) |>
  mutate(
    year = "2022",
    percentage_children_absolute_poverty = percentage_children_absolute_poverty
    * 100
  )

# ---- Save output to data/ folder ----
usethis::use_data(hp_child_poverty, overwrite = TRUE)
