#' Query SDWIS by PSID
#'
#' @description Query the SDWIS database by a public water system ID (PSID), start and end date, and analyte.
#' @param psid The public water system ID to be queried.
#' @param start_date The starting date for queried results.
#' @param end_date The end date for queried results.
#' @param analyte A single analyte to return.
#' @return A data.table of analyte results for the input PSID and date range.
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

get_data <- function(psid = NULL, analyte = NULL, start_date = NULL, end_date = NULL) {

  # errors
  if(is.null(psid)) stop("No psid was entered. To view a table of water systems, see the built-in object `water_systems`.", call. = FALSE)

  if(length(psid) > 1) stop(paste0("Only one psid can be entered, not ", length(psid), "."), call. = FALSE)

  if(! psid %in% water_systems$psid) stop("Invalid psid. To view a table of water systems, see the built-in object `water_systems`.", call. = FALSE)

  if(! class(psid) %in% c("character", "numeric", "integer")) {
    stop("Argument `psid` must be of class `character`, `numeric`, or `integer`. To view a table of water systems, see the built-in object `water_systems`.", call. = FALSE)
  }

  if(! is.null(analyte)) {
    if(length(analyte)>1) stop("Only a single analyte may be supplied.")
    if(! (analyte %in% psid_analyte[which(psid_analyte$psid == psid), ]$analyte)) {
      stop(paste0("The requested analyte '", analyte,
                  "' is not found for the input psid ",
                  psid, ". Use `get_analyte_summary(",
                  psid, ")` to see available analytes."),
           call. = FALSE)
    }
  }

  # construct url and ping s3
  url <- paste0('https://sdwis.s3.us-west-1.amazonaws.com/', psid, '.csv.gz')
  s3_dat <- data.table::fread(url)

  # if present, filter by analyte, and start and end dates
  if(! is.null(analyte)) {
    s3_dat <- s3_dat[s3_dat$CHEMICAL == analyte, ]
  }
  if(! is.null(start_date)) {
    s3_dat <- s3_dat[s3_dat$SAMP_DATE >= start_date, ]
  }
  if(! is.null(end_date)) {
    s3_dat <- s3_dat[s3_dat$SAMP_DATE <= end_date, ]
  }
  return(s3_dat)
}
