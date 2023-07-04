#' Make Tiles
#'
#' `make_tiles()` creates data frame of coordinaates to draw square or hexagon
#' tile maps which can be plotted in {ggplot2}.
#'
##' @param layout A matrix outlining the desired tile map layout. Each position
#' intended for a tile should have a unique identifier while all empty positions
#' should feature a '0'.
#' @param type A string identifying the shape type to generate; either a 'square'
#' or 'hexagon'.
#' @param size An integer detailing the length and width of the square tile shape.
#' @param padding An integer detailing the space between surrounding square
#' tile shapes.
#' @seealso [make_square_tiles(), gen_square()]
#' @returns A data frame of coordinates to draw tile maps.
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
#' make_tiles(layout, 'square', 10, 2)
#' @export
make_tiles <- function(
    layout,
    type = c("square", "hexagon"),
    size = 10,
    padding = 2
) {

  # Argument validation

  if(!is.matrix(layout)) {
    stop("Pass the 'layout' argument a matrix")
  }

  if(is.null(type) | !(type %in% c("square", "hexagon"))) {
    stop("The 'type' argument must be either 'square' or 'hexagon'")
  }

  if(!is.numeric(size) | size < 1) {
    stop("Enter a positive, real number for the tile 'size'")
  }

  if(!is.numeric(padding) | padding < 0) {
    stop("Enter zero or a positive, real number for the tile 'padding'")
  }

  # Matrix validation

  if(length(setdiff(c(layout), "0")) != length(unique(setdiff(c(layout), "0")))) {
    stop("The layout matrix must comprise unique values for all positions intended to be mapped as tiles. All other values should feature a '0'.")
  }

  if(type == "square") {
    return(make_square_tiles(layout, size, padding))
  } else if (type == "hexagon") {
    print("Not yet available")
  }
}
