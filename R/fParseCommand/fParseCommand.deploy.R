fParseCommand.deploy <- function(pCommandObject, session, ...) {
  
  # Initiate reactive values to begin countdown
  observe({
    
    CountdownStatus(TRUE)
    TimerStart(Sys.time())
    
  }, env = parent.frame(n = 1), domain = session)

  # Send message and activate timer
  session$sendCustomMessage("EchoResponse", "Countdown initiated.")
  shinyjs::runjs("document.getElementById('topLDBar').style.opacity = 1;")
  
}
