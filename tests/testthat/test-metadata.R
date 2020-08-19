test_that("Returns water system when supplied county", {
  expect_equal(get_water_system(county = "E"), "B")
})

test_that("Graceful return for non-existent county", {
  expect_true(is.na(suppressWarnings(get_water_system(county = "Mars"))))
  expect_warning(get_water_system(county = "Mars"), "county Mars was not found")
})

test_that("Errors when psid is invalid",  {
  expect_error(get_analyte_summary(1), "the psid 1 is invalid")
})

test_that("Returns summary for a provided psid",  {
  expect_equal(get_analyte_summary("103039"),
               structure(list(
                 psid = c("103039", "103039", "103039", "103039", "103039"),
                 storet = c("00081", "00086", "00095", "00403", "00618"),
                 analyte = c("COLOR", "ODOR THRESHOLD @ 60 C", "SPECIFIC CONDUCTANCE",
                             "PH, LABORATORY", "NITRATE (AS N)"),
                 start_date = structure(c(17492, 17492, 17492, 17492, 17492), class = "Date"),
                 end_date = structure(c(17492, 17492, 17492, 17492, 17492), class = "Date"),
                 n = c(1L, 1L, 1L, 1L, 1L)),
                 row.names = c(NA, 5L), class = "data.frame"))}
)

test_that("Errors when analyte returns no results", {
  expect_error(get_storet_id("bubblegum"), "There are no storet IDs associated with the analyte bubblegum")
})

test_that("Returns possible storet ids given an analyte search term", {
  expect_equal(get_storet_id("COLOR"),
               structure(list(storet = "00081", analyte = "COLOR"),
                         row.names = 1L, class = "data.frame"))
})
