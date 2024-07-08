# Load packages
library(tidyverse)
library(geographr)

# Load lookup dataset
lookup_ltla_raw <- lookup_ltla_ltla

# Filter the dataset for Welsh local authorities - LTLA code and LTLA name
raw_welsh_greenspace <- data.frame ()
raw_welsh_greenspace <- lookup_ltla_raw |>
  filter(startsWith(ltla21_code, "W0"))|>
  select(ltla21_code, ltla21_name)
print (raw_welsh_greenspace)

# Add new columns for the green space data
raw_welsh_greenspace$PPP <- NA
raw_welsh_greenspace$N10 <- NA
raw_welsh_greenspace$NUTS1 <- NA
raw_welsh_greenspace$POP <- NA
raw_welsh_greenspace$MIN <- NA

raw_welsh_greenspace$PPP <- c(26.90, 72.81, 26.25, 100.19, 32.67, 47.17, 20.30, 45.06, 51.57, 35.32, 46.07, 18.68, 37.15, 23.61, 24.09, 46.45, 34.92, 24.84, 23.39, 20.24, 36.66, 23.40)
raw_welsh_greenspace$N10 <- c(22108, 30094, 13826, 16744, 15135,14011, 31324, 34659, 50909, 25060, 25060, 17663, 7147, 8906, 13449, 15610, 3671, 5005, 22252, 24935, 49696, 3019)
raw_welsh_greenspace$NUTS1 <- ("WALES")
raw_welsh_greenspace$POP <- c(69931, 1258522, 119121, 95753, 157058, 134391, 70873, 126897, 189830, 248749, 143780, 148031, 136716, 370051, 242163, 18002, 68810, 94232, 96396, 160105, 133393, 60494)
raw_welsh_greenspace$MIN <- c(0,1,0,1,0,1,0,1,1,1,1,0,1,0,0,1,1,0,0,0,1,0)
# Save the df as an .rda in the data/ folder
> save(raw_welsh_greenspace, file = "raw_welsh_greenspace.rda")
file.copy(from = "raw_welsh_greenspace.rda", 
          to = "data-raw/healthy-places/access-to-green-space/raw_welsh_greenspace.rda")
