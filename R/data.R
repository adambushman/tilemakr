#' Tabular layout for tile map
#'
#' A grid style layout for creating a tile map. Each column and row describes
#' elements to great the map. This data type should be converted to a matrix
#' using `tabular_to_matrix()`.
#'
#' @format ## `tabular_layout`
#' A data frame with 4 rows and 4 columns:
#' \describe{
#'   \item{V1}{Layout elements}
#'   \item{V2}{Layout elements}
#'   \item{V3}{Layout elements}
#'   \item{V4}{Layout elements}
#' }
"tabular_layout"

#' Tabular layout for tile map
#'
#' A data set intended to illustrate how to join generated tile map data to
#' a corresponding data set with variables of interest.
#'
#' @format ## `sales_data`
#' A data frame with 7 rows and 2 columns:
#' \describe{
#'   \item{id}{Unique identifiers for the tile shapes}
#'   \item{sales}{Sales figures for each tile shape}
#' }
"sales_data"

#' List of matrices to create tile maps
#'
#' Pre-generated layout matrices for quick tile making, then join to and plot
#' with your own data sets.
#'
#' @format ## `tile_layouts`
#' A list of matrices for creating tile maps using any shape supported
#' by the {tilemaker} functions.
"tile_layouts"
