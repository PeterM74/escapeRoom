test_that("fHelpCommand in correct format", {
  
  Settings <- fGetSettings()
  TestResult <- fHelpCommand(Settings)
  NamesReturned <- names(TestResult)
  
  # Tests
  expect_type(TestResult, "character")
  expect_named(TestResult)
  
  ## Checking results
  expect_true(all(stringr::str_detect(NamesReturned, pattern = "[[:upper:]]", negate = TRUE)))  # Command name is converted to lowercase when received from terminal
  expect_equal(sum("" == NamesReturned), 1)  # Cannot have a blank name except for first result
  expect_false(any(c("", NA, NULL) %in% TestResult))  # Cannot have a blank result
  
  ## Ensure first result is the generic help command
  expect_true(dplyr::first(TestResult) %>%
                stringr::str_detect(pattern = "\n"))  # Should be long over multiple lines
  expect_true(dplyr::first(TestResult) %>%
                stringr::str_detect(pattern = "v[0-9].[0-9].[0-9]"))  # Should have a (fake) version number to signify the generic help command - change if version removed
  expect_true(NamesReturned[1] == "")  # First should be blank
  
  # Check rest of commands
  MethodsAvailable <- methods(fParseCommand) %>% 
    as.character() %>%
    stringr::str_extract(pattern = "\\.(.*)$") %>%
    stringr::str_remove(pattern = "^.") %>%  # I'm terrible at regex so including this to remove the starting period
    .[. != "default"]
  expect_in(MethodsAvailable, NamesReturned)  # All important commands are mapped to a help
  
  
})
