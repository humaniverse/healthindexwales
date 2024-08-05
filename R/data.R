#' @importFrom tibble tibble
NULL

#' DF - test documentation - to be deleted
#'
#' A dataset ..
#'
#' @format A data frame with .. rows and . variables:
#' \describe{
#'   \item{X1}{...}
#'   \item{X1.1}{..}
#'   ...
#' }
#' @source \url{https://www..../}
"dftest"

#' Alcohol Death Rates 2020-2022
#'
#' Dataset containing information about death rate from alcohol misuse in Wales
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Alcohol death rate per 100,000}{Age standardised alcohol-specific death rate per 100,000}
#'   \item{Year}{Time frame}
#'.  ...
#' }
#' @source \url{https://www.ons.gov.uk/peoplepopulationandcommunity/healthandsocialcare/causesofdeath/datasets/alcoholspecificdeathsintheukmaindataset}
"hl_alcohol_misuse"

#' Drug Poisoning Death Rates 2022
#'
#' Dataset containing information about drug poisoning death rates in Wales for the year 2022.
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code of the local authority}
#'   \item{Drug poisoning death rate}{Drug poisoning related deaths per 1,000 people}
#'   \item{Year}{Year of the data}
#' }
#' @source \url{https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/datasets/drugmisusedeathsbylocalauthority}
#' @source \url{https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationestimates/datasets/estimatesofthepopulationforenglandandwales}
"hl_drug_misuse"

#' Early Years Development Wales 2021-2023
#'
#' Dataset containing information about the percentage of students in Wales achieving expected level at foundation phase
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Percent pupils achieving expected level across four foundation level tested areas}{Percentage of foundation phase students, aged 7, who achieve the expected level, level 5, in all four areas of the foundation phase tests per local authority. The four areas are 1) Personal and social development, well-being and cultural diversity, 2) Language, literacy and communication skills - English, 3) Language, literacy and communication skills - Welsh, 4) Mathematical development}
#'   \item{Year}{Time frame}
#'.  ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/Education-and-Skills/Schools-and-Teachers/Examinations-and-Assessments/Foundation-Phase}
"hl_early_years_development"

#' Sedentary behaviour Wales 2021-2023
#'
#' Dataset containing information about the percentage of sedentary adults in Wales
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Percent adults active less than 30 minutes last week}{Percentage of people aged 16 and over in each local authority claiming to have exercised for less than 30 minutes the previous week, age standardised}
#'   \item{Year}{Time frame}
#'.  ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/National-Survey-for-Wales/Population-Health/Adult-Lifestyles}
"hl_sedentary_behaviour"

#' Greenspace Provision in Wales 2024
#'
#' Dataset containing information about greenspace provision in Wales
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{ltla21_name}{Area name}
#'   \item{provision_per_person}{The amount of public greenspace available per person, SQM}
#'.  ...
#' }
  #' @source \url{https://fieldsintrust.org/insights/green-space-index}
"hp_greenspace_access"

#' Low-Level Crime Scores for Wales
#'
#' A dataset containing low-level crime scores for local authorities in Wales.
#' The low-level crime score is calculated as the sum of bicycle theft and shoplifting.
#'
#' @description
#' Note: The combined authority for Cwm Taf has been split into its respective
#' local authorities, Merthyr Tydfil and Rhondda Cynon Taf. This adjustment was made
#' because the data for Cwm Taf was originally documented as a combined local authority.
#' The data values for rows 18 and 19, corresponding to these local authorities,
#' remain unchanged.
#'
#' @format A data frame with the following columns:
#' \describe{
#'   \item{local_authority_code}{Character. The code for the local authority.}
#'   \item{local_authority_name}{Character. The name of the local authority.}
#'   \item{low_level_crime_score}{Numeric. The personal crime score, as calculated according to Health Index England, is the sum of Bicycle Theft and Shoplifting.This score is measured per 1,000 persons, based on the ONS mid-year population estimates for the local authority region. A lower score is better as it indicates lower crime for the region.}
#'   \item{low_level_crime_per_1k}{Numeric. The rate of low-level crime (bicycle theft and shoplifting) per 1,000 population, based on the ONS mid-year population estimates for the local authority region. A lower rate is better as it indicates lower crime for the region.}
#'   \item{year}{Year. The year relevant to the data snapshot.}
#' }
#' @source \url{https://www.ons.gov.uk/} and \url{https://opendata.arcgis.com/}
"hp_low_level_crimes"

