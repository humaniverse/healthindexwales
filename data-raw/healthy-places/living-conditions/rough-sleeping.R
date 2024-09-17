# Installing relevant packages
library(tidyverse)
library(healthindexwales)
library(readxl)
library(httr)

# Extracting relevant data sets from statswalesr
install.packages("statswalesr")
devtools::install_github("jamie-ralph/statswalesr")
library(statswalesr)
rough_sleepers <- statswales_search(c("rough sleepers"))
glimpse(rough_sleepers)
homeless_datasets <- statswales_search(c("homeless"))
glimpse(homeless_datasets)

all_datasets <- statswales_get_dataset()
head(all_datasets)
all_datasets <- statswales_get_dataset_list()
head(all_datasets)
all_datasets <- statswales_catalogue()
head(all_datasets)
ls("package:statswalesr")
statswales_search(c("rough sleeping"))
statswales_search(c("homelessness"))


# Scrape data from stats Wales
# Source:https://statswales.gov.wales/Catalogue/Housing/Homelessness/homelessness-accommodation-provision-and-rough-sleeping/roughsleepers-by-localauthority
df <- statswales_get_dataset("HOUS0454")
