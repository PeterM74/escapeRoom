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
  ### If changing the name, you must also update the TVscript.js with a new title in the onInit variable. ASCII Source:
  ### https://patorjk.com/software/taag/#p=display&f=3D-ASCII&t=Dr%20Malum
  Settings$BBEGName <- "Dr Malum"   
  Settings$BBEGPronouns <- c("they", "them")
  
  
  
  ## Modify active modules
  Settings$Modules <- fModuleData(Settings)
  
  
  
  ## Modify penalty on hint or extrahint request
  Settings$HintPenalty <- list(
    
    Hint = 30,
    Extrahint = 120
    
  )
  
  
  
  ## Custom messages and help commands - change these functions to add additional messages/help commands
  Settings$MessageConstants <- fLoadMessageConstants(Settings)  # Simple command ==> message response. Doesn't require logic
  Settings$HelpCommands <- fHelpCommand(Settings)  # Message returned when help <<command>> is run
  
  
  
  ## Abort passcode
  Settings$AbortPasscode <- "ABCDE"  # Set to whatever the code to 'win' is
  
  
  
  
  
  # Permanent settings - these shouldn't be adjusted unless you are confident of the downstream effects -----
  ## Period object is parsed oddly by reactiveValues, converting to seconds count to bypass
  Settings$TotalTimerSecs <- Settings$TotalTimer %/% lubridate::seconds(1)
  
  
  
  return(Settings)
  
}