#' Personal Crime Scores for Wales
#'
#' A dataset containing personal crime scores for local authorities in Wales.
#' The personal crime score is calculated as the sum of violence against the person,
#' sexual offences, and robbery.
#'
#' @description
#' Note: The combined authority for Cwm Taf has been split into its respective
#' local authorities, Merthyr Tydfil and Rhondda Cynon Taf. This adjustment was made
#' because the data for Cwm Taf was originally documented as a combined local authority.
#' The data values for rows 18 and 19, corresponding to these local authorities,
#' remain unchanged.
#'
#' @format A data frame with the following columns:
#' \describe{
#'   \item{local_authority_code}{Character. The code for the local authority.}
#'   \item{local_authority_name}{Character. The name of the local authority.}
#'   \item{personal_crime_per_1k}{Numeric. The rate of personal crime (violence against the person, sexual offences, robbery, theft against the person, criminal damage and arson) per 1,000 population, based on the ONS mid-year population estimates for the local authority region. A lower rate is better as it indicates lower crime for the region.}
#'   \item{year}{Year. The year relevant to the data snapshot}
#' }
#' @source \url{https://www.ons.gov.uk/} and \url{https://opendata.arcgis.com/}
"hp_personal_crime"

#' Smoking Wales 2021-2023
#'
#' Dataset containing information about the percentage of smokers in Wales

#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Percent smokers}{Percentage of people aged 16 and over in each local authority who are self-reported smokers, age standardised}
#'   \item{Year}{Time frame}
#'.  ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/National-Survey-for-Wales/Population-Health/Adult-Lifestyles}
"hl_smoking"

#' Physical activity Wales 2021-2023
#'
#' Dataset containing information about the percentage of physically active adults in Wales
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Percent adults active at least 150 minutes last week}{Percentage of people aged 16 and over in each local authority claiming to have exercised for at least 150 minutes the previous week, age standardised}
#'   \item{Year}{Time frame}
#'.  ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/National-Survey-for-Wales/Population-Health/Adult-Lifestyles}
"hl_physical_activity"

#' Low Birth Weight Percentage by year Wales
#'
#' Dataset containing information about the percentage of live births under 2500g in Wales
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{percentage_low_birth_weight}{The percentage of singleton live births under 2500g in each local authority of Wales}
#'   \item{Year}{Time frame}
#'.  ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/National-Survey-for-Wales/Population-Health/Adult-Lifestyles}
"hl_low_birth_weight"

#' Percentage of Overweight and Obese Adults (aged 16+) in Wales
#'
#' Dataset containing information about the percentage of overweight and obese adults in Wales aged 16+
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{percentage_overweight_obese}{The percentage of overweight and obese adults in each local authority of Wales}
#'   \item{Year}{Time frame}
#'.  ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/National-Survey-for-Wales/Population-Health/Adult-Lifestyles}
"hl_adult_overweight_obese"

#' Percentage of Overweight and Obese Children (aged 4-5) in Wales
#'
#' Dataset containing information about the percentage of overweight and obese children in Wales aged 4-5 (reception age)
#' @format A data frame with 22 rows and 3 variables:
#' \describe
#' Note: The local authority name for Powys in the original dataset was written as Powys THB representing the Teaching Health Board.
#' The name was changed for consistency as Powys THB and Powys County Council cover the same areas.
#'   \item{ltla21_code}{Area code} 
#'   \item{percentage_overweight_obese}{The percentage of overweight and obese children aged 4-5 in each local authority of Wales}
#'   \item{Year}{Time frame}
#'.  ...
#' }
#' @source \url {https://phw.nhs.wales/services-and-teams/child-measurement-programme/cmp-2022-23/}
"hl_reception_overweight_obese"