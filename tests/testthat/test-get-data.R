test_that("psid is present", {
  expect_error(get_data(), "No psid was entered.")
})

test_that("psid is valid", {
  expect_error(get_data("dog"), "Invalid psid. Find a PSID by county, for example, get_water_system('Alameda').", fixed = TRUE)
})

test_that("only one psid is supplied", {
  expect_error(get_data(c("123", "456")), "Only one psid can be entered, not 2.")
})

test_that("factors fail", {
  expect_error(get_data(factor("0105009")), "Argument `psid` must be of class `character`.")
})

test_that("informative error is given for invalid analyte", {
  expect_error(get_data(psid = "0105009", storet = "dog"), "The requested storet 'dog' is not found for the input psid 0105009. Use get_storet_summary(0105009) to see available storets.", fixed = TRUE)
})

test_that("informative error is given for multiple analytes", {
  expect_error(get_data(psid = "0105009", storet = c("dog","cat")), "Only a single storet may be supplied.")
})
