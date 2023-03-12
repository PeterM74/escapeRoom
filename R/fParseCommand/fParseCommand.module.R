#' Applies logic for module command
#' For interacting with the individual modules required to abort the vessel countdown.
#' @param pCommandObject Commands entered into the terminal
#' @param session Shiny session to use
#' @param Settings Settings object
#' @param ... Unused parameters
#' @return No object returned. Sends message response to the terminal of relevant
#' component of module.
fParseCommand.module <- function(pCommandObject, session, Settings, ...) {
  
    
  # Check that module has not been entered without a code
  if (pCommandObject$rest == "") {
    
    Message <- "Please specify a module code that you would like to interact with."
    session$sendCustomMessage("EchoResponse", Message)
    
  } else {
    
    ModuleCode <- pCommandObject$args[[1]]
    class(pCommandObject) <- c(make.names(ModuleCode), class(pCommandObject))
    
    fHandleModule(pCommandObject, session = session, Settings = Settings)
    
    # if (ModuleCode %in% names(TBD)) {
    # 
    #   
    #   
    #   # Module code not registered in list
    # } else {
    #   
    #   Message <- paste("Module code", ModuleCode, "is not recognised.")
    #   
    # }
    # 
  }
  
}
