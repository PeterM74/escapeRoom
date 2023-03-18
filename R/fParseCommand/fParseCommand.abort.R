#' Applies logic for abort command
#' Command used to abort the vessel.
#' @param pCommandObject Commands entered into the terminal
#' @param session Shiny session to use
#' @param Settings Settings object
#' @param ... Unused parameters
#' @return No object returned. Sends message response to the terminal with abort result.
fParseCommand.abort <- function(pCommandObject, session, Settings, ...) {
  
  # If no additional argument, return request for abort code
  if (pCommandObject$rest == "") {
    
    Message <- "Please input the abort passcode after the command."
    
    # If a command is entered after help and is listed in the settings, output help description
  } else if (pCommandObject$rest == Settings$AbortPasscode) {
    
    shinyjs::hide("topLDBar")
    Message <- "Vessel countdown condition aborted."
    
    observe({
      
      CountdownStatus(FALSE)
      # TODO: add win animation
      
    }, env = parent.frame(n = 1), domain = session)
    
  } else {
    
    Message <- "Incorrect abort passcode."
    
  }
  
  session$sendCustomMessage("EchoResponse", Message)
  
}
