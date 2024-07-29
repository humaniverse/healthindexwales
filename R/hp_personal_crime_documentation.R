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
#'   \item{personal_crime_score}{Numeric. The calculated personal crime score.}
#' }
#' @source \url{https://www.ons.gov.uk/} and \url{https://opendata.arcgis.com/}
#' @examples
#' data(hp_personal_crimes)
#' head(hp_personal_crimes)
#' 
#' @export
hp_personal_crimes <- NULL
