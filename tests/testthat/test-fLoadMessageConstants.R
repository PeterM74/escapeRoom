test_that("fLoadMessageConstants in correct format", {
  
  Settings <- fGetSettings()
  TestResult <- fLoadMessageConstants(Settings)
  
  # Tests
  expect_type(TestResult, "character")
  expect_named(TestResult)
  
  expect_true(all(stringr::str_detect(names(TestResult), pattern = "[[:upper:]]", negate = TRUE)))  # Command name is converted to lowercase when received from terminal
  expect_false("" %in% names(TestResult))  # Cannot have a blank name
  expect_false(any(c("", NA, NULL) %in% TestResult))  # Cannot have a blank result
  

})
