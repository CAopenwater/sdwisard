#' Query SDWIS by PSID
#'
#' @description Query the SDWIS database by a public water system ID (PSID), start and end date, and storet.
#' @param psid The public water system ID to be queried.
#' @param start_date The starting date for queried results.
#' @param end_date The end date for queried results.
#' @param storet A single storet to return.
#' @return A data.table of storet results for the input PSID and date range.
#' @examples
#' d <- get_data("103039")
#' head(d)
#'
#' # Alameda Country Water District (psid = 110001)
#' # nitrate data (storet = A-029)
#' get_data(
#'   psid   = "110001",
#'   storet = "A-029"
#' ) %>%
#' ggplot(aes(SAMP_DATE, FINDING)) +
#'   geom_point() +
#'   geom_smooth()

get_data <- function(psid = NULL, storet = NULL, start_date = NULL, end_date = NULL) {

  # errors in PSID
  if(is.null(psid)) stop("No psid was entered. To find a water system PSID, query by county. For example: `get_water_system(county = 'Alameda')`.", call. = FALSE)

  if(length(psid) > 1) stop(paste0("Only one psid can be entered, not ", length(psid), "."), call. = FALSE)

  if(! psid %in% water_systems$psid) stop("Invalid psid. To find a valid water system PSID, query by county. For example: `get_water_system(county = 'Alameda')`.", call. = FALSE)

  if(! class(psid) %in% c("character", "numeric", "integer")) {
    stop("Argument `psid` must be of class `character`, `numeric`, or `integer`.", call. = FALSE)
  }

  # errors in storet
  if(! is.null(storet)) {
    if(length(storet) > 1) {
      stop("Only a single storet may be supplied.", call. = FALSE)
    }
    if(! (storet %in% psid_analyte[which(psid_analyte$psid == psid), ]$storet)) {
      stop(paste0("The requested storet '", storet,
                  "' is not found for the input psid ",
                  psid, ". Use `get_storet_summary(",
                  psid, ")` to see available storets."),
           call. = FALSE)
    }
  }

  # construct url and ping s3
  url <- paste0('https://sdwis.s3.us-west-1.amazonaws.com/', psid, '.csv.gz')
  s3_dat <- data.table::fread(url)

  # if present, filter by storet, and start and end dates
  if(! is.null(storet)) {
    s3_dat <- s3_dat[s3_dat$STORE_NUM == storet, ]
  }
  if(! is.null(start_date)) {
    s3_dat <- s3_dat[s3_dat$SAMP_DATE >= start_date, ]
  }
  if(! is.null(end_date)) {
    s3_dat <- s3_dat[s3_dat$SAMP_DATE <= end_date, ]
  }
  return(s3_dat)
}
