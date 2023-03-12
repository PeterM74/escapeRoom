#' Applies logic for deploy command
#' @param pCommandObject Commands entered into the terminal
#' @param session Shiny session to use
#' @param Settings Settings object
#' @param ... Unused parameters
#' @return No object returned. Sends message response to the terminal to initiate deployment.
fParseCommand.deploy <- function(pCommandObject, session, Settings, ...) {
  
  # Initiate reactive values to begin countdown
  observe({
    
    if (!isolate(CountdownStatus())) {
      
      CountdownStatus(TRUE)
      TimerStart(Sys.time())
      shinyjs::runjs("document.getElementById('topLDBar').style.opacity = 1;")
      Message <- "Countdown initiated."
      
    } else {
      
      Message <- "Countdown has already started! Perhaps there is a way to stop it..."
      
    }
      
    session$sendCustomMessage("EchoResponse", Message)
    
  }, env = parent.frame(n = 1), domain = session)

  
  
  
}
