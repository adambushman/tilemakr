#' Make Tiles
#'
#' `make_tiles()` creates data frame of coordinates to draw square or hexagon
#' tile maps which can be plotted in {ggplot2}.
#'
#' @param layout A matrix outlining the desired tile map layout. Each position
#' intended for a tile should have a unique identifier while all empty positions
#' should feature a '0'.
#' @param type A string identifying the shape type to generate; 'square', 'hexagon',
#' 'circle', or 'diamond'.
#' @param size An integer detailing the length and width of the square tile shape.
#' @param padding An integer detailing the space between surrounding tile shapes.
#' @seealso [make_square_tiles(), make_hex_tiles(), make_circle_tiles(), make_diamond_tiles()]
#' @returns A data frame of coordinates to draw tile maps.
#' @examples
#' layout = demo_data[["Example Matrix"]]
#'
#' # Square tile map
#' make_tiles(layout, 'square', 10, 2)
#'
#' # Hexagon tile map
#' make_tiles(layout, 'hexagon')
#'
#' # Circle tile map
#' make_tiles(layout, 'circle')
#' @export
make_tiles <- function(
    layout,
    type = c("square", "hexagon", "circle", "diamond"),
    size = 10,
    padding = 2
) {

  # Argument validation

  if(!is.matrix(layout)) {
    stop("Pass the 'layout' argument a matrix")
  }

  if(is.null(type) | !(type %in% c("square", "hexagon", "circle", "diamond"))) {
    stop("The 'type' argument must be either 'square', 'hexagon', 'circle', or 'diamond'")
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
    return(make_hex_tiles(layout, size, padding))
  } else if (type == "circle") {
    return(make_circle_tiles(layout, size, padding))
  } else if (type == "diamond") {
    return(make_diamond_tiles(layout, size, padding))
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
#' @import ggplot2 rlang
#' @examples
#' # Prepare coordinates dataframe
#' df_matrix = geo_tile_data[['US States']]
#' df_coord = make_tiles(df_matrix, "square")
#'
#' # Show the tile map
#' plot_tiles(df_coord)
#'
#' # Without labels
#' plot_tiles(df_coord, FALSE)
#' @export
plot_tiles <- function(df, labels = TRUE) {
  missing_cols = setdiff(c("x", "y", "center_x", "center_y", "id"), names(df))
  if(length(missing_cols) > 0) {
    stop(paste("This data frame is missing the required columns:", paste(missing_cols, collapse = ", ")))
  }
  if(is.null(labels)) {
    labels = TRUE
  }
  if(!is.logical(labels)) {
    stop("Please indicate if tile labels should be included or not with TRUE/FALSE")
  }

  main <-
    ggplot2::ggplot() +
    ggplot2::geom_polygon(
      ggplot2::aes(.data$x, .data$y, group = .data$id),
      df
    )

  if(labels) {
    main <-
      main +
      ggplot2::geom_text(
        ggplot2::aes(
          .data$center_x, .data$center_y,
          label = .data$id
        ),
        color = "white",
        unique.data.frame(df[,c("center_x", "center_y", "id")])
      ) +
      ggplot2::coord_equal()
  }
  return(main)
}

#' Preview Shapes
#'
#' `preview_shapes()` shows a preview of what tile maps would look like with
#' different shapes.
#'
#' @returns A {ggplot2} object
#' @import ggplot2 rlang
#' @examples
#' preview_shapes()
#' @export
preview_shapes <- function() {
  layout <- demo_data[["Example Matrix"]]

  shapes <- c("square", "hexagon", "circle", "diamond")
  full_data = data.frame(matrix(nrow = 0, ncol = 6))
  colnames(full_data) = c("id", "x", "y", "center_x", "center_y", "shape")

  for(s in shapes) {
    temp = make_tiles(layout, s, 10, 2)
    temp$shape = s
    full_data = rbind(full_data, temp)
  }

  plot <-
    ggplot2::ggplot() +
    ggplot2::geom_polygon(aes(.data$x, y, group = .data$id), full_data) +
    ggplot2::coord_equal() +
    ggplot2::facet_wrap(~shape)

  return(plot)
}
