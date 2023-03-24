#' Fallback method if specific command not registered with fParseCommand generic
#' Checks if command is in `Settings$MessageConstants`. If yes, it returns the 
#' desired response, otherwise it throws an error command to the user.
#' @param pCommandObject Commands entered into the terminal
#' @param session Shiny session to use
#' @param Settings Settings object
#' @param ... Unused parameters
#' @return No object returned. Sends message response to the terminal.
fParseCommand.default <- function(pCommandObject, session, Settings, ...) {
  
  if (pCommandObject$name %in% names(Settings$MessageConstants)) {
    
    Message <- Settings$MessageConstants[[pCommandObject$name]]
    
  } else {
    
    Message <- "ERROR Unknown command"
    
  }
  
  session$sendCustomMessage("EchoResponse", Message)
  
}
