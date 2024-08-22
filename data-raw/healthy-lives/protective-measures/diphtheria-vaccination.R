# ---- Load packages ----
library(tidyverse)
library(statswalesr)

# ---- Scrape data from stats wales ----
# Source:https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/Immunisation 
df <- statswales_get_dataset("Hlth1011")

# ---- Clean data ----
hl_diphtheria_vaccination_coverage <- df |>
  filter(str_starts(Measure_ItemName_ENG, "Diphtheria") &
           str_starts(Year_Code, "18") & # Filter for most recent data
           str_starts(Area_AltCode1, "W0")) |> # Only include Welsh ltla codes
  select("ltla21_code" = `Area_AltCode1`,
         "Diphtheria percentage coverage by 2nd birthday" = `Data`,
         "Year" = `Year_ItemName_ENG`) |>
  arrange(ltla21_code)

# ---- Save output to data/ folder ----
usethis::use_data(hl_diphtheria_vaccination_coverage, overwrite = TRUE)
