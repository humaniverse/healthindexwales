library(tidyverse)
library(readxl)
#loading the tables
ukcrimetables <- read_excel(
  "C:/Users/ZaraMorgan/Downloads/ukcrimetables.xlsx",
  sheet = 8)
#cleaning the table just for wales
welshcrimetables <- ukcrimetables %>%
  +     filter(str_detect(`local_authority_code`, "W0"))
#defining the crime category (split into two)
low_level_crime <- c("Bike Theft", "Shoplifting")
personal_crime <- c("Violence Against the Person", 
                    "Sexual Offences", "Robbery", "Theft", "Criminal Damage and Arson")
#creating a crime summary
