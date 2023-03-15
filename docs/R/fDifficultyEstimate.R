#' Builds a difficulty estimate bar
#' Useful to give participants an idea of how difficulty the activity is so they 
#' can triage the activities (e.g. give an easier problem to a more junior team member 
#' or assign fewer team members to activity).
#' @param Rating Proportion of difficult from 0-100.
#' @param LowerGradient Hexcode colour of lower end of gradient. Default green.
#' @param UpperGradient Hexcode colour of higher end of gradient. Default red.
#' @param Font Font family to use. Currently only available for Windows. TODO: add extrafont support.
#' @param Label Text to appear above difficulty bar.
#' @return Grob of difficulty bar.
fDifficultyEstimate <- function(Rating,
                                LowerGradient = "#30BC85",
                                UpperGradient = "#DA2426",
                                Font = "Helvetica",
                                Label = "Difficulty estimate") {
  
  # Validate variables received
  if (!dplyr::between(Rating, 0, 1)) {
    
    stop("fDifficultyEstimate rating must be a numeric value between 0-1 inclusive.")
    
  }
  
  # Create colour gradient
  ColGradient <- scales::gradient_n_pal(c(LowerGradient, UpperGradient))
  
  
  # Create bar grob
  BarGrob <- grid::roundrectGrob(y = grid::unit(0.28, "npc"),
                                 height = grid::unit(0.5, "npc"),
                                 width = grid::unit(0.95, "npc"),
                                 r = grid::unit(0.5, "snpc"),
                                 name = "DifficultyBar",
                                 gp = grid::gpar(
                                   fill = grid::linearGradient(
                                     colours = c(LowerGradient, ColGradient(Rating)),
                                     stops = c(0, Rating),
                                     y1 = grid::unit(0.5, "npc"),
                                     y2 = grid::unit(0.5, "npc"),
                                     extend = "none"
                                   ),
                                   colour = "black",
                                   lwd = 5
                                 ))
  
  
  # Create text grob
  if (.Platform$OS.type == "windows") {
    
    windowsFonts(LabelFont = Font)
    
  }
  
  TextGrob <- grid::textGrob(Label,
                             y = grid::unit(0.6, "npc"),
                             vjust = 0,
                             name = "DBLabel",
                             gp = grid::gpar(fontsize = 15,
                                             fontfamily = if (.Platform$OS.type == "windows") "LabelFont" else NULL,
                                             col = "black"))
  
  
  # Combine together
  GrobList <- grid::gList(BarGrob, TextGrob)
  
  
  return(GrobList)
  
}
