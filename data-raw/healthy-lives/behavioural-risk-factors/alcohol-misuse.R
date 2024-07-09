# Load packages
library(tidyverse)
library(readxl)
library(sf)
library(httr)
library(httr)
library(dplyr)

# URL of the Excel file
excel_url <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/datasets/alcoholspecificdeathsinenglandandwalesbylocalauthority/current/alcoholspecificdeathsbylocalauthority2022.xlsx"

# Download the file to a temporary location
temp_file <- tempfile(fileext = ".xlsx")
download.file(excel_url, temp_file, mode = "wb")

# Read the Excel file into R
excel_data <- readxl::read_excel(temp_file)

# Print a summary or inspect the data
print(head(excel_data))

# Download the file to a temporary location
temp_file <- tempfile(fileext = ".xlsx")
download.file(excel_url, temp_file, mode = "wb")

# Read the Excel file into R
excel_data <- readxl::read_excel(temp_file)

# Print a summary or inspect the data
print(head(excel_data))
  
# Reduce dataset to only include wales deaths per 100,000 in period 2020-2022
column_headings <- readxl::read_excel(temp_file, sheet = "Table_2", range = "A7:G366") |>
filter(str_starts(`Area Code \r\n[note 2]`, "W0"))

# Create object for only column headings
headers <- colnames(column_headings)
headers

# Delete empty columns
data <- column_headings |>
  select(all_of(headers)) |>
  select(where(~all(!is.na(.))))

# Check class of each column
sapply(data, class)

# Change death rate from character to numeric, delete unneeded columns, rename columns, add year column
clean_data <- data |> 
  mutate_at(4, as.numeric) |>
  select(-"2020 to 2022 \r\nNumber of deaths") |>
  select(-`Local Authority District \r\n[note 2]`) |>
  rename(
  "Area code" = `Area Code \r\n[note 2]`, #Rename ltla21_code
  "Death rate from alcohol misuse per 100,000" = `2020 to 2022 \r\nRate per 100,000 \r\n[note 4]`) |>
  mutate("Year" = c("2020-2022"))
  
# Check classes and column names
sapply(clean_data, class)
colnames(clean_data)

#Save to data folder
file_path <- "~/Documents/BRC/health-index-wales/data"
write.xlsx(clean_data, file_path)
file.rename(from = "file14a402a2243d9.xlsx", to = "healthylives-alcohol-misuse.xlsx")









    
    


  

  

  

  

 