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

#' Diphtheria vaccination coverage Wales 2021-2023
#'
#' Dataset containing information about the percentage of children in Wales immunized against diphtheria by their second birthday
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Diphtheria percentage coverage by 2nd birthday}{Percentage of children immunised against diphtheria reaching their second birthday in the year}
#'   \item{Year}{Time frame}
#'.  ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/Immunisation}
"hl_diphtheria_vaccination_coverage"

#' Hib vaccination coverage Wales 2021-2023
#'
#' Dataset containing information about the percentage of children in Wales immunized against haemophilus influenzae type B by their second birthday
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Hib percentage coverage by 2nd birthday}{Percentage of children immunised against haemophilus influenzae type B reaching their second birthday in the year}
#'   \item{Year}{Time frame}
#'.  ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/Immunisation}
"hl_hib_vaccination_coverage"

#' Tetanus vaccination coverage Wales 2021-2023
#'
#' Dataset containing information about the percentage of children in Wales immunized against tetanus by their second birthday
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Tetanus percentage coverage by 2nd birthday}{Percentage of children immunised against tetanus reaching their second birthday in the year}
#'   \item{Year}{Time frame}
#'.  ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/Immunisation}
"hl_tetanus_vaccination_coverage"

#' Whooping cough vaccination coverage Wales 2021-2023
#'
#' Dataset containing information about the percentage of children in Wales immunized against whooping cough by their second birthday
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Whooping cough percentage coverage by 2nd birthday}{Percentage of children immunised against whooping cough reaching their second birthday in the year}
#'   \item{Year}{Time frame}
#'.  ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/Immunisation}
"hl_whooping_cough_vaccination_coverage"

#' Polio vaccination coverage Wales 2021-2023
#'
#' Dataset containing information about the percentage of children in Wales immunized against polio by their second birthday
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Polio percentage coverage by 2nd birthday}{Percentage of children immunised against polio reaching their second birthday in the year}
#'   \item{Year}{Time frame}
#'.  ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/Immunisation}
"hl_polio_vaccination_coverage"

#' MMR vaccination coverage Wales 2021-2023
#'
#' Dataset containing information about the percentage of children in Wales immunized against Measles, Mumps and Rubella (MMR) by their second birthday
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{MMR percentage coverage by 2nd birthday}{Percentage of children immunised against Measles, Mumps and Rubella (MMR) reaching their second birthday in the year}
#'   \item{Year}{Time frame}
#'.  ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/Immunisation}
"hl_mmr_vaccination_coverage"

#' Pneumococcal vaccination coverage Wales 2021-2023
#'
#' Dataset containing information about the percentage of children in Wales immunized against pneumococcal disease by their second birthday
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Pneumococcal percentage coverage by 2nd birthday}{Percentage of children immunised against pneumococcal disease reaching their second birthday in the year}
#'   \item{Year}{Time frame}
#'.  ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/Immunisation}
"hl_pneumococcal_vaccination_coverage"

#' Meningitis B vaccination coverage Wales 2021-2023
#'
#' Dataset containing information about the percentage of children in Wales immunized against meningitis B by their second birthday
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Meningitis B percentage coverage by 2nd birthday}{Percentage of children immunised against meningitis B reaching their second birthday in the year}
#'   \item{Year}{Time frame}
#'.  ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/Immunisation}
"hl_meningitisb_vaccination_coverage"
