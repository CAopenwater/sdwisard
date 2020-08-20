#' Get Water System
#' @description Enable user to discover water system ID when supplied a county of interest
#' @param county county
#' @examples
#' get_water_system(county = "FRESNO")
#' @export
get_water_system <- function(county) {

  upper_county <- toupper(county)

  water_system <- subset(water_systems, (!is.na(psid) & county == upper_county),
                         select = c(psid, water_system_name))

  if (nrow(water_system) == 0) {
    warning(paste("county", county, "was not found", call. = FALSE))
    water_system <- NA
  }

  water_system

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
    stop(paste("the psid", psid, "is invalid"), call. = FALSE)
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
    stop(paste("There are no storet IDs associated with the analyte", analyte), call. = FALSE)
  }

  storets

}
