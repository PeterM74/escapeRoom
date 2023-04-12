library(shiny)
library(shinyjs)
library(tidyverse)

purrr::map(list.files(path = "./R/", pattern = ".R$", recursive = TRUE, full.names = TRUE),
           source) %>%
  invisible()

# Load options
Settings <- fGetSettings()



# Define UI for terminal screen
ui <- fillPage(

  title = paste0(Settings$BBEGName, "'s Evil Plan"),
  bootstrap = FALSE,
  shinyjs::useShinyjs(),
  
  # Header requirements
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", 
              href = "https://cdnjs.cloudflare.com/ajax/libs/jquery.terminal/2.35.3/css/jquery.terminal.min.css"),
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
                    tags$span(paste("Vessel activated."), 
                              style = "color: #008F11; font-size: 1.5vw; text-shadow: 0 0 4px #00FF41;"),
                    style=paste0("border-style = solid; border-width: 20px; border-color: #008F11;",
                                 "width:40vw; height: 30vh; position: absolute; top: 35vh; left: 30vw;",
                                 "display: none")),
           tags$div(class="flicker"),
           tags$div(class="scanlines"),
           tags$div(class="noise"),
           htmltools::tags$script(src = "https://cdnjs.cloudflare.com/ajax/libs/jquery.terminal/2.35.3/js/jquery.terminal.min.js"),
           shiny::includeScript("www/loading-bar.js"),
           shiny::includeScript("www/TVscript.js"))
  
)



# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  # Timer countdown -----
  CountdownStatus <- reactiveVal(FALSE)
  TimerStart <- reactiveVal(Sys.time()) ## Will update itself once timer started
  Penalty <- reactiveVal(0)  # Penalty in seconds - it didn't like periods stored as RV?

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

      }
      
      invalidateLater(1000, session)  # Every 10s, update timer

    }

  })
  
  # Main logic of terminal commands - all based off one input: TermInput -----
  observe({
    
    CommandObject <- input$TermInput
    
    if (!is.null(CommandObject)) {
      
      CommandObject$name <- tolower(CommandObject$name)
      class(CommandObject) <- c(make.names(CommandObject$name), class(CommandObject))
      
      fParseCommand(CommandObject, session = session, Settings = Settings)

    }
    
  })
    
}



# Run the application 
shinyApp(ui = ui, server = server, options = list(launch.browser = FALSE))
