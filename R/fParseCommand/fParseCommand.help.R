#' Applies logic for help command
#' @param pCommandObject Commands entered into the terminal
#' @param session Shiny session to use
#' @param Settings Settings object
#' @param ... Unused parameters
#' @return No object returned. Sends message response to the terminal for help information.
fParseCommand.help <- function(pCommandObject, session, Settings, ...) {
  
  # If no additional argument, return generic help listing
  if (pCommandObject$rest == "") {
    
    Message <- dplyr::first(Settings$HelpCommands)
    
    # If a command is entered after help and is listed in the settings, output help description
  } else if (tolower(pCommandObject$args[[1]]) %in% names(Settings$HelpCommands)) {
    
    Message <- Settings$HelpCommands[[tolower(pCommandObject$args[[1]])]]
    
  } else {
    
    Message <- paste("Help for", 
                     htmltools::htmlEscape(tolower(pCommandObject$args[[1]])), 
                     "not available.")
    
  }
  
  session$sendCustomMessage("EchoResponse", Message)
  
}
