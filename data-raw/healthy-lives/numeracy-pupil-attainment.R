# ---- Load packages ----
library(tidyverse)
library(statswalesr)

# ---- Scrape data from stats wales ----
# Source:https://statswales.gov.wales/Catalogue/Education-and-Skills/Schools-and-Teachers/Examinations-and-Assessments/Key-Stage-4
df <- statswales_get_dataset("SCHS0198")

# ---- Clean data ----
# Filtered dataset includes GCSES numeracy point score for each local authority for academic year 2022/2023
# Numeracy point score is calculated by taking the average of the scores for all 2022/2023 GCSE students, using their best score out of GCSE Mathematics or GCSE Mathematics – numeracy 
# Scores are allocated to each student based on GCSE grade: Grade A* = 58, Grade A = 52, Grade B = 46, Grade C = 40, Grade D = 34, Grade E = 28, Grade F = 22, Grade G = 16, Grade U/X = 0
# Or if using 1-9 grading system: Grade 9 score = 58, Grade 8 score = 55, Grade 7 score = 52, Grade 6 score = 48, Grade 5 score = 44, Grade 4 score = 40, Grade 3 score = 32, Grade 2 score = 24, Grade 1 score = 16, Grade U Score = 0
hl_pupil_attainment_numeracy <- df |>
  filter(str_starts(Year_Code, "2023") &
           str_starts(Measure_Code, "NumPoints") & # Filters column to only include numeracy score
           str_starts(Gender_Code, "P") & # Filters column to include all genders
           str_starts(Area_AltCode1, "W0") & # Filters column to only include local authority
           str_starts(FSM_Code, "10")) |> # Filters column to include all pupils, rather than only those elligible/inelligible for free school meals
  select(ltla21_code = Area_AltCode1,
         `Numeracy Point Score` = Data,
         Year = Year_ItemName_ENG) |>
  arrange(ltla21_code)

# ---- Save output to data/ folder ----
usethis::use_data(hl_pupil_attainment_numeracy, overwrite = TRUE)      
