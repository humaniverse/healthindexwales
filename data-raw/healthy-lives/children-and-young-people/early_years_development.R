# ---- Load packages ----
library(tidyverse)
library(statswalesr)

# ---- Scrape data from stats wales ----
#Source:https://statswales.gov.wales/Catalogue/Education-and-Skills/Schools-and-Teachers/Examinations-and-Assessments/Foundation-Phase 
df <- statswales_get_dataset("SCHS0153")

# ---- Clean data ----
#Dataset includes percentage of students at foundation phase, aged 3-7, who achieved the expected outcome level or above (level 5) across the four tested areas
#Tested areas were: 1) Personal and social development, well-being and cultural diversity, 2) Language, literacy and communication skills - English, 3) Language, literacy and communication skills - Welsh, 4) Mathematical development
hl_early_years_development <- df |>
  filter(str_starts(Description_Code, "L5") &
           str_starts(Subject_ItemName_ENG, "F") &
           str_starts(Gender_Code, "3") &
           str_starts(Year_Code, "2017") &
           str_starts(Area_AltCode1, "W06")) |>
  select(ltla21_code = Area_AltCode1,
         `Percent pupils achieving expected level across four foundation phase tested areas` = Data,
         Year = Year_Code) |>
  arrange(ltla21_code)


# ---- Save output to data/ folder ----
usethis::use_data(hl_early_years_development, overwrite = TRUE)
         