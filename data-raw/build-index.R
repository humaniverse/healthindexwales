# ---- Method ----
# The build method is adapated from the methods used to develop the Health Index
# for England. As the devolved nations versions of the Health Index are not
# measured across time, several aspects of the construction differ, and mirror
# those found in the Indices of Multiple Deprivation.

# Technical docs:
#   - https://www.ons.gov.uk/peoplepopulationandcommunity/healthandsocialcare/healthandwellbeing/methodologies/methodsusedtodevelopthehealthindexforengland2015to2018#overview-of-the-methods-used-to-create-the-health-index
#   - https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/833951/IoD2019_Technical_Report.pdf

# Steps:
#   1. Scale (align) indicators so that higher value = worse health to align
#      with the other resilience indices (higher = worse).
#   2. Missing step: Apply functional transformations (e.g. log, square) to
#      address skewness in the distributions.
#   3. Normalise to mean of 0 and SD +-1 and then apply MFLA.
#   4. Optional step: Weight the indicators within domains: apply MFLA.
#   5. Calculate domain scores: add together normalised indicator scores
#      (weighted or unweighted) and rank and qunatise.
#   6. Combine domains with equal weighting to produce composite score: rank
#      and quantise output.

# ---- Load libraries and Functions ----
library(tidyverse)
source("R/utils.R")

# ---- Build Healthy People Domain ----
# Load Healthy People indicators
healthy_people_indicators <- load_indicators(
  path_pattern = "data/hpe*",  # Files starting with 'hpe'
  key = "ltla21_code"
)

# Load Healthy Lives indicators
healthy_lives_indicators <- load_indicators(
  path_pattern = "data/hl*",  # Files starting with 'hl'
  key = "ltla21_code"
) %>%
  select(-starts_with("Year"))

# Keep only required columns and rename unclear columns
# Add Combined_vaccination column
healthy_lives_indicators <- healthy_lives_indicators |>
  mutate(`6 in 1 vaccination` = (
    `Diphtheria percentage coverage by 2nd birthday` + 
      `Tetanus percentage coverage by 2nd birthday` + 
      `Whooping cough percentage coverage by 2nd birthday` + 
      `Polio percentage coverage by 2nd birthday` + 
      `Hib percentage coverage by 2nd birthday`) / 5)

# Keep only required columns and rename unclear columns, making sure to position Combined_vaccination correctly
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
# Convert to numeric
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

# 3. Weight the indicators within the domain
healthy_people_weighted <-
  healthy_people_scaled |>
  normalise_indicators()

healthy_lives_weighted <- 
  healthy_lives_scaled |>
  normalise_indicators()

# 4. Create composite score
# For healthy lives
# Create the composite score so 100 is welsh average
# Define columns to standardize (excluding 'ltla21_code')
columns_to_transform <- names(healthy_lives_weighted)[!names(healthy_lives_weighted) %in% c("ltla21_code")]

# Apply transformation: multiply by 10 and add 100
healthy_lives_composite_score <- healthy_lives_weighted |>
  mutate(across(all_of(columns_to_transform), ~ . * 10 + 100))

# Add composite score column and subdomain columns
healthy_lives_composite_score <- healthy_lives_composite_score |>
  mutate(`Composite score` = rowSums(across(-ltla21_code)) / 23) |>
  mutate(`Behavioural risk score` = (`Alcohol misuse` + `Drug misuse` + `Healthy eating` + `Physical activity` + `Sedentary behaviour` + `Smoking`) / 6) |>
  mutate(`Children & young people score` = (`Early years development` + `Primary absences` + `Secondary absences` + `Literacy score` + `Numeracy score` + `Teenage pregnancy` + `Education employment apprenticeship`) / 7) |>
  mutate(`Physiological risk factors score` = (`Low birth weight` + `Reception overweight obese` + `Adult overweight obese`) / 3) |>
  mutate(`Protective measures score` = (`6 in 1 vaccination` + `MMR vaccination` + `Pneumococcal vaccination` + `MeningitisB vaccination` + `Bowel Cancer Screening` + `Breast Cancer Screening` + `Cervical Cancer Screening`) / 7)

# For healthy people
columns_to_transform <- names(healthy_people_weighted)[!names(healthy_people_weighted) %in% c("ltla21_code")]

# Apply transformation: multiply by 10 and add 100
healthy_people_composite_score <- healthy_people_weighted |>
  mutate(across(all_of(columns_to_transform), ~ . * 10 + 100))

# Add composite score column and subdomain columns
healthy_people_composite_score <- healthy_people_composite_score |>
  mutate(`Composite score` = rowSums(across(-ltla21_code)) / 18) |>
  mutate(`Difficulties in daily life score` = (`limited_adl_percentage` + `disability_daily_activities_percent` + `hip_fractures_per_100000`) / 3) |>
  mutate(`Mental health score` = (`suicides_per_100000`)) |>
  mutate(`Mortality score` = (`avoidable_deaths_per_100000` + `healthy_life_expectancy`) / 2) |>
  mutate(`Personal well-being score` = (`anxiety_score_out_of_10` + `happiness_score_out_of_10` + `life_satisfaction_score_out_of_10` + `worthwhileness_score_out_of_10`) / 4) |>
  mutate(`Physical health conditions` = (`asthma_emergency_admissions_per_100000` + `cancer_incidence_per_100000` + `copd_mortality_per_100000` + `heart_disease_deaths_per_100000` + `dementia_mortality_per_100000` + `heart_failure_admissions_per_100000` + `kidney_disease_mortality_per_100000` + `stroke_emergency_admissions_per_100000`) / 8)

# 5. Add ltla names column
# Add ltla names
# Scrape ltla lookup file
# Specify the URL
# Source: https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/migrationwithintheuk/datasets/userinformationenglandandwaleslocalauthoritytoregionlookup
url <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/populationandmigration/migrationwithintheuk/datasets/userinformationenglandandwaleslocalauthoritytoregionlookup/june2020/lasregionew2021lookup.xlsx"

# Download the file to a temporary location
temp_file <- tempfile(fileext = ".xlsx")
download.file(url, temp_file, mode = "wb")

# Only include relevant columns
code_lookup <- read_excel(temp_file, range = "A5:D366")|>
  filter(str_starts(`LA code`, "W0")) |>
  dplyr::select(`LA code`, `LA name`)

# Merge to healthy lives composite score dataset
healthy_lives_composite_score <- left_join(code_lookup, healthy_lives_composite_score, by = c("LA code" = "ltla21_code")) |>
  rename(
    ltla21_code = `LA code`,
    ltla21_name = `LA name`
  )

# Merge to healthy people composite score dataset
healthy_people_composite_score <- left_join(code_lookup, healthy_people_composite_score, by = c("LA code" = "ltla21_code")) |>
  rename(
    ltla21_code = `LA code`,
    ltla21_name = `LA name`
  )

# 6 . Save datasets to data folder
# ---- Save output to data/ folder ----
usethis::use_data(healthy_lives_composite_score, overwrite = TRUE)
usethis::use_data(healthy_people_composite_score, overwrite = TRUE)