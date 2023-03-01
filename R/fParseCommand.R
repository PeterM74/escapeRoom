#' Generic method to parse and apply logic to terminal commands from user
#' @param pCommandObject Commands entered into the terminal
#' @param session Shiny session to use
#' @param Settings Settings object
#' @param ... Additional parameters to pass to methods
#' @return No object returned. Methods usually sends message response to the terminal
fParseCommand <- function(pCommandObject, ...) {
  
  UseMethod("fParseCommand")
  
}
