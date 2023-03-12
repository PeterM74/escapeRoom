#' Simple message constants
#' Add messages here that don't require any processing and always return the same output. 
#' @param Settings Named list of Settings.
#' @return Named vector of input => output
fLoadMessageConstants <- function(Settings) {
  
  # Input must be in lowercase
  c("defuse" = "Mmmm, no.",
    "hello" = "Hello. How may I help you?",
    "hint" = "Did you want me to help you?",
    "name" = "My name is 010101000110100001100101010010000110010101101100011100000110010101110010.",
    "terminate" = "Well that's not very nice.",
    "pause" = "Haha, no.",
    "schematics" = paste0("Printing disbursement vessel schematics now. Please collect from ", Settings$BBEGName, "."),
    "stop" = "Nah.",
    "exit" = "No, thank you."
  )
  
}
