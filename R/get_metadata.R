#' Get Water System
#' @description Enable user to discover water system ID when supplied a zipcode or county of interest
#' @param zipcode zipcode
#' @param county county
#' @examples
#' get_water_system(zipcode = "90201")
#' get_water_system(county = "D")
#' @export
get_water_system <- function(county = NULL) {

  if (is.null(county)) stop("Supply a county.", call. = FALSE)
  if (length(county) > 1) stop("Supply only one county.", call. = FALSE)

  all_counties      <- unique(water_systems$county)
  user_input_county <- toupper(county)

  if(! user_input_county %in% all_counties) {

    approximate_match <- all_counties[ agrep(user_input_county, all_counties) ]

    if(length(approximate_match) > 1) {
      approximate_match <- paste("one of the following:", paste(approximate_match, collapse = ", "))
    }

    stop(paste0("Couldn't find ", user_input_county,
                " but did you mean ", approximate_match, "?"),
         call. = FALSE)
  }

  water_system <- water_systems[water_systems$county == user_input_county, ]

  if (!length(water_system)) {
    warning(paste("County", county, "was not found."), call. = FALSE)
    water_system <- NA
  }

  return(water_system)

}

#' Get Analyte Summary
#' @description  For a given water system ID (psid), returns all the analytes
#' with their date range and number of records
#' @param psid water system id
#' @examples
#' get_analyte_summary("103039")
#' @export
get_analyte_summary <- function(psid) {

  summary <- psid_analyte[psid_analyte$psid == psid, ]

  if (nrow(summary) == 0) {
    stop(paste("The psid", psid, "is invalid."), call. = FALSE)
  }

  summary

}

#' Get Storet ID
#' @description Helps users obtain the appropriate storet ID for a given analyte
#' @param analyte common name of chemical
#' @examples
#' get_storet_id("c")
#' get_storet_id("Color")
#' get_storet_id("COLOR")
#' @export
get_storet_id <- function(analyte) {

  storets <- analytes[grep(analyte, analytes$analyte, ignore.case = TRUE), ]

  if (nrow(storets) == 0) {
    stop(paste0("There are no storet IDs associated with the analyte ", analyte, "."), call. = FALSE)
  }

  storets

}
