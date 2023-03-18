#' Example code for custom module
#' The fHandleModule has been designed this way so the default method will handle 
#' the default logic for modules provided you have filled out the fModuleData() function. If 
#' you want a particular module to have unique actions (e.g. flash screen red on failed submit, 
#' query an API etc), it must be done with this, replacing the default in the method name to the 
#' module code. This will run override the default logic for modules for this particular module.
#' @param pCommandObject Commands entered into the terminal
#' @param session Shiny session to use
#' @param Settings Settings object
#' @param ... Unused parameters
#' @return No object returned. Sends message response to the terminal.
fHandleModule.default <- function(pCommandObject, session, Settings, ...) {
  
  shiny::observe({
    
    ModuleCode <- CommandObject$args[[1]]
    
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
        # EXAMPLE: Maybe you want an image to appear in the corner if they ask for a hint, do that here!
        
      } else if (ModuleVerb == "extrahint") {
        
        Message <- SpecificModule$Extrahint
        Penalty(isolate(Penalty()) + Settings$HintPenalty$Extrahint)
        
      } else if (ModuleVerb == "submit") {
        
        # Check that module answer submitted
        if (length(CommandObject$args) >= 3) {
          
          # EXAMPLE: maybe you need to query an API, replace the if statement below!
          if (CommandObject$args[[3]] == SpecificModule$Submit) {
            
            Message <- SpecificModule$Success
            
          } else {
            
            Message <- SpecificModule$Failure
            # EXAMPLE: Maybe you want the screen to flash red when they fail because this is an important module?
            # Do that here!
            
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
    
    session$sendCustomMessage("EchoResponse", 
                              Message)
    
  }, env = parent.frame(n = 2), domain = session)
  
}
