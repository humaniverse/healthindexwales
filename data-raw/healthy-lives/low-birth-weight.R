# ---- Load packages ----
library(tidyverse)
library(geographr)


# ---- Get and clean data ----
# Wales LTLA and HB Codes
wales_hb_ltla <- lookup_ltla21_lhb22


# Low Birth Weight data
# Source: https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/Community-Child-Health/livebirthstowelshresidents-by-localhealthboard-birthweight

low_birth_weight_raw <- read_csv("data-raw/healthy-lives/raw-data/low_birth_weight.csv", skip = 6)


low_birth_weight <- low_birth_weight_raw |>
  mutate(low_birth_weight_total = (`<2000g` + `2000-2499g`),
         low_birth_weight_percentage = (low_birth_weight_total / Total) * 100)


# next need to join datasets


names(low_birth_weight_raw)
