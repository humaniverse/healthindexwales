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

#' Physical activity Wales 2021-2023
#'
#' Dataset containing information about the percentage of physically active adults in Wales
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Percent adults active at least 150 minutes last week}{Percentage of people aged 16 and over in each local authority claiming to have exercised for at least 150 minutes the previous week, age standardised}
#' "hl_physical_activity"


#' Secondary Pupil Absences Wales 2022/2023
#'
#' Dataset containing information about the percentage of absences for secondary school students in Wales for the academic year 2022/2023 up until the late May bank holiday
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Secondary percentage of absences}{Percentage of half day sessions missed for secondary school students, aged 11-15, for the academic year up until the late May bank holiday (due to effect of exams in May and June on absences), in Wales}
#'   \item{Year}{Academic year (until late May bank holiday)}
#'.  ...
#' }
#' @source \url{https://www.gov.wales/absenteeism-secondary-schools-september-2022-august-2023}
"hl_secondary_pupil_absences"
