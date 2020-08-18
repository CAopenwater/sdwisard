#' Query SDWIS by PSID
#'
#' @description Query the SDWIS database by a public water system ID (PSID), start and end date, and analyte.
#' @param psid The public water system ID to be queried.
#' @param start_date The starting date for queried results.
#' @param end_date The end date for queried results.
#' @param analytes A vector of analytes to return.
#' @return A data.table of analyte results for the input PSID and given dates.
#' @examples
#' d <- get_data("103039")
#' head(d)
#'
#' get_data(
#'   psid    = "110001",
#'   analyte = "NITRATE + NITRITE (AS N)"
#' ) %>%
#' ggplot(aes(SAMP_DATE, FINDING)) +
#'   geom_point() +
#'   geom_smooth()


get_data <- function(psid, start_date = NULL, end_date = NULL, analyte = NULL) {

  if(! (analyte %in% dplyr::pull(dplyr::filter(psid_analyte, psid == psid), analyte))){
    stop(paste("The requested analyte", analyte, "is not found for the input psid", psid),
         call. = FALSE)
  }

  if(!is.numeric(psid) & !is.character(psid)) {
    stop("Argument `psid` must be of class `numeric` or `character`. To view a psid lookup table, see the built-in object `psid_df`.",
         call. = FALSE)
  }
  url = paste0('https://sdwis.s3.us-west-1.amazonaws.com/', psid, '.csv.gz')
  d   = data.table::fread(url)

  # if present, filter by state and end dates and analytes
  if(!is.null(start_date)){
    d <- dplyr::filter(d, SAMP_DATE >= start_date)
  }
  if(!is.null(end_date)){
    d <- dplyr::filter(d, SAMP_DATE <= end_date)
  }
  if(!is.null(analytes)){
    d <- dplyr::filter(d, CHEMICAL %in% analytes)
  }
  return(d)
}
