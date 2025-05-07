# ---- Load packages ----
library(tidyverse)
library(readxl)
library(httr)
library(geographr)


# ---- Get and clean data ----
# Wales LTLA and HB Codes
wales_hb_ltla <- lookup_ltla21_lhb22

# Sexual Health data
# Source: https://phw.nhs.wales/publications/publications1/sexual-health-trends-in-wales-annual-report-2024/

sexual_health_raw <- read_excel("data-raw/healthy-lives/raw-data/sexual_health.xlsx")