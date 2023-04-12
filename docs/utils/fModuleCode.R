fModuleCode <- function(ModuleCode) {
  
  htmltools::div(
    
    class = "ModuleCodeBox",
    htmltools::span("Module code",
                    style = "font-size: 0.7rem; text-decoration: underline;"),
    htmltools::br(),
    htmltools::span(ModuleCode,
                    style = "font-size: 2rem;")
    
  )
  
}
