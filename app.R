library(shiny)
library(shinyjs)
library(tidyverse)
library(lubridate)

options(shiny.autoload.r = TRUE)
purrr::map(list.files(path = "./R/", pattern = ".R$", recursive = TRUE, full.names = TRUE),
           source) %>%
  invisible()

# Load options
Settings <- fGetSettings()
MessageConstants <- fLoadMessageConstants(Settings)
HelpCommands <- fHelpCommand(Settings)



PrintModuleMessage <- function(ModCode) paste("Printing module", ModCode, "now. Collect from Dr Malum.")
ModuleData <- list(
  
  '3MZ' = list(Print = PrintModuleMessage("3MZ"),
               Hint = paste("It is not possible to brute force the answer, even if you", 
                            "parallel process the question across everyone’s computer.",
                            "There are 2^99 paths, and if you could check one trillion", 
                            "routes every second it would take over 20 billion years to", 
                            "calculate them all. There must be a better way!"),
               Extrahint = "Perhaps you are looking at this problem from the wrong angle? ;)",
               Submit = "7273",
               Success = "Correct! Module unlocked. Key: S.",
               Failure = "Incorrect, module remains locked."), 
  '6FD' = list(Print = PrintModuleMessage("6FD"),
               Hint = paste("Seemingly complex problems can often be broken down into simpler concepts.",
                            "What do you notice in common with the ‘blocked’ trees…"),
               Extrahint = "Ask Dr Malum for assistance. Repeatable.",
               Submit = "117645084",
               Success = "Correct! Module unlocked. Key: T.",
               Failure = "Incorrect, module remains locked."),
  'ENC' = list(Print = PrintModuleMessage("ENC"),
               Hint = paste("There is a LETTERS object in R and the modulo operator is your friend."),
               Extrahint = "Ask Dr Malum for assistance. Repeatable.",
               Submit = "BREAKITOPEN",
               Success = "The passcode is the clue.",
               Failure = "Incorrect. Abort code is not solved."),
  'NSC' = list(Print = PrintModuleMessage("NSC"),
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
               Success = "Correct! Module unlocked. Key: A.",
               Failure = "Incorrect, module remains locked."),
  'PDC' = list(Print = PrintModuleMessage("PDC"),
               Hint = paste("The shortest possible secret passcode must necessarily never", 
                            "duplicate the same character."),
               Extrahint = paste("While you can develop a script to decode the answer,", 
                                 "manually investigating is acceptable. If you don’t know", 
                                 "where to start, maybe try figuring out the ends first.", 
                                 "Visualisation is a good start!"),
               Submit = "73162890",
               Success = "Correct! Module unlocked. Key: X.",
               Failure = "Incorrect, module remains locked."),
  'PKR' = list(Print = PrintModuleMessage("PKR"),
               Hint = paste("Functional programming principles are important to this problem.", 
                            "Finding one solution with a function will assist you with another.", 
                            "They’re all related!"),
               Extrahint = "Free help from Dr Malum. Repeatable.",
               Submit = "376",
               Success = "Correct! Module unlocked. Key: L.",
               Failure = "Incorrect, module remains locked."),
  'SPO' = list(Print = PrintModuleMessage("SPO"),
               Hint = "If you are not sure where to start, ask a colleague or Dr Malum what a .shp file is",
               Extrahint = paste("If you are unsure where to start with spatial data, perhaps a good idea", 
                                 "is to plot the data and then look at the contents of the file."),
               Submit = "IDE",
               Success = "Correct! Module unlocked. Key: F.",
               Failure = "Incorrect, module remains locked."),
  'SSS' = list(Print = PrintModuleMessage("SSS"),
               Hint = paste("Don’t play the game like you would, play the simplest algorithm.", 
                            "There is no benefit for snake movement optimisation.", 
                            "Look for the edge cases with new fruit location compared to snake location."),
               Extrahint = paste("Keep snake movement consistent. There is no need to refer to", 
                                 "the full snake’s position except for the head if you think of", 
                                 "a consistent algorithmic approach. How can you keep the snake’s", 
                                 "body away from where you need to go?"),
               Submit = "THEREISNOANSWERTOBESUBMITTED",
               Success = "Correct! Module unlocked. Key: J.",
               Failure = "Answer must be submitted to the API."),
  'TIM' = list(Print = PrintModuleMessage("TIM"),
               Hint = paste("Parameters can be passed directly in a query string for an API with", 
                            "the form: API_URL?Input=12345. The plumber documentation is excellent:", 
                            "https://www.rplumber.io/articles/routing-and-input.html."),
               Extrahint = "Ask Dr Malum for assistance. Repeatable.",
               Submit = "",  
               Success = paste("Timer integrity re-established.", 
                               "Time penalties no longer apply while API is active."),
               Failure = paste("Query to API unsuccessful. Timer will continue to accelerate.")),
  
  ''
  
)


