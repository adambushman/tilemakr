#' Tabular to Matrix
#'
#' `tabular_to_matrix()` converts a layout stored in a data frame to that of a
#' matrix for proper use in the `make_tiles()` function. Remember to exclude
#' column names (or remove the header) from the data frame.
#'
#' @param df A data frame where rows and columns represent a grid layout for
#' the tile map creation. Column names/headers should be excluded.
#' @seealso [make_tiles()]
#' @returns A matrix form of the layout intended for a tile maps.
#' @examples
#' layout <- demo_data[["Example Data Frame"]]
#'
#' # Currently a data frame
#' class(layout)
#'
#' new_layout = tabular_to_matrix(layout)
#'
#' # Now a matrix
#' class(new_layout)
#' @export
tabular_to_matrix <- function(df) {
  matrix(unlist(df, use.names = FALSE), nrow(df), ncol(df))
}
