# ---- Load packages ----
library(tidyverse)
library(geographr)
library(httr)
library(readxl)


# ---- Get and clean data ----
# Wales LTLA and HB Codes
wales_hb_ltla <- lookup_ltla21_lhb22


# Alcohol Misuse data
# Source: https://phw.nhs.wales/publications/publications1/data-mining-wales-the-annual-profile-for-substance-misuse-2023-2024/

alcohol_misuse_raw <- read_excel("data-raw/healthy-lives/raw-data/alcohol_misuse.xlsx")