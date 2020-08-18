test_that("Errors when no zipcode or county provided", {
  expect_error(get_water_system(), "supply either a zipcode or county")
})

test_that("Errors when more than one argument provided", {
  expect_error(get_water_system(zipcode = 123, county = "A"), "supply only zipcode or county")
})

test_that("Returns water system when supplied zipcode", {
  expect_equal(get_water_system(zipcode = 90201), "A")
})

test_that("Returns water system when supplied county", {
  expect_equal(get_water_system(county = "E"), "B")
})
