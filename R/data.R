#' @title Demo Data
#'
#' @description A collection of data structures for experimenting with `tilemakr` functions.
#'
#' @format A list of matrices and data frames
#' \describe{
#' \item{`US States`}{A matrix layout featuring US States}
#' \item{`Canada Provinces`}{A matrix layout featuring Candadian provinces}
#' \item{`Mexico States`}{A matrix layout featuring states of Mexico}
#' \item{`NYC Burroughs`}{A matrix layout featuring burroughs of New York}
#' \item{`European Countries`}{A matrix layout featuring countries of Europe}
#' \item{`NBA Franchises`}{A matrix layout featuring franchises of the National Basketball Association}
#' }
"demo_data"

#' @title Tile Layouts
#'
#' @description Pre-generated layout matrices for quick tile making, then join to and plot
#' with your own data sets.
#'
#' @format A list of matrices, which are:
#' \describe{
#' \item{`Example Matrix`}{A matrix featuring an example, desired layout}
#' \item{`Example Data Frame`}{A data frame featuring the desired layout in a data frame object}
#' \item{`Sales Data`}{A data frame featuring sales data associated with shapes id's from `Example Matrix` and `Example Data Frame`}
#' \item{`NBA Standings`}{A data frame featuring win/loss records associated with shape id's from `NBA Franchises`}
#' }
"tile_layouts"
