# ---- Load libraries and Functions ----
library(tidyverse)
source("R/utils.R")

# ---- Build Healthy Lives Domain ----
# Load indicators
data_folder <- "data"
exclude_files <- c("dftest.rda", "reception_measurement_table_with_ltla.rda", "hp_greenspace_access.rda", "hp_low_level_crimes.rda", "hp_personal_crime.rda", "hl_composite_score.rda") #Exclude files not from healthy lives
files_to_load <- data_folder[!basename(data_folder) %in% exclude_files]

healthy_lives_indicators <-
  load_indicators(
    path = "joined_data",
    key = "ltla21_code"
  )

# 1. Scale (align) indicators - Higher value = worse health.
healthy_lives_scaled <-
  healthy_lives_indicators |>
  mutate(
    happiness_score_out_of_10 = happiness_score_out_of_10 * -1,
    healthy_life_expectancy = healthy_life_expectancy * -1,
    life_satisfaction_score_out_of_10 = life_satisfaction_score_out_of_10 * -1,
    life_worthwhileness_score_out_of_10 = life_satisfaction_score_out_of_10 * -1
  )
