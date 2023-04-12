library(grid)
library(magick)


# Build arrow head
TextXStart <- 0.2
TextYStart <- 0.62
Arrow <- grid::segmentsGrob(x0 = grid::unit(c(TextXStart - 0.05, 
                                              TextXStart - 0.05), "npc"),
                            x1 = grid::unit(c(TextXStart - 0.02, 
                                              TextXStart - 0.02), "npc"),
                            y0 = grid::unit(c(TextYStart - 0.02, 
                                              TextYStart + 0.02), "npc"),
                            y1 = grid::unit(c(TextYStart, TextYStart), "npc"),
                            name = "ArrowGrob",
                            gp = grid::gpar(col = "#00FF41",
                                            lwd = 1.5))

# escapeRoom text
Text <- grid::textGrob(label = "escapeRoom", hjust = 0, name = "TextGrob",
                       x = grid::unit(TextXStart, "npc"),
                       y = grid::unit(TextYStart, "npc"),
                       gp = grid::gpar(col = "#00FF41",
                                       fontsize = 14))

# Flashing rectangle
Rectangle <- grid::rectGrob(x = grid::unit(0.805, "npc"),
                            y = grid::unit(TextYStart, "npc"),
                            width = grid::unit(0.04, "npc"),
                            height = grid::unit(14, "points"),
                            name = "FlashingGrob",
                            gp = grid::gpar(col = "#00FF41",
                                            fill = "#00FF41",
                                            lwd = 0))

# Base hexagon
## https://qph.cf2.quoracdn.net/main-qimg-ed5f07e328dbe69b3ce0084af1d406e3-lq
Hexagon <- grid::polygonGrob(y = c(0, 0.25, 0.75, 1, 0.75, 0.25)*0.95+0.025,
                             x = c(0.5, 0.935, 0.935, 0.5, 0.065, 0.065)*0.95+0.025,
                             name = "HexGrob",
                             gp = grid::gpar(col = '#00FF41',
                                             lwd = 7,
                                             fill = "#031e11"))


# Draw output
ERGrob <- gList(Hexagon, Arrow, Text)
Filenames <- c("escapeRoomHex1.png", "escapeRoomHex2.png")

ggplot2::ggsave(filename = Filenames[1], 
                plot = ERGrob, 
                width = 5,
                height = 5,
                units = "cm",
                dpi = 320,
                bg = "transparent")

ERGrob2 <- gList(Hexagon, Arrow, Text, Rectangle)

ggplot2::ggsave(filename = Filenames[2], 
                plot = ERGrob2, 
                width = 5,
                height = 5,
                units = "cm",
                dpi = 320,
                bg = "transparent")

Images <- purrr::map(Filenames,
                     magick::image_read)

Images <- magick::image_join(Images)

Animation <- magick::image_animate(Images, delay = 100, optimize = TRUE)

magick::image_write(Animation, path = "escapeRoomHexsticker.gif",
                    quality = 100)

unlink(Filenames)
