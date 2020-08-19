test_that("psid is present", {
  expect_error(get_data(), "No psid was entered.")
})

test_that("only one psid is supplied", {
  expect_error(get_data(c("123", "456")), "Only one psid can be entered, not 2.")
})

test_that("psid is valid", {
  expect_error(get_data("dog"), "Invalid psid.")
})

test_that("factors fail", {
  expect_error(get_data(factor("103039")), "Argument `psid` must be of class `character`, `numeric`, or `integer`.")
})

test_that("informative error is given for invalid analyte", {
  expect_error(get_data(psid = 103039, analyte = "dog"), "The requested analyte 'dog' is not found.")
})

test_that("informative error is given for multiple analytes", {
  expect_error(get_data(psid = 103039, analyte = c("dog","cat")), "Only a single analyte may be supplied.")
})
