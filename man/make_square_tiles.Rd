% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gen_square.R
\name{make_square_tiles}
\alias{make_square_tiles}
\title{Make Square Tile Data}
\usage{
make_square_tiles(layout, size, padding)
}
\arguments{
\item{layout}{A matrix outlining the desired tile map layout. Each position
intended for a tile should have a unique identifier while all empty positions
should feature a '0'.}

\item{size}{An integer detailing the length and width of the square tile shape.}

\item{padding}{An integer detailing the space between surrounding square
tile shapes.}
}
\value{
A data frame of coordinates for drawing the square tiles and center
coordinates for plotting the group text.
}
\description{
`make_square_tiles()` creates a data frame of tile data points for each
valid element observed in the layout.
}
\examples{
layout <- demo_data[["Example Matrix"]]

make_square_tiles(layout, 10, 2)
}
\seealso{
[gen_square(), make_tiles()]
}
