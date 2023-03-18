# Starting variables
BoardDimensions <- c(10, 20)  # x, y
StartingPositionSnake <- list(c(5, 10),
                              c(4, 10),
                              c(3, 10),
                              c(2, 10),
                              c(1, 10))
PointTotalGoal <- 50



#' Snake game logic
#' Run this function to test your algorithm - you don't need to read it. Just trust it works!
#' @param BoardDimensions Dimensions of the game board (x, y).
#' @param StartingPosition Starting snake position.
#' @param SnakeLogicAlgorithm Your function that runs the logic of the snake movement. Ensure you 
#' reference it as a symbol (e.g. "SnakeAlgorithm") and not as a function ("SnakeAlgorithm()").
#' @param PointGoal Leave as 50 unless you want to go higher to test your algorithm for fun
#' @param DebugMode This allows you to visualise the gameboard at every step so you can see how
#' your algorithm behaves if set to TRUE. However when you want to test the algorithm over many 
#' games, set to FALSE as TRUE has a much slower run time to allow you to see each step.
#' @return TRUE/FALSE. TRUE means you reached the 50 point score, FALSE means the snake failed.
fRunSnake <- function(BoardDimensions, StartingPosition, SnakeLogicAlgorithm,
                      PointGoal = 50, DebugMode = FALSE) {
  
  # Initialise starting variables
  FruitPosition <- c(sample(seq_len(BoardDimensions[1]),
                            size = 1),
                     sample(seq_len(BoardDimensions[2]),
                            size = 1))
  PointScore <- 0
  SnakePosition <- StartingPosition
  FailureStatus <- FALSE
  
  # Loop through turns until point score reached or snake fails
  while (PointScore < PointGoal & !FailureStatus) {
    
    Direction <- SnakeLogicAlgorithm(FruitPosition, SnakePosition)
    
    # Check input of direction
    .fValidateDirectionInput(Direction)
    
    # Apply new position to snake
    SnakePosition <- .fCalcNewSnakePosition(Direction, SnakePosition)
    
    # Assess whether fruit captured
    FruitCaptured <- all(SnakePosition[[1]] == FruitPosition)
    
    # If fruit not captured, remove last element of list. Otherwise add to counter and new fruit pos
    if (FruitCaptured) {
      
      PointScore <- PointScore + 1
      FruitPosition <- c(sample(seq_len(BoardDimensions[1]),
                                size = 1),
                         sample(seq_len(BoardDimensions[2]),
                                size = 1))
      while(list(FruitPosition) %in% SnakePosition) {
        
        FruitPosition <- c(sample(seq_len(BoardDimensions[1]),
                                  size = 1),
                           sample(seq_len(BoardDimensions[2]),
                                  size = 1))
        
      }
      
    } else {
      
      SnakePosition <- SnakePosition[-length(SnakePosition)]
      
    }
    
    # Check not out of bounds and no snake overlap
    if (.fSnakeOutofBounds(SnakePosition[[1]], BoardDimensions) | 
        .fSnakeOverlaps(SnakePosition)) {
      
      FailureStatus <- TRUE
      
    } 
    
    # Print position if in debug mode
    if (DebugMode) {
      
      .fOutputResult(SnakePosition, BoardDimensions, FruitPosition, PointScore, FailureStatus)
      Sys.sleep(0.1)
      
    }
    
  }
  
  # Return based on status
  return(!FailureStatus)
  
}




# Internal functions -----
## All the functions starting with a . are internal functions for fRunSnake. Just load and ignore!
.fValidateDirectionInput <- function(Input) {
  
  if (length(Input) == 1) {
    
    if (!(Input %in% c("U", "D", "L", "R"))) {
      
      stop("ERROR: your function must return a U/D/L/R.")
      
    }
    
  } else {
    
    stop("ERROR: more than one input received from your function.")
    
  }
  
}

.fCalcNewSnakePosition <- function(Direction, CurrentSnakePosition) {

  DirectionMovement <- dplyr::case_when(Direction == "U" ~ c(0, -1),
                                        Direction == "D" ~ c(0, 1),
                                        Direction == "L" ~ c(-1, 0),
                                        Direction == "R" ~ c(1, 0))
  
  NewSnakeHeadPosition <- CurrentSnakePosition[[1]] + DirectionMovement
  
  NewSnakePosition <- append(CurrentSnakePosition,
                             list(NewSnakeHeadPosition),
                             after = 0)
  
  return(NewSnakePosition)
  
}

.fSnakeOutofBounds <- function(SnakeHead, BoardDimensions) {

  # x position check
  if (SnakeHead[1] < 0 | SnakeHead[1] > BoardDimensions[1]) {
    
    return(TRUE)
    
    # y position check
  } else if (SnakeHead[2] < 0 | SnakeHead[2] > BoardDimensions[2]) {
    
    return(TRUE)
    
  } else {
    
    return(FALSE)
    
  }
  
}

.fSnakeOverlaps <- function(SnakePosition) {

  !purrr::is_empty(SnakePosition[duplicated(SnakePosition)])
  
}

.fOutputResult <- function(SnakePosition, BoardDimensions, FruitPosition, PointScore, FailureStatus) {

  SnakeBoard <- matrix(data = rep("", prod(BoardDimensions + 2)),
                       ncol = BoardDimensions[1] + 2,
                       nrow = BoardDimensions[2] + 2)
  
  # Decorate outside borderzone
  SnakeBoard[c(1, BoardDimensions[2] + 2),] <- "^"
  SnakeBoard[, c(1, BoardDimensions[1] + 2)] <- "^"
  
  
  # Apply snake positions
  for (i in seq_len(length(SnakePosition))) {
    
    SnakeBoard[SnakePosition[[i]][2] + 1, SnakePosition[[i]][1] + 1] <- "\u25A0"
    
  }
  
  # Apply snake head
  SnakeBoard[SnakePosition[[1]][2] + 1, SnakePosition[[1]][1] + 1] <- "X"
  
  # Apply fruit position
  SnakeBoard[FruitPosition[2] + 1, FruitPosition[1] + 1] <- "O"
  
  print(SnakeBoard)
  print(paste0("Score: ", PointScore, "; EndStatus: ", dplyr::if_else(FailureStatus, "Failure", "Success")))
  
}



# Example -----
## Below is a terrible algorithm example, it picks a random direction to move the snake in.
## The snake will eat itself very quickly!

TerribleAlgorithm <- function(FruitPos, SnakePosition) {
  
  Direction <- sample(c("L", "R", "U", "D"), size = 1)
  
  return(Direction)
  
}

# The below runs your algorithm once. DebugMode allows you to see each turn
fRunSnake(Dimensions, StartingPositionSnake, TerribleAlgorithm, PointGoal = PointTotalGoal,
          DebugMode = TRUE)


# The below runs your algorithm 50 times - DebugMode should be off otherwise it will take forever
## You can see it fails 50 times
purrr::map_lgl(1:50, ~fRunSnake(BoardDimensions, StartingPositionSnake, TerribleAlgorithm, PointGoal = PointTotalGoal)) %>%
  table()
