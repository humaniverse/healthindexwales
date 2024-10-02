#' @importFrom tibble tibble
NULL

#' Alcohol Death Rates 2020-2022
#'
#' Dataset containing information about death rate from alcohol misuse in Wales
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Alcohol death rate per 100,000}{Age standardised alcohol-specific death rate per 100,000}
#'   \item{Year}{Time frame}
#' .  ...
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
#' .  ...
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
#' .  ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/National-Survey-for-Wales/Population-Health/Adult-Lifestyles}
"hl_sedentary_behaviour"

#' Secondary Pupil Absences Wales 2022/2023
#'
#' Dataset containing information about the percentage of absences for secondary school students in Wales for the academic year 2022/2023 up until the late May bank holiday
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Secondary percentage of absences}{Percentage of half day sessions missed for secondary school students, aged 11-15, for the academic year up until the late May bank holiday (due to effect of exams in May and June on absences), in Wales}
#'   \item{Year}{Academic year (until late May bank holiday)}
#' .  ...
#' }
#' @source \url{https://www.gov.wales/absenteeism-secondary-schools-september-2022-august-2023}
"hl_secondary_pupil_absences"

#' Smoking Wales 2021-2023
#'
#' Dataset containing information about the percentage of smokers in Wales
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Percent smokers}{Percentage of people aged 16 and over in each local authority who are self-reported smokers, age standardised}
#'   \item{Year}{Time frame}
#' .  ...
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
#' @source \url{https://statswales.gov.wales/Catalogue/National-Survey-for-Wales/Population-Health/Adult-Lifestyles}
"hl_physical_activity"

#' Primary Pupil Absences Wales 2022/2023
#'
#' Dataset containing information about the percentage of absences for primary school students in Wales for the academic year 2022/2023
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Primary percentage of absences}{Percentage of half day sessions missed for primary school students, aged 5-10, for the full academic year, in Wales}
#'   \item{Year}{Academic year}
#' .  ...
#' }
#' @source \url{https://www.gov.wales/absenteeism-primary-schools-september-2022-august-2023}
"hl_primary_pupil_absences"

#' Pupil Literacy Attainment Wales 2022/2023
#'
#' Dataset containing information about the literacy point score of GCSE students in Wales
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Literacy Point Score}{Score comparing GCSE literacy ability in Wales. Score is calculated by taking the single best grade for each GCSE student out of GCSE English language, GCSE English Literature, GCSE Welsh language or GCSE Welsh Literature. Each student is assigned a score based on that grade: Grade A* = 58, Grade A = 52, Grade B = 46, Grade C = 40, Grade D = 34, Grade E = 28, Grade F = 22, Grade G = 16, Grade U/X = 0. Or, if using the 1-9 grading system: Grade 9 score = 58, Grade 8 score = 55, Grade 7 score = 52, Grade 6 score = 48, Grade 5 score = 44, Grade 4 score = 40, Grade 3 score = 32, Grade 2 score = 24, Grade 1 score = 16, Grade U Score = 0. The literacy point score is the average of each student's score, calculated for each local authority}
#'   \item{Year}{Academic year}
#' .  ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/Education-and-Skills/Schools-and-Teachers/Examinations-and-Assessments/Key-Stage-4}
"hl_pupil_attainment_literacy"

#' Pupil Numeracy Attainment Wales 2022/2023
#'
#' Dataset containing information about the numeracy point score of GCSE students in Wales
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Numeracy Point Score}{Score comparing GCSE numeracy ability in Wales. Score is calculated by taking the single best grade for each GCSE student out of GCSE Mathematics or GCSE Mathematics – numeracy. Each student is assigned a score based on that grade: Grade A* = 58, Grade A = 52, Grade B = 46, Grade C = 40, Grade D = 34, Grade E = 28, Grade F = 22, Grade G = 16, Grade U/X = 0. Or, if using the 1-9 grading system: Grade 9 score = 58, Grade 8 score = 55, Grade 7 score = 52, Grade 6 score = 48, Grade 5 score = 44, Grade 4 score = 40, Grade 3 score = 32, Grade 2 score = 24, Grade 1 score = 16, Grade U Score = 0. The literacy point score is the average of each student's score, calculated for each local authority}
#'   \item{Year}{Academic year}
#' .  ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/Education-and-Skills/Schools-and-Teachers/Examinations-and-Assessments/Key-Stage-4}
"hl_pupil_attainment_numeracy"

#' Teenage Pregnancy Wales 2021-2023
#'
#' Dataset containing information about the percentage of teenage pregnancies in Wales
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code of usual residence}
#'   \item{Percentage teenage pregnancies}{Percentage of conceptions for women aged 15-17, based on quarterly numbers of conceptions aged 15-17 and ONS population estimates. Conception includes live or still births and legal abortions, does not include miscarriages or illegal abortions}
#'   \item{Year}{Time frame}
#' .  ...
#' }
#' @source \url{https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/conceptionandfertilityrates/datasets/quarterlyconceptionstowomenagedunder18englandandwales}
#' @source \url{https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationestimates/datasets/populationestimatesforukenglandandwalesscotlandandnorthernireland}
"hl_teenage_pregnancy"

#' Bowel Cancer Screening Attendance Wales 2021-2022
#'
#' Dataset containing information about the percentage of adults age 58-74 who attended bowel cancer screenings in Wales

#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Screening uptake percentage}{Percentage of adults out of those invited to attend bowel cancer screening (aged 58-74) who attended their screening. Participants were deemed to have responded to their invitation if the bowel screening programme received a used test kit within six months following their invitation.}
#'   \item{Year}{Financial Year}
#' .  ...
#' }
#' @source \url{https://phw.nhs.wales/services-and-teams/screening/bowel-screening/programme-reports/uptake-coverage-by-local-authority-and-health-boards/}
"hl_cancer_screening_bowel"

