#' Get Water System
#' @param zipcode zip
#' @param county county
#' @export
get_water_system <- function(...) {


  arg <- list(...)
  if (length(arg) == 0) stop("supply either a zipcode or county", call. = FALSE)
  if (length(arg) > 1) stop("supply only zipcode or county", call. = FALSE)

  if (names(arg) == "zipcode") {
    water_system <- water_systems[water_systems$zipcode == arg$zipcode, ]$water_system_name
  } else if (names(arg) == "county"){
    water_system <-water_systems[water_systems$county == arg$county, ]$water_system_name
  }

  if (!length(water_system)) {
    warning(paste(names(arg), arg[[1]], "was not found"), call. = FALSE)
    water_system <- NA
  }

  water_system
}

get_analyte_summary <- function(psid) {

}

get_storet <- function(analyte){

}

