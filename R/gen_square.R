#' Generate Square
#'
#' `gen_square()` creates a series of polygon data points for an individual
#' tile group.
#'
#' @param group_id A unique identifier for the series of polygon data points
#' creating a tile shape. Derived from the matrix layout.
#' @param size An integer detailing the length and width of the square tile shape.
#' @param padding An integer detailing the space between surrounding square
#' tile shapes.
#' @param start A vector of length two comprised of the x,y position for the next
#' square tile shape to draw.
#' @seealso [make_square_tiles(), make_tiles()]
#' @returns A two element list with the shape data points and coordinates for the
#' next square tile shapes to draw.
#' @examples
#' gen_square("A", 10, 2, c(0,0))
gen_square <- function (group_id, size, padding, start) {
  x_adj = c(0, 1, 1, 0)
  y_adj = c(0, 0, 1, 1)

  shape_data <- data.frame(
    id = group_id,
    x =(size * x_adj) + start[1],
    y = (size * y_adj) + start[2],
    center_x = (size / 2) + start[1],
    center_y = (size / 2) + start[2]
  )

  next_data <- list(
    "left" = c(start[1] - size - padding, start[2]),
    "right" = c(start[1] + size + padding, start[2]),
    "top" = c(start[1], start[2] + size + padding),
    "bottom" = c(start[1], start[2] - size - padding)
  )

  return(list("shape_data" = shape_data, "next_data" = next_data))
}


#' Make Square Tile
#'
#' `make_square_tiles()` creates a data frame of tile data points for each
#' valid element observed in the layout.
#'
#' @param layout A matrix outlining the desired tile map layout. Each position
#' intended for a tile should have a unique identifier while all empty positions
#' should feature a '0'.
#' @param size An integer detailing the length and width of the square tile shape.
#' @param padding An integer detailing the space between surrounding square
#' tile shapes.
#' @seealso [gen_square(), make_tiles()]
#' @returns A data frame of coordinates for drawing the square tiles and center
#' coordinates for plotting the group text.
#' @examples
#' layout = matrix(
#'   data = c(
#'     "A", 0, 0, "B",
#'     0, "C", "D", "E",
#'     0, 0, "F", 0,
#'     0, "G", 0, 0
#'   ),
#'   byrow = TRUE,
#'   nrow = 4,
#'   ncol = 4
#' )
#' make_square_tiles(layout, 10, 2)
make_square_tiles <- function(layout, size, padding) {
  row_order = rev(1:nrow(layout))
  col_order = 1:ncol(layout)
  h_direc = "right"
  my_direc = ""
  pos = c(0, 0)

  return_data <- data.frame(
    id = c("X"),
    x = c(-1),
    y = c(-1),
    center_x = c(0),
    center_y = c(0)
  )

  for(i in row_order) {
    for(j in col_order) {

      # Determine group id
      group_id = ifelse(layout[i,j] == "0", paste0("0", pos[1], pos[2]), layout[i,j])

      # Draw the shape
      data_gen = gen_square(group_id, size, padding, pos)

      # Add data
      return_data = rbind(
        return_data, data_gen$shape_data
      )

      # New position
      my_direc = ifelse(j == col_order[length(col_order)], "top", h_direc)
      pos = data_gen$next_data[[my_direc]]
    }
    h_direc = setdiff(c("left", "right"), h_direc)
    col_order = rev(col_order)
  }

  return(return_data[return_data$id != "X" & substring(return_data$id, 1, 1) != "0",])
}
