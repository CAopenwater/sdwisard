test_that("Errors when no zipcode or county provided", {
  expect_error(get_water_system(), "supply either a zipcode or county")
})

test_that("Errors when more than one argument provided", {
  expect_error(get_water_system(zipcode = 123, county = "A"), "supply only zipcode or county")
})

test_that("Errors when no named argument is provided", {
  expect_error(get_water_system(123), "supply named argument")
})

test_that("Returns water system when supplied zipcode", {
  expect_equal(get_water_system(zipcode = 90201), "A")
})

test_that("Returns water system when supplied county", {
  expect_equal(get_water_system(county = "E"), "B")
})

test_that("Graceful return for non-existent zipcode", {
  expect_true(is.na(suppressWarnings(get_water_system(zipcode = 123))))
  expect_warning(get_water_system(zipcode = 123), "zipcode 123 was not found")
})

test_that("Graceful return for non-existent county", {
  expect_true(is.na(suppressWarnings(get_water_system(county = "Mars"))))
  expect_warning(get_water_system(county = "Mars"), "county Mars was not found")
})
