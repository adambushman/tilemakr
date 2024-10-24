#' Generate Circle
#'
#' `gen_circle()` creates a series of polygon data points for an individual
#' hexagon tile group.
#'
#' @param group_id A unique identifier for the series of polygon data points
#' creating a tile shape. Derived from the matrix layout.
#' @param size An integer detailing the radius of the circle tile shape.
#' @param padding An integer detailing the space between surrounding circle
#' tile shapes.
#' @param start A vector of length two comprised of the x,y position for the next
#' hexagon tile shape to draw.
#' @seealso [make_circle_tiles(), make_tiles()]
#' @returns A two element list with the shape data points and coordinates for the
#' next circle tile shapes to draw.
#' @keywords internal
#' @examples
#' gen_circle("A", 10, 2, c(0,0))
#' @noRd
gen_circle <- function(group_id, size, padding, start) {

  primary_r = seq(0, 2*pi, by = pi/20)
  neighbor_r = seq(pi / 6, 11 * pi / 6, by = pi / 3) + (pi / 2)

  shape_data <- data.frame(
    id = group_id,
    x = (cos(primary_r) * size) + start[1],
    y = (sin(primary_r) * size) + start[2],
    center_x = start[1],
    center_y = start[2]
  )

  neighbor_points_x = (cos(neighbor_r) * (size + (padding / 2)) * 2)
  neighbor_points_y = (sin(neighbor_r) * (size + (padding / 2)) * 2)

  next_data <- list(
    "top-left" = c(
      neighbor_points_x[1] + start[1],
      neighbor_points_y[1] + start[2]
    ),
    "left" = c(
      neighbor_points_x[2] + start[1],
      neighbor_points_y[2] + start[2]
    ),
    "right" = c(
      neighbor_points_x[5] + start[1],
      neighbor_points_y[5] + start[2]
    ),
    "top-right" = c(
      neighbor_points_x[6] + start[1],
      neighbor_points_y[6] + start[2]
    )
  )

  return(list("shape_data" = shape_data, "next_data" = next_data))
}


#' Make Circle Tile Data
#'
#' `make_circle_tiles()` creates a data frame of tile data points for each
#' valid element observed in the layout.
#'
#' @param layout A matrix outlining the desired tile map layout. Each position
#' intended for a tile should have a unique identifier while all empty positions
#' should feature a '0'.
#' @param size An integer detailing the radius of the circle tile shape.
#' @param padding An integer detailing the space between surrounding circle
#' tile shapes.
#' @seealso [gen_circle(), make_tiles()]
#' @returns A data frame of coordinates for drawing the circle tiles and center
#' coordinates for plotting the group text.
#' @examples
#' layout <- demo_data[["Example Matrix"]]
#'
#' make_circle_tiles(layout, 10, 2)
#' @noRd
make_circle_tiles <- function(layout, size, padding) {
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
      data_gen = gen_circle(group_id, size, padding, pos)

      # Add data
      return_data = rbind(
        return_data, data_gen$shape_data
      )

      # New position
      my_direc = ifelse(j == col_order[length(col_order)], "top", h_direc)
      if(my_direc == "top") {
        my_direc = paste0("top-", h_direc)
      }
      pos = data_gen$next_data[[my_direc]]
    }
    h_direc = setdiff(c("left", "right"), h_direc)
    col_order = rev(col_order)
  }

  return(return_data[return_data$id != "X" & substring(return_data$id, 1, 1) != "0",])
}

