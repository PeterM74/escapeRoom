#' Fallback method if module code doesn't exist
#' @param pCommandObject Commands entered into the terminal
#' @param session Shiny session to use
#' @param Settings Settings object
#' @param ... Unused parameters
#' @return No object returned. Sends message response to the terminal.
fHandleModule.default <- function(pCommandObject, session, Settings, ...) {

  ModuleCode <- pCommandObject$args[[1]]
  session$sendCustomMessage("EchoResponse", paste("Module code", 
                                                  htmltools::htmlEscape(ModuleCode), 
                                                  "is not recognised."))
  
}
