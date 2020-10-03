test_that("Errors when no zipcode or county provided", {
  expect_error(get_water_system(), "Supply a county.")
})

test_that("Returns water system when supplied county", {
  expect_error(get_water_system(county = "Alamed"), "Couldn't find ALAMED but did you mean ALAMEDA?", fixed = TRUE)
})

test_that("Graceful return for non-existent county", {
  expect_error(get_water_system(county = "Mars"), "Couldn't find MARS but did you mean one of the following: MARIN, MARIPOSA, PLUMAS?", fixed = TRUE)
})

test_that("Errors when psid is invalid",  {
  expect_error(get_analyte_summary(1), "The psid 1 is invalid.")
})

test_that("Returns summary for a provided psid",  {
  expect_equal(get_analyte_summary("0105009"),
               structure(list(psid = c("0105009", "0105009", "0105009", "0105009",
                                       "0105009"), storet = c("00618", "00620", "01002", "01032", "71850"
                                       ), analyte = c("NITRATE (AS N)", "NITRITE (AS N)", "ARSENIC",
                                                      "CHROMIUM, HEXAVALENT", "NITRATE (AS NO3)"), start_date = structure(c(18339,
                                                                                                                            18339, 16518, 16518, 16518), class = "Date"), end_date = structure(c(18339,
                                                                                                                                                                                                 18339, 16700, 16701, 16594), class = "Date"), n = c(1L, 1L, 3L,
                                                                                                                                                                                                                                                     3L, 2L)), row.names = c(NA, -5L), class = c("tbl_df", "tbl",
                                                                                                                                                                                                                                                                                                 "data.frame"), sorted = c("psid", "storet", "analyte")))
})

test_that("Errors when analyte returns no results", {
  expect_error(get_storet_id("bubblegum"), "There are no storet IDs associated with the analyte bubblegum.")
})

test_that("Returns possible storet ids given an analyte search term", {
  expect_equal(get_storet_id("COLOR")$storet, "00081")
})
