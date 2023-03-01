#' Load settings referenced by the Shiny app
#' This function returns a list of settings that can be adjusted for your escape room.
#' Parameters that start with 
#' @return Named list of settings
fGetSettings <- function() {
  
  Settings <- list()
  
  # User adjusted settings - the below settings may be adjusted -----
  ## Adjust the escape room timer
  Settings$TotalTimer <- lubridate::hours(3) # + lubridate::minutes(30) + lubridate::seconds(30)
  
  
  ## BBEG name referenced throughout
  Settings$BBEGName <- "Dr Malum"
  Settings$BBEGPronouns <- c("they", "them")
  
  
  ## Custom messages and help commands - change these functions to add additional messages/help commands
  Settings$MessageConstants <- fLoadMessageConstants(Settings)  # Simple command => message response that doesn't require logic
  Settings$HelpCommands <- fHelpCommand(Settings)  # Message returned when help <<command>> is run
  
  
  
  
  
  # Permanent settings - these shouldn't be adjusted unless you are confident of the downstream effects -----
  ## Period object is parsed oddly by reactiveValues, converting to seconds count to bypass
  Settings$TotalTimerSecs <- Settings$TotalTimer %/% lubridate::seconds(1)
  
  
  
  return(Settings)
  
}
