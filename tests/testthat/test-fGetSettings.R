test_that("Settings list returns correct format", {
  
  Settings <- fGetSettings()
  
  # Tests
  expect_type(Settings, "list")
  
  ## All referenced names of list are output
  expect_named(Settings, c("TotalTimer", "BBEGName", "BBEGPronouns", "Modules", "HintPenalty", 
                           "MessageConstants", "HelpCommands", "AbortPasscode", "TotalTimerSecs"))
  
  ## Total timer is a period object
  expect_s4_class(Settings$TotalTimer, "Period")
  
  ## BBEG reference
  expect_type(Settings$BBEGName, "character")
  expect_type(Settings$BBEGPronouns, "character")  # Not currently referenced
  
  ## Module data - tested separately in own function
  expect_type(Settings$Modules, "list")
  
  ## Hint penalties
  expect_type(Settings$HintPenalty, "list")
  expect_length(Settings$HintPenalty, 2)
  expect_named(Settings$HintPenalty, c("Hint", "Extrahint"))
  expect_type(Settings$HintPenalty$Hint, "numeric")
  expect_type(Settings$HintPenalty$Extrahint, "numeric")
  
  ## Message constants - tested separately in own function
  expect_type(Settings$MessageConstants, "character")
  
  ## Help commands - tested separately in own function
  expect_type(Settings$HelpCommands, "character")
  
  ## Abort password
  expect_type(Settings$AbortPasscode, "character")
  expect_setequal(purrr::map_chr(Settings$Modules, function(l) stringr::word(l$Success, -1) %>%
                                   stringr::str_remove(pattern = ".$")),
                  stringr::str_split(Settings$AbortPasscode, pattern = "")[[1]])  # Ensure abort passcode equals all elements of key from default puzzles
  
  ## Total timer in seconds
  expect_type(Settings$TotalTimerSecs, "numeric")
  
  
})
