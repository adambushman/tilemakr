#' Make Tiles
#'
#' `make_tiles()` creates data frame of coordinates to draw square or hexagon
#' tile maps which can be plotted in {ggplot2}.
#'
#' @param layout A matrix outlining the desired tile map layout. Each position
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

#' Plot Tiles
#'
#' `plot_tiles()` takes a data frame of coordinates and to draw the corresponding
#' shapes to a {ggplot2} object.
#'
#' @param df A data frame of coordinates
#' @param labels A boolean (logical) value indicating if labels should be plotted.
#' @returns A {ggplot2} object
#' @import ggplot2
#' @examples
#' # Prepare coordinates dataframe
#' df_matrix = geo_tile_data[['US States']]
#' df_coord = make_tiles(df_matrix, "square")
#'
#' # Show the tile map
#' plot_tiles(df_coord)
#'
#' # Without labels
#' plot_tiles(df_coord, fALSE)
#' @export
plot_tiles <- function(df, labels = TRUE) {
  missing_cols = setdiff(c("x", "y", "center_x", "center_y", "id"), columns(df))
  if(length(missing_cols) > 0) {
    stop(paste("This data frame is missing the required columns:", paste(missing_cols, collapse = ", ")))
  }
  if(!is.logical(labels)) {
    stop("Please indicate if tile labels should be included or not with TRUE/FALSE")
  }

  main <-
    ggplot2::ggplot() +
    ggplot2::geom_polygon(
      ggplot2::aes(x, y, group = id),
      df
    )

  if(labels) {
    main <-
      main +
      ggplot2::geom_text(
        ggplot2::aes(
          center_x, center_y,
          label = id,
          color = "white"
        ),
        unique.data.frame(df[,c("center_x", "center_y", "id")])
      )
  }
  return(main)
}
