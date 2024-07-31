# ---- Load packages ----
library(tidyverse)
library(statswalesr)

# ---- Scrape data from stats wales ----
#Source:https://statswales.gov.wales/Catalogue/Education-and-Skills/Post-16-Education-and-Training/Further-Education-and-Work-Based-Learning/Standardised-Participation-Rates/StandardParticipationRates-by-LocalAuthority-LearnerCohort
df <- statswales_get_dataset("Educ0143_participation")
