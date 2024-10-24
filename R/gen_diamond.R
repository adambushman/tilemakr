#' Generate Diamond
#'
#' `gen_diamond()` creates a series of polygon data points for an individual
#' diamond tile group.
#'
#' @param group_id A unique identifier for the series of polygon data points
#' creating a tile shape. Derived from the matrix layout.
#' @param size An integer detailing the point radius of the diamond tile shape.
#' @param padding An integer detailing the space between surrounding diamond
#' tile shapes.
#' @param start A vector of length two comprised of the x,y position for the next
#' diamond tile shape to draw.
#' @seealso [make_diamond_tiles(), make_tiles()]
#' @returns A two element list with the shape data points and coordinates for the
#' next diamond tile shapes to draw.
#' @examples
#' gen_diamond("A", 10, 2, c(0,0))
#' @noRd
gen_diamond <- function(group_id, size, padding, start) {

  primary_r = seq(0, 3 * pi / 2, by = pi / 2)

  x_size = size * 0.9
  y_size = size * 1.1
  x_padding = padding * 0.9
  y_padding = padding * 1.1

  shape_data <- data.frame(
    id = group_id,
    x = (cos(primary_r) * x_size) + start[1],
    y = (sin(primary_r) * y_size) + start[2],
    center_x = start[1],
    center_y = start[2]
  )

  neighbor_points_x = c(2, -1, 1, -2)  * (x_size + x_padding)
  neighbor_points_y = c(0, 1, 1, 0)  * (y_size + y_padding)

  next_data <- list(
    "top-left" = c(
      neighbor_points_x[3] + start[1],
      neighbor_points_y[3] + start[2]
    ),
    "left" = c(
      neighbor_points_x[4] + start[1],
      neighbor_points_y[4] + start[2]
    ),
    "right" = c(
      neighbor_points_x[1] + start[1],
      neighbor_points_y[1] + start[2]
    ),
    "top-right" = c(
      neighbor_points_x[2] + start[1],
      neighbor_points_y[2] + start[2]
    )
  )

  return(list("shape_data" = shape_data, "next_data" = next_data))
}


#' Make Diamond Tile Data
#'
#' `make_diamond_tiles()` creates a data frame of tile data points for each
#' valid element observed in the layout.
#'
#' @param layout A matrix outlining the desired tile map layout. Each position
#' intended for a tile should have a unique identifier while all empty positions
#' should feature a '0'.
#' @param size An integer detailing the point radius of the diamond tile shape.
#' @param padding An integer detailing the space between surrounding diamond
#' tile shapes.
#' @seealso [gen_diamond(), make_tiles()]
#' @returns A data frame of coordinates for drawing the diamond tiles and center
#' coordinates for plotting the group text.
#' @examples
#' layout <- demo_data[["Example Matrix"]]
#'
#' make_diamond_tiles(layout, 10, 2)
#' @noRd
make_diamond_tiles <- function(layout, size, padding) {
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
      data_gen = gen_diamond(group_id, size, padding, pos)

      # Add data
      return_data = rbind(
        return_data, data_gen$shape_data
      )

      # New position
      my_direc = ifelse(j == col_order[length(col_order)], "top", h_direc)
      if(my_direc == "top") {
        h_direc = setdiff(c("left", "right"), h_direc)
        my_direc = paste0("top-", h_direc)
      }
      pos = data_gen$next_data[[my_direc]]
    }
    col_order = rev(col_order)
  }

  return(return_data[return_data$id != "X" & substring(return_data$id, 1, 1) != "0",])
}

