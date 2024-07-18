# ---- Load packages ----
library(tidyverse)
library(statswalesr)

# ---- Scrape data from stats wales ----
#Source:https://statswales.gov.wales/Catalogue/National-Survey-for-Wales/Population-Health/Adult-Lifestyles
df <- statswales_get_dataset("hlth5072")

# ---- Clean data ----
#Filtered dataset includes percentage of adults (age 16+) who are self-reported smokers, age standardised
#For Year, data from 2021-22 & 2022-23 has been combined
hl_smoking <- df |>
  filter(str_starts(Variable_ItemName_ENG, "Smoker") &
           str_starts(Measure_ItemName_ENG, "Per") &
           str_starts(Year_SortOrder, "14") &
           str_starts(Standardisation_ItemName_ENG, "A") &
           str_starts(Area_Code, "W0")) |>
  select(ltla21_code = Area_Code,
         `Percentage smokers` = Data,
         Year = Year_ItemName_ENG)

# ---- Save output to data/ folder ----
usethis::use_data(hl_smoking, overwrite = TRUE)
