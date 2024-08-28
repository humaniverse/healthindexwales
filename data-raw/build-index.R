# ---- Method ----
# The build method is adapated from the methods used to develop the Health Index
# for England. As the devolved nations versions of the Health Index are not
# measured across time, several aspects of the construction differ, and mirror
# those found in the Indices of Multiple Deprivation.

# Technical docs:
#   - https://www.ons.gov.uk/peoplepopulationandcommunity/healthandsocialcare/healthandwellbeing/methodologies/methodsusedtodevelopthehealthindexforengland2015to2018#overview-of-the-methods-used-to-create-the-health-index
#   - https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/833951/IoD2019_Technical_Report.pdf

# Steps:
#   1. Scale (align) indicators so that higher value = better health (to align 
#      with HIE) by muliplying indicators where worse is higher by -1
#   2. Normalise to mean of 0 and SD +-1 (z scores) .
#   3. Create indicator composite scores: multiply z scores by 10 then add 100.
#.     Create domain and subdomain composite scores: take average of all 
#.     indicators composite scores for domain composite score and average of all

# ---- Load libraries and Functions ----
library(tidyverse)
library(geographr)
source("R/utils.R")

# ---- Build Healthy People Domain ----
# Load Healthy People indicators
healthy_people_indicators <- load_indicators(
  path_pattern = "data/hpe*",  # Only include files starting with 'hpe' (healthy people)
  key = "ltla21_code"
)

# ---- Build Healthy Lives Domain ----
# Load Healthy Lives indicators
healthy_lives_indicators <- load_indicators(
  path_pattern = "data/hl*",  # Only include files starting with 'hl' (healthy lives)
  key = "ltla21_code"
) |>
  select(-starts_with("Year")) # Exclude year columns

# Add 6 in 1 vaccination column
healthy_lives_indicators <- healthy_lives_indicators |>
  mutate(`6 in 1 vaccination` = (
    `Diphtheria percentage coverage by 2nd birthday` + 
      `Tetanus percentage coverage by 2nd birthday` + 
      `Whooping cough percentage coverage by 2nd birthday` + 
      `Polio percentage coverage by 2nd birthday` + 
      `Hib percentage coverage by 2nd birthday`) / 5)

# Keep only required columns and rename unclear columns
healthy_lives_indicators <- healthy_lives_indicators |>
  dplyr::select(
    -`Diphtheria percentage coverage by 2nd birthday`,
    -`Tetanus percentage coverage by 2nd birthday`,
    -`Whooping cough percentage coverage by 2nd birthday`,
    -`Polio percentage coverage by 2nd birthday`,
    -`Hib percentage coverage by 2nd birthday`,
    -starts_with("ltla21_name"),
    -starts_with("Year"),
    "6 in 1 vaccination",
    "Alcohol misuse" = `Alcohol death rate per 100,000`,
    "Bowel Cancer Screening" = `Screening uptake percentage.x`,
    "Breast Cancer Screening" = `Screening uptake percentage.y`,
    "Cervical Cancer Screening" = `Screening uptake percentage`,
    "Drug misuse" = `Drug poisoning death rate`,
    "Early years development" = `Percent pupils achieving expected level across four foundation phase tested areas`,
    "Education employment apprenticeship" = `Participation rate under 20`,
    "Healthy eating" = `Percent adults who ate five fruit/veg yesterday`,
    "Literacy score" = `Literacy Point Score`,
    "MeningitisB vaccination" = `Meningitis B percentage coverage by 2nd birthday`,
    "MMR vaccination" = `MMR percentage coverage by 2nd birthday`,
    "Numeracy score" = `Numeracy Point Score`,
    "Physical activity" = `Percent adults active at least 150 minutes last week`,
    "Pneumococcal vaccination" = `Pneumococcal percentage coverage by 2nd birthday`,
    "Primary absences" = `Primary percentage of absences`,
    "Secondary absences" = `Secondary percentage of absences`,
    "Sedentary behaviour" = `Percent adults active less than 30 minutes last week`,
    "Smoking" = `Percentage smokers`,
    "Teenage pregnancy" = `Percentage teenage pregnancies`
  )

# 1. Scale (align) indicators - Higher value = worse health.
# Convert healthy people columns to numeric
healthy_people_indicators <- healthy_people_indicators |>
  mutate(across(-ltla21_code, ~ as.numeric(as.character(.))))

