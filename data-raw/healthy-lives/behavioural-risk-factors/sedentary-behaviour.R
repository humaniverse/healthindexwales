# ---- Load packages ----
library(tidyverse)
library(statswalesr)

# ---- Scrape data from stats wales and save as tempfile ----
# ---- Source:https://statswales.gov.wales/Catalogue/National-Survey-for-Wales/Population-Health/Adult-Lifestyles ----
df <- statswales_get_dataset("hlth5072")

# ---- Clean data ----
# ---- Filtered dataset includes percentage of adults (age 16+) who claim to have had <30 minutes of physical activity the previous week, age standardised ----
# ---- For Year, data from 2021-22 & 2022-23 has been combined
hl_sedentary_behaviour <- df |>
  filter(str_starts(Variable_ItemName_ENG, "Active less") &
           str_starts(Measure_ItemName_ENG, "Per") &
           str_starts(Year_SortOrder, "14") &
           str_starts(Standardisation_ItemName_ENG, "A") &
           str_starts(Area_Code, "W0")) |>
  select(ltla21_code = Area_Code,
         `Percent adults active less than 30 minutes last week` = Data,
         Year = Year_ItemName_ENG)

# ---- Save output to data/ folder ----
usethis::use_data(hl_sedentary_behaviour, overwrite = TRUE)