#' Breast Cancer Screening Attendance Wales 2021-2022
#'
#' Dataset containing information about the percentage of women age 50-70 who attended breast cancer screenings
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Screening uptake percentage}{Percentage of adults out of those invited to attend breast cancer screening (aged 50-70) who attended their screening. Women were counted as having responded to their invitation if they attended for screening within six months of original invitation.}
#'   \item{Year}{Time frame for last recorded Breast Cancer screening, May 2021}
#' .  ...
#' }
#' @source \url{https://phw.nhs.wales/services-and-teams/screening/breast-screening/programme-reports/uptake-coverage-by-local-authority-and-health-boards/}
"hl_cancer_screening_breast"

#' Cervical Cancer Screening Attendance Wales 2021-2022
#'
#' Dataset containing information about the percentage of women age 25-64 who attended cervical cancer screenings
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Screening uptake percentage}{Percentage of adults out of those invited to attend cervical cancer screening (aged 25-64) who attended their screening. Women were counted as having responded if they are aged 25-49 years who have received an adequate test in the last 3.5 years and if they are aged 50-64 years who received an adequate test in the last 5.5 years.}
#'   \item{Year}{Financial Year}
#' .  ...
#' }
#' @source \url{https://phw.nhs.wales/services-and-teams/cervical-screening-wales/information-resources/programme-reports/uptake-coverage-by-local-authority-and-health-boards/}
"hl_cancer_screening_cervical"

#' Diphtheria vaccination coverage Wales 2021-2023
#'
#' Dataset containing information about the percentage of children in Wales immunized against diphtheria by their second birthday
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Diphtheria percentage coverage by 2nd birthday}{Percentage of children immunised against diphtheria reaching their second birthday in the year}
#'   \item{Year}{Time frame}
#' .  ...
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
#' .  ...
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
#' .  ...
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
#' .  ...
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
#' .  ...
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
#' .  ...
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
#' .  ...
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
#' .  ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/Immunisation}
"hl_meningitisb_vaccination_coverage"

#' Greenspace Provision in Wales 2024
#'
#' Dataset containing information about greenspace provision in Wales
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{ltla21_name}{Area name}
#'   \item{provision_per_person}{The amount of public greenspace available per person, SQM}
#' .  ...
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

#' Young people in education, employment and apprenticeships Wales 2009/2010
#'
#' Dataset containing information about the standard participation rate in sustained education, employment or an apprenticeship for 16-24 year olds after key stage 4
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Participation rate under 20}{Participation rate in post-16 (after Key Stage 4) Education and Training in Wales for under 20 year olds. Participation rate is calculated using census data population count by local authority, with participation measured against the Welsh national average of 100. Participation rates above 100 reflect high participation rates, below 100 low participation rates}
#'   \item{Year}{Academic year}
#' .  ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/Education-and-Skills/Post-16-Education-and-Training/Further-Education-and-Work-Based-Learning/Standardised-Participation-Rates}
"hl_education_employment_apprenticeship"

#' Low Birth Weight Percentage by year Wales
#'
#' Dataset containing information about the percentage of live births under 2500g in Wales
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{percentage_low_birth_weight}{The percentage of singleton live births under 2500g in each local authority of Wales}
#'   \item{Year}{Time frame}
#' .  ...
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
#' .  ...
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
#'   \item{percentage_overweight_obese}{The percentage of overweight and obese children in the 91st centile aged 4-5 in each local authority of Wales}
#'   \item{Year}{Time frame}
#' .  ...
#' }
#' @source \url {https://phw.nhs.wales/services-and-teams/child-measurement-programme/cmp-2022-23/}
"hl_reception_overweight_obese"

#' Rates of Rough Sleepers in Wales (2023-24)
#'
#' A dataset containing statistics on rates of rough sleepers per 1,000 individuals, by
#' Local Authority, 2023-2024.
#'
#' Rough sleepers are defined as persons who are sleeping overnight in the open air
#' (such as shop doorways, bus shelters or parks) or in buildings, vehicles or other
#' places not designed for habitation (such as stairwells, barns, sheds, car parks, tents, cars/vans).
#'
#' Mid-year population estimates for 2023 are used.
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla22_code}{Local Authority Code}
#' \item{rough_sleepers_per_1k_population}{Annual rate of people assessed as rough sleepers per 1,000
#' individuals in the Local Authority}
#' \item{year}{Date}
#'
#' ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/Housing/Homelessness/homelessness-accommodation-provision-and-rough-sleeping/roughsleepers-by-localauthority}
#' and \url{https://statswales.gov.wales/Catalogue/Population-and-Migration/Population/Estimates/Local-Authority/populationestimates-by-localauthority-year}
"hp_rough_sleepers"
#'
#' Percentage of children (Under 16) in Absolute Poverty in Wales (2022)
#'
#' A dataset containing statistics on the percentage of children under 16 experiencing
#' absolute poverty, by Local Authority, 2022.
#'
#' Absolute poverty refers to people living in households with income below 60% of median income in a base year, usually 2010/11.
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla21_code}{Local Authority Code}
#' \item{percentage_children_absolute_poverty}{Annual percentage of children (under 16) assessed as living in absolute poverty in 2022}
#' \item{year}{Date}
#'
#' ...
#' }
#' @source \url{https://www.gov.uk/government/statistics/children-in-low-income-families-local-area-statistics-2014-to-2022}
#' "hp_child_poverty"
