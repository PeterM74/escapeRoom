#' Fallback method if specific module handler doesn't exist
#' @param pCommandObject Commands entered into the terminal
#' @param session Shiny session to use
#' @param Settings Settings object
#' @param ... Unused parameters
#' @return No object returned. Sends message response to the terminal.
fHandleModule.default <- function(pCommandObject, session, Settings, ...) {

  shiny::observe({
    
    ModuleCode <- CommandObject$args[[1]]
    
    # Check if module exists
    if (ModuleCode %in% names(Settings$Modules)) {  # It exists!
      
      # Check if command is greater than just module _CODE_
      if (length(CommandObject$args) >= 2) {
        
        # Parse module code
        SpecificModule <- Settings$Modules[[ModuleCode]]
        ModuleVerb <- tolower(CommandObject$args[[2]])
        
        # Action verb on the module
        if (ModuleVerb == "print") {
          
          Message <- SpecificModule$Print
          
        } else if (ModuleVerb == "hint") {
          
          Message <- SpecificModule$Hint
          Penalty(isolate(Penalty()) + Settings$HintPenalty$Hint)
          
        } else if (ModuleVerb == "extrahint") {
          
          Message <- SpecificModule$Extrahint
          Penalty(isolate(Penalty()) + Settings$HintPenalty$Extrahint)
          
        } else if (ModuleVerb == "submit") {
          
          # Check that module answer submitted
          if (length(CommandObject$args) >= 3) {
            
            if (CommandObject$args[[3]] == SpecificModule$Submit) {
              
              Message <- SpecificModule$Success
              
            } else {
              
              Message <- SpecificModule$Failure
              
            }
            
          } else {
            
            Message <- "Please submit the module passcode as the final argument."
            
          }
          
          
        } else {
          
          Message <- paste("Argument", htmltools::htmlEscape(ModuleVerb), "not recognised. Type <help module> for more info.")
          
        }

      } else {
        
        Message <- paste("Please specify what you want to do with Module", 
                         htmltools::htmlEscape(ModuleCode))
        
      }
      
    } else {
      
      Message <- paste("Module code", 
                       htmltools::htmlEscape(ModuleCode), 
                       "is not recognised.")
      
    }
    
    session$sendCustomMessage("EchoResponse", 
                              Message)
    
  }, env = parent.frame(n = 2), domain = session)
  
}