# Define UI for application that draws a histogram
ui <- fillPage(

  title = "Dr Malum's Evil Plan",
  bootstrap = FALSE,
  shinyjs::useShinyjs(),
  
  # Header requirements
  ## Terminal from: https://terminal.jcubic.pl/
  ## TV effect from: https://codepen.io/jcubic/pen/BwBYOZ?editors=0100
  ## Shiny timer: https://stackoverflow.com/questions/49250167/how-to-create-a-countdown-timer-in-shiny
  tags$head(
    shiny::includeCSS("www/jquery.terminal.min.css"),
    shiny::includeCSS("www/TVclasses.css"),
    shiny::includeCSS("www/loading-bar.css"),
    tags$script(paste0("Shiny.addCustomMessageHandler('TimerProgress', function(TimerProg) {",
                       "var LDBar1 = document.getElementById('topLDBar').ldBar;",
                       "LDBar1.set(TimerProg);",
                       "});"))
  ),
  
  tags$div(class="tv",
           tags$div(id="terminal", style="--color: #00FF41; --animation: terminal-glow; --glow: 1; size = 1.5;"),
           tags$div(class="ldBar label-center", id="topLDBar",
                    `data-stroke`="data:ldbar/res,stripe(#003B00, #008F11, 2)",
                    `data-value`="100",
                    style="position: fixed; right: 2vw; top: 0.5vw; width: 30vw; height: 5vw; opacity: 0;"),
           tags$div(id="FailBox",
                    tags$span("MISSION ACCOMPLISHED", 
                              style = "color: #008F11; font-size: 3vw; text-shadow: 0 0 4px #00FF41;"),
                    tags$br(),
                    tags$span(paste("Vessel activated.",
                                    "Impact: 10,000 people with sniffles."), 
                              style = "color: #008F11; font-size: 1.5vw; text-shadow: 0 0 4px #00FF41;"),
                    style=paste0("border-style = solid; border-width: 20px; border-color: #008F11;",
                                 "width:40vw; height: 30vh; position: absolute; top: 35vh; left: 30vw;",
                                 "display: none")),
           tags$div(class="flicker"),
           tags$div(class="scanlines"),
           tags$div(class="noise"),
           shiny::includeScript("www/jquery.terminal.min.js"),
           shiny::includeScript("www/TVscript.js"),
           shiny::includeScript("www/loading-bar.js"))
  
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  # Timer countdown -----
  CountdownStatus <- reactiveVal(FALSE)
  TimerStart <- reactiveVal(Sys.time()) ## Will update itself once timer started
  Penalty <- reactiveVal(0)  # Penalty in seconds - it didn't like periods stored as RV?
  TimerIntegrityModule <- reactiveVal(FALSE)

  observe({

    if (CountdownStatus()) {

      TimeLeft <- ((Settings$TotalTimerSecs -
                      (lubridate::interval(isolate(TimerStart()), Sys.time()) %/%
                         lubridate::seconds(1)) -
                      lubridate::seconds(Penalty())) /
        Settings$TotalTimerSecs) * 100

      session$sendCustomMessage("TimerProgress", round(TimeLeft, 2))

      # Failure condition
      if (as.integer(TimeLeft) < 0) {
        
        print("Achieved")
        shinyjs::show("FailBox")
        shinyjs::hide("topLDBar")
        #shinyjs::runjs("document.getElementById('FailBox').style.display = block;")
        
      }
      
      invalidateLater(60000, session)  # Every minute, update timer

    }

  })
  
  # Time integrity module
  observe({

    if (!TimerIntegrityModule() & isolate(CountdownStatus())) {

      Penalty(isolate(Penalty()) + 60)  # TODO: revert back to minute

    }

    invalidateLater(600000, session)  # Every 10 minutes, increase penalty

  })
  
  # Main logic of terminal commands - all based off one input: TermInput -----
  observe({
    
    CommandObject <- input$TermInput
    
    if (!is.null(CommandObject)) {
      
      # print(CommandObject)
      CommandObject$name <- tolower(CommandObject$name)
      
      # /\/\/\/\/\/\/\ HELP /\/\/\/\/\/\/\
      if (CommandObject$name == "help") {
        # Help command invoked
        
        # Check for additional arguments
        if (CommandObject$rest == "") {
          
          Message <- HelpMessage
          
        } else if (tolower(CommandObject$args[[1]]) %in% names(HelpCommandSpecifics)) {
          
          Message <- HelpCommandSpecifics[[CommandObject$args[[1]]]]
          
        } else {
          
          Message <- paste("Help for", tolower(CommandObject$args[[1]]), "not available.")
          
        }
        
      
      # /\/\/\/\/\/\/\ DEPLOY /\/\/\/\/\/\/\
      }  else if (CommandObject$name == "deploy") {
        
        if (!isolate(CountdownStatus())) {
          
          CountdownStatus(TRUE)
          TimerStart(Sys.time())
          Message <- "Countdown initiated."
          shinyjs::runjs("document.getElementById('topLDBar').style.opacity = 1;")
          
        } else {
          # Already started!
          Message <- "Countdown has already started! Perhaps there is a way to stop it..."
          
        }

        # /\/\/\/\/\/\/\ TIMER /\/\/\/\/\/\/\
      } else if (CommandObject$name == "timer") {
        
        TimeLeftInSeconds <- (Settings$TotalTimerSecs -
                                (lubridate::interval(isolate(TimerStart()), Sys.time()) %/%
                                   lubridate::seconds(1)) -
                                lubridate::seconds(isolate(Penalty())))
        
        Message <- paste0(formatC(TimeLeftInSeconds %/% lubridate::hours(1), width = 2, flag = "0"), ":",
                          formatC((TimeLeftInSeconds %/% lubridate::minutes(1)) %% 60, width = 2, flag = "0"), ":",
                          formatC((TimeLeftInSeconds %/% lubridate::seconds(1)) %% 60, width = 2, flag = "0"),
                          " left")
      
      # /\/\/\/\/\/\/\ ABORT /\/\/\/\/\/\/\  
      } else if (CommandObject$name == "abort") {
        
        if (CommandObject$rest == "") {
          
          Message <- "Please input the abort passcode after the command."
          
        } else if (CommandObject$rest == "TEAMRIWIN") {
          
          # TODO: WIN CONDITION
          # shinyjs::runjs("document.getElementById('topLDBar').style.opacity = 1;")
          shinyjs::hide("topLDBar")
          Message <- "Vessel countdown condition aborted."
          CountdownStatus(FALSE)
          
        } else {
          
          Message <- "Incorrect abort passcode."
          
        }
        
      # /\/\/\/\/\/\/\ MODULE /\/\/\/\/\/\/\  
      } else if (CommandObject$name == "module") {
        
        if (CommandObject$rest == "") {
          
          Message <- "Please specify a module code that you would like to interact with."
          
        } else {
          
          ModuleCode <- CommandObject$args[[1]]
          
          if (ModuleCode %in% names(ModuleData)) {
            
            if (length(CommandObject$args) < 2) {
              
              # Check to make sure string isn't empty
              Message <- paste("Please specify what you want to do with Module", ModuleCode)
              
            } else {
              
              # Parse module code
              SpecificModule <- ModuleData[[ModuleCode]]
              ModuleVerb <- tolower(CommandObject$args[[2]])
              if (ModuleVerb == "print") {
                
                Message <- SpecificModule$Print
                
              } else if (ModuleVerb == "hint") {
                
                Message <- SpecificModule$Hint
                Penalty(isolate(Penalty()) + 30)
                
              } else if (ModuleVerb == "extrahint") {
                
                Message <- SpecificModule$Extrahint
                Penalty(isolate(Penalty()) + 120)
                
              } else if (ModuleVerb == "submit") {
                
                # Run special module code
                if (ModuleCode == "TIM") {
                  
                  if (length(CommandObject$args) < 3) {
                    
                    Message <- "Please submit the API URL as the final argument."
                    
                  } else {
                    
                    ProposedURL <- paste0(CommandObject$args[[3]], "?Input=655937")
                    
                    Response <- tryCatch({httr::GET(ProposedURL)},
                                         error = function(cond) {return(FALSE)})
                    
                    if (!httr:::is.response(Response)) {
                      
                      Message <- "Connection could not be made to URL. Check input."
                      
                    } else if (httr::content(Response, type = "text") == "79" & 
                               httr::status_code(Response) == 200) {
                      
                      Message <- SpecificModule$Success
                      TimerIntegrityModule(TRUE)
                      
                    } else if (httr::status_code(Response) == 200) {
                      
                      Message <- paste("Incorrect response received.", 
                                       SpecificModule$Failure)
                      
                    } else {
                      
                      Message <- paste("Error code received on API request:",
                                       httr::status_code(Response)[1],
                                       ".", SpecificModule$Failure)
                      
                    }
                    
                  }
                  
                  # Other module submitted - check answer
                } else {
                  
                  if (length(CommandObject$args) < 3) {
                    
                    Message <- "Please submit the module passcode as the final argument."
                    
                  } else {
                    
                    Answer <- CommandObject$args[[3]]
                    
                    if (Answer == SpecificModule$Submit) {
                      
                      Message <- SpecificModule$Success
                      
                    } else {
                      
                      Message <- SpecificModule$Failure
                      
                    }
                    
                  }
                  
                  
                }
                
                
                
              } else {
                
                Message <- paste("Argument", ModuleVerb, "not recognised. Type <help module> for more info.")
                
              }
              
            }
            
            # Incorrect module code entered
          } else {
            
            Message <- paste("Module code", ModuleCode, "is not recognised.")
            
          }
          
        }
        
      } else if (CommandObject$name %in% names(MessageConstants)) {
        
        Message <- MessageConstants[[CommandObject$name]]
        
      } else {
        
        Message <- "ERROR Unknown command"
        
      }
      
      session$sendCustomMessage("EchoResponse", Message)
      
    }

  })
    
}

# Run the application 
shinyApp(ui = ui, server = server, options = list(launch.browser = FALSE))
