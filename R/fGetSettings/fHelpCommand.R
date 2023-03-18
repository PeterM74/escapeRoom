#' Help messages received when help command is run
#' When adding a new command, always add to `SpecificCommandHelpers` and add to `GenericHelpResponse`
#' when the user should be aware of it's existence.
#' @param Settings Named list of Settings.
#' @return Named vector of input => output
fHelpCommand <- function(Settings) {
  
  # When help is run by itself - generates a list of publicly-listed commands -----
  ## When adding a new command, if the user should be aware of it's existance, it must be included below
  ## The sep parameter of paste is to ensure the output aligns correctly, ensure the empty space is repeated by 24 - StringLength
  GenericHelpResponse <- paste0("\n", Settings$BBEGName, "'s personal assistant v2.3.1.\n\nList of public commands:\n\n",
                                
                                paste("abort", "Abort the countdown sequence\n",
                                      sep = paste0(rep(" ", 24-5), collapse = "")),
                                paste("clear", "Clear console\n",
                                      sep = paste0(rep(" ", 24-5), collapse = "")),
                                paste("deploy", "Initiate countdown sequence to disbursement\n",
                                      sep = paste0(rep(" ", 24-6), collapse = "")),
                                paste("help", "List public commands. Call specific command as argument for further info\n",
                                      sep = paste0(rep(" ", 24-4), collapse = "")),
                                paste("module", "Interact with this terminal's modules\n",
                                      sep = paste0(rep(" ", 24-6), collapse = "")),
                                paste("schematics", "Print the vessel disbursement vessel schematics\n",
                                      sep = paste0(rep(" ", 24-10), collapse = "")),
                                paste("timer", "Display time left on vessel\n",
                                      sep = paste0(rep(" ", 24-5), collapse = "")),
                                paste("<<Up/Down>>", "Keys to scroll through history\n",
                                      sep = paste0(rep(" ", 24-11), collapse = "")),
                                
                                "\n\nRun help <command> for further information. Additional private commands unlisted.\n")
  
  
  # What is run when 'help <<name>>' is called -----
  ## When adding a new command, you should include it in the list below in case the user wants more info on it's use
  SpecificCommandHelpers <- c("abort" = paste("Aborts the countdown for the vessel disbursement.", 
                                              "Requires a nine-character passcode."),  # TODO: update number based on module count
                              "deploy" = "Initiates countdown sequence. No options.",
                              "help" = "Well now you are just being silly.",
                              "hello" = "??? It's just hello",
                              "module" = paste0("Run module of terminal that controls various things in the world.\n",
                                                "First argument specifies module code - 3 character code.\n",
                                                "Second arg is verb - specifies what to do with module. Options:\n",
                                                "  - submit: submit information to module. Third arg must be answer\n",
                                                "  - hint: request simple hint. -", Settings$HintPenalty$Hint, "s from timer\n",
                                                "  - extrahint: request complex hint. -", Settings$HintPenalty$Extrahint, "s from timer\n",
                                                "  - print: print module specifications\n\n"),
                              "name" = "...It's my name...",
                              "schematics" = "Prints schematics for the disbursement vessel. Handy!",
                              "timer" = "Displays time left in HH:MM:SS format")
    
    
  return(c(GenericHelpResponse, SpecificCommandHelpers))
  
}
