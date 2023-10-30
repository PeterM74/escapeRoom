test_that("fModuleData in correct format", {
  
  Settings <- fGetSettings()
  TestResult <- fModuleData(Settings)
  NamesReturned <- names(TestResult)
  
  # Tests
  expect_type(TestResult, "list")
  expect_named(TestResult)
  
  ## Checking results for overall list
  expect_true(all(stringr::str_detect(NamesReturned, pattern = "[[:upper:]]")))  # Module codes should be uppercase for consistency
  expect_false("" %in% NamesReturned)  # Cannot have a blank name
  expect_false(any(c("", NA, NULL) %in% TestResult))  # Cannot have a blank result
  
  ## Ensure each result has the necessar components
  expect_true(purrr::map_lgl(TestResult,
                             function(TR) {
                               
                               all(names(TR) %in% c("Print", "Hint", "Extrahint", "Submit", "Success", "Failure")) &
                                 all(c("Print", "Hint", "Extrahint", "Submit", "Success", "Failure") %in% names(TR))
                               
                             }) %>%
                all())  # Named elements of each challenge are present
  expect_true(purrr::map_lgl(TestResult,
                             function(TR) {
                               
                               purrr::map_lgl(TR, function(Message) {
                                 
                                 is.character(Message) & Message != "" & !is.na(Message) & !is.null(Message)
                                 
                               })
                               
                             }) %>%
                all())  # Each element of each challenge is a string and is not blank
  
  ## Check that all challenges included in default app are included in fModuleData
  FileList <- list.files(path = "../../docs/", pattern = ".qmd$") %>%
    .[stringr::str_detect(., pattern = "^[A-Z0-9]{3}-")]  # Assumes the documents retain the format of ABC-Name.qmd, where ABC is the module code
  expect_setequal(stringr::str_extract(FileList, pattern = "^[A-Za-z0-9]+(?=-)"), NamesReturned)
  
  
})
