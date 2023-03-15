fSkillsRequired <- function(SkillsVector) {
  
  htmltools::div(
    
    class = "SkillsBox",
    htmltools::span("Skills required",
                    style = "color: #000000; text-decoration: underline;"),
    htmltools::br(),
    purrr::map(SkillsVector, 
               function(x, LastElement) {
                 
                 htmltools::tagList(
                   x, 
                   if (LastElement == x) NULL else htmltools::br()
                 )
                 
               }, 
               LastElement = dplyr::last(SkillsVector))
    
  )
  
}
