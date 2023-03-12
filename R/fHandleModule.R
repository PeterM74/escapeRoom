#' Generic method to handle module interactivity
#' @param pCommandObject Commands entered into the terminal
#' @param ... Additional parameters to pass to methods, usually session and Settings
#' @return No object returned. Methods usually sends message response to the terminal
fHandleModule <- function(pCommandObject, ...) {
  
  UseMethod("fHandleModule")
  
}
