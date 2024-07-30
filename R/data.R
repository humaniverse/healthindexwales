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
#' "hl_smoking"

#' Pupil Attainment Wales 2022/2023
#'
#' Dataset containing information about the numeracy point score of GCSE students in Wales
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Numeracy Point Score}{Score comparing GCSE numeracy ability in Wales. Score is calculated by taking the single best grade for each GCSE student out of GCSE Mathematics or GCSE Mathematics – numeracy. Each student is assigned a score based on that grade: Grade A* = 58, Grade A = 52, Grade B = 46, Grade C = 40, Grade D = 34, Grade E = 28, Grade F = 22, Grade G = 16, Grade U/X = 0. Or, if using the 1-9 grading system: Grade 9 score = 58, Grade 8 score = 55, Grade 7 score = 52, Grade 6 score = 48, Grade 5 score = 44, Grade 4 score = 40, Grade 3 score = 32, Grade 2 score = 24, Grade 1 score = 16, Grade U Score = 0. The literacy point score is the average of each student's score, calculated for each local authority}
#'   \item{Year}{Academic year}
#'.  ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/Education-and-Skills/Schools-and-Teachers/Examinations-and-Assessments/Key-Stage-4}
"hl_pupil_attainment_numeracy"
