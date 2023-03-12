#' Applies logic for timer command
#' @param pCommandObject Commands entered into the terminal
#' @param session Shiny session to use
#' @param Settings Settings object
#' @param ... Unused parameters
#' @return No object returned. Sends message response to the terminal of time left.
fParseCommand.timer <- function(pCommandObject, session, ...) {
  
  observe({
    
    TimeLeftInSeconds <- (Settings$TotalTimerSecs -
                            (lubridate::interval(isolate(TimerStart()), Sys.time()) %/%
                               lubridate::seconds(1)) -
                            lubridate::seconds(isolate(Penalty())))
    
    Message <- paste0(formatC(TimeLeftInSeconds %/% lubridate::hours(1), width = 2, flag = "0"), ":",
                      formatC((TimeLeftInSeconds %/% lubridate::minutes(1)) %% 60, width = 2, flag = "0"), ":",
                      formatC((TimeLeftInSeconds %/% lubridate::seconds(1)) %% 60, width = 2, flag = "0"),
                      " left")
    
    session$sendCustomMessage("EchoResponse", Message)
    
  }, env = parent.frame(n = 1), domain = session)
  
}
