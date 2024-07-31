library(tidyverse)
library(devtools)
library(readxl)

# ---- scraping data from excel ----
# source: https://phw.nhs.wales/services-and-teams/child-measurement-programme/cmp-2022-23/

# ---- create a temporary file path ----
temp_file <- tempfile(fileext = ".xlsx")

# ---- copying excel file to temporary file ----
file.copy("C:/Users/ZaraMorgan/Downloads/2. CMP_Data_2022_2023.xlsx", temp_file, overwrite = TRUE)

# ---- define the filter function ----
filter_geography <- function(data) {
  unwanted_geographies <- c(
    "Wales", "Least deprived fifth", "Next least deprived",
    "Middle deprived", "Next most deprived", "Most deprived fifth",
    "Betsi Cadwaladr UHB", "Swansea Bay UHB", "Cwm Taf Morgannwg UHB",
    "Cardiff and Vale UHB", "Hywel Dda UHB", "Aneurin Bevan UHB"
  )

  data |> filter(!sapply(unwanted_geographies, function(geo) str_starts(Geography, geo)) %>%
    rowSums() %>%
    as.logical())
}

# ---- reading excel file -----
X2_CMP_Data_2022_2023 <- read_excel(temp_file, sheet = "3b", skip = 3) |>
  filter_geography()

# ---- rename powys so works for join ----
X2_CMP_Data_2022_2023$Geography[X2_CMP_Data_2022_2023$Geography == "Powys THB"] <- "Powys" # Powys THB and Powys County Council cover the same regions

# ---- scrape ltla lookup file ----
# specify the URL
# source: https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/migrationwithintheuk/datasets/userinformationenglandandwaleslocalauthoritytoregionlookup
url <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/populationandmigration/migrationwithintheuk/datasets/userinformationenglandandwaleslocalauthoritytoregionlookup/june2020/lasregionew2021lookup.xlsx"

# ---- download the file to a temporary location ----
temp_file <- tempfile(fileext = ".xlsx")

download.file(url, temp_file, mode = "wb")

# ---- only include relevant columns ----
code_lookup <- read_excel(temp_file, range = "A5:D366") |>
  filter(str_starts(`LA code`, "W0")) |>
  select(`LA code`, `LA name`)

# ---- merging X2_CMP_Data_2022_2023 with code_lookup ----
hl_reception_overweight_obese <- X2_CMP_Data_2022_2023 |>
  left_join(code_lookup, by = c("Geography" = "LA name")) |>
  mutate(Year = "2022-2023") |>
  select(
    ltla21code = `LA code`,
    Percentage_overweight_obese = `91st centile and above (%)`,
    Year
  )

# ---- saving to data / folder using usethis:: function ----
usethis::use_data(hl_reception_overweight_obese, overwrite = TRUE)
