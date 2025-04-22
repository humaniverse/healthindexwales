# ---- Load packages ----
library(tidyverse)
library(httr)
library(readxl)


# ---- Get and clean data ----
tf <- tempfile(fileext = ".xlsx")
download.file("https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/datasets/infantmortalitybirthcohorttablesinenglandandwales/2022/2022birthcohortworkbook.xlsx", tf, mode = "wb")

infant_mortality_raw <- read_excel(tf, sheet = 6, skip = 9)

infant_mortality <- infant_mortality_raw |>
  filter(str_starts(`Area of usual residence (code)`, "W"), 
         `Area of usual residence (code)` != "W92000004")

