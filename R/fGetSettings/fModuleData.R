#' List of modules and their data
#' This list stores the module activities required to disarm the vessel. Ensure the modules listed here
#' reflect what is in the R/fHandleModule/ folder (create new methods for new modules and delete ones you remove).
#' @details This function should be a named list, where the name is the module code and the element is 
#' another list with 6 named elements: Print, Hint, Extrahint, Submit, Success, and Failure.
#' * Print When the participants uses the print command for the module, this is what is output to the terminal.
#' * Hint When the participants request a simple hint, this is output.
#' * Extrahint When the participants request an additional hint, this is output.
#' * Submit This is the correct answer for the activity.
#' * Success When the correct answer is input, this is output.
#' * Failure When an incorect answer is input, this is output.
#' @param Settings Named list of Settings.
#' @return Named list of modules, with each element being it's own list with 6 elements.
fModuleData <- function(Settings) {
  
  list(
    
    '3MZ' = list(Print = .PrintModuleMessage("3MZ", Settings),
                 Hint = paste("It is not possible to brute force the answer, even if you", 
                              "parallel process the question across everyone’s computer.",
                              "There are 2^99 paths, and if you could check one trillion", 
                              "routes every second it would take over 20 billion years to", 
                              "calculate them all. There must be a better way!"),
                 Extrahint = "Perhaps you are looking at this problem from the wrong angle? ;)",
                 Submit = "7273",
                 Success = "Correct! Module unlocked. Key: W.",
                 Failure = "Incorrect, module remains locked."), 
    '6FD' = list(Print = .PrintModuleMessage("6FD", Settings),
                 Hint = paste("Seemingly complex problems can often be broken down into simpler concepts.",
                              "What do you notice in common with the ‘blocked’ trees…"),
                 Extrahint = paste("Ask", Settings$BBEGName, "for assistance. Repeatable."),
                 Submit = "117645084",
                 Success = "Correct! Module unlocked. Key: I.",
                 Failure = "Incorrect, module remains locked."),
    'NSC' = list(Print = .PrintModuleMessage("NSC", Settings),
                 Hint = paste("Break the problem down into simple steps. It is ok to Google how", 
                              "to do each step (e.g. read a text file in R, break a word into a", 
                              "string of characters etc.)."),
                 Extrahint = paste("Here’s one way to solve: read into list -> convert list to", 
                                   "character vector, remove quotes and sort -> split each word", 
                                   "into a vector/list of single characters -> match those characters", 
                                   "to their positions (hint: LETTERS is a pre-built vector of letters)", 
                                   "-> sum the positions -> multiple the sum against the position of", 
                                   "the name in the vector -> filter to find the value that matches", 
                                   "and read the name."),
                 Submit = "DOMINGO",
                 Success = "Correct! Module unlocked. Key: N.",
                 Failure = "Incorrect, module remains locked."),
    'PDC' = list(Print = .PrintModuleMessage("PDC", Settings),
                 Hint = paste("The shortest possible secret passcode must necessarily never", 
                              "duplicate the same character since there's no duplicates in the log."),
                 Extrahint = paste("While you can develop a script to decode the answer,", 
                                   "manually investigating is acceptable. If you don’t know", 
                                   "where to start, maybe try figuring out the ends first.", 
                                   "Visualisation is a good start!"),
                 Submit = "73162890",
                 Success = "Correct! Module unlocked. Key: N.",
                 Failure = "Incorrect, module remains locked."),
    'PKR' = list(Print = .PrintModuleMessage("PKR", Settings),
                 Hint = paste("Functional programming principles are important to this problem.", 
                              "Finding one solution with a function will assist you with another.", 
                              "They’re all related!"),
                 Extrahint = paste("Ask", Settings$BBEGName, "for assistance. Repeatable."),
                 Submit = "376",
                 Success = "Correct! Module unlocked. Key: E.",
                 Failure = "Incorrect, module remains locked."),
    'SSS' = list(Print = .PrintModuleMessage("SSS", Settings),
                 Hint = paste("Don’t play the game like you would, play the simplest algorithm.", 
                              "There is no benefit for snake movement optimisation.", 
                              "Look for the edge cases with new fruit location compared to snake location."),
                 Extrahint = paste("Keep snake movement consistent. There is no need to refer to", 
                                   "the full snake’s position except for the head if you think of", 
                                   "a consistent algorithmic approach. How can you keep the snake’s", 
                                   "body away from where you need to go?"),
                 Submit = "THEREISNOANSWERTOBESUBMITTED",
                 Success = "THEREISNOANSWERTOBESUBMITTED",
                 Failure = "Answer must be submitted to the API.")
    
    )
  
}

.PrintModuleMessage <- function(ModCode, Settings) paste("Printing module", ModCode, "now. Collect from", Settings$BBEGName)