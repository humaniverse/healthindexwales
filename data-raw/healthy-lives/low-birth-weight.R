# ---- Load packages ----
library(tidyverse)
library(geographr)


# ---- Get and clean data ----
# Wales LTLA and HB Codes
wales_hb_ltla <- lookup_ltla21_lhb22


# Low Birth Weight data
# Source: https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/Community-Child-Health/livebirthstowelshresidents-by-localhealthboard-birthweight

temp_zip <- tempfile(fileext = ".zip")
temp_dir <- tempdir()

download.file("https://statswales.gov.wales/Download/File?fileName=HLTH1113.zip", destfile = temp_zip, mode = "wb")

unzip(temp_zip, exdir = temp_dir)

unzipped_files <- list.files(temp_dir, full.names = TRUE)
print(unzipped_files)