# Scale healthy people indicators
healthy_people_scaled <-
  healthy_people_indicators |>
  mutate(
    limited_adl_percentage = limited_adl_percentage * -1,
    anxiety_score_out_of_10 = anxiety_score_out_of_10 * -1,
    asthma_emergency_admissions_per_100000 = asthma_emergency_admissions_per_100000 * -1,
    avoidable_deaths_per_100000 = avoidable_deaths_per_100000 * -1,
    cancer_incidence_per_100000 = cancer_incidence_per_100000 * -1,
    copd_mortality_per_100000 = copd_mortality_per_100000 * -1,
    heart_disease_deaths_per_100000 = heart_disease_deaths_per_100000 * -1,
    dementia_mortality_per_100000 = dementia_mortality_per_100000 * -1,
    disability_daily_activities_percent = disability_daily_activities_percent * -1,
    hip_fractures_per_100000 = hip_fractures_per_100000 * -1,
    heart_failure_admissions_per_100000 = heart_failure_admissions_per_100000 * -1,
    kidney_disease_mortality_per_100000 = kidney_disease_mortality_per_100000 * -1,
    stroke_emergency_admissions_per_100000 = stroke_emergency_admissions_per_100000 * -1,
    suicides_per_100000 = suicides_per_100000 * -1
  )

# Scale healthy lives indicators
healthy_lives_scaled <-
  healthy_lives_indicators |>
  mutate(
    `Alcohol misuse` = `Alcohol misuse` * -1,
    `Drug misuse` = `Drug misuse` * -1,
    `Sedentary behaviour` = `Sedentary behaviour` * -1,
    `Smoking` = `Smoking` * -1,
    `Primary absences` = `Primary absences` * -1,
    `Secondary absences` = `Secondary absences` * -1,
    `Teenage pregnancy` = `Teenage pregnancy` * -1,
    `Low birth weight` = `Low birth weight` * -1,
    `Adult overweight obese` = `Adult overweight obese` * -1,
    `Reception overweight obese` = `Reception overweight obese` * -1
  )

# 2. Standardise indicators
healthy_people_weighted <-
  healthy_people_scaled |>
  normalise_indicators()

healthy_lives_weighted <- 
  healthy_lives_scaled |>
  normalise_indicators()

# 3. Create composite score
# For healthy lives
# Create the composite score so 100 is welsh average
healthy_lives_subdomains <- list(
  `Behavioural risk` = c("Alcohol misuse", "Drug misuse", "Healthy eating", "Physical activity", "Sedentary behaviour", "Smoking"),
  `Children & young people` = c("Early years development", "Primary absences", "Secondary absences", "Literacy score", "Numeracy score", "Teenage pregnancy", "Education employment apprenticeship"),
  `Physiological risk factors` = c("Low birth weight", "Reception overweight obese", "Adult overweight obese"),
  `Protective measures` = c("6 in 1 vaccination", "MMR vaccination", "Pneumococcal vaccination", "MeningitisB vaccination", "Bowel Cancer Screening", "Breast Cancer Screening", "Cervical Cancer Screening")
)

healthy_lives_composite_score <- create_composite_scores(
  healthy_lives_weighted,
  columns_to_exclude = "ltla21_code",
  num_columns_composite = 23,
  subdomain_indicators = healthy_lives_subdomains
)

#For healthy people
healthy_people_subdomains <- list(
  `Difficulties in daily life` = c("limited_adl_percentage", "disability_daily_activities_percent", "hip_fractures_per_100000"),
  `Mental health` = c("suicides_per_100000"),
  `Mortality` = c("avoidable_deaths_per_100000", "healthy_life_expectancy"),
  `Personal well-being` = c("anxiety_score_out_of_10", "happiness_score_out_of_10", "life_satisfaction_score_out_of_10", "worthwhileness_score_out_of_10"),
  `Physical health conditions` = c("asthma_emergency_admissions_per_100000", "cancer_incidence_per_100000", "copd_mortality_per_100000", "heart_disease_deaths_per_100000", "dementia_mortality_per_100000", "heart_failure_admissions_per_100000", "kidney_disease_mortality_per_100000", "stroke_emergency_admissions_per_100000")
)

healthy_people_composite_score <- create_composite_scores(
  healthy_people_weighted,
  columns_to_exclude = "ltla21_code",
  num_columns_composite = 18,
  subdomain_indicators = healthy_people_subdomains
)

# Add ltla names column
# Load Welsh ltla codes and names from geographr 
wales_lookup <-
  boundaries_ltla21 |>
  as_tibble() |>
  select(starts_with("ltla21")) |>
  filter_codes(ltla21_code, "^W")

# Join to healthy people
healthy_people_composite_score <- left_join(wales_lookup, healthy_people_composite_score, by = "ltla21_code")

# Join to healthy lives
healthy_lives_composite_score <- left_join(wales_lookup, healthy_lives_composite_score, by = "ltla21_code")

# Save datasets to data folder
# ---- Save output to data/ folder ----
usethis::use_data(healthy_lives_composite_score, overwrite = TRUE)
usethis::use_data(healthy_people_composite_score, overwrite = TRUE)