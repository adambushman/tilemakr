% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gen_hex.R
\name{gen_hex}
\alias{gen_hex}
\title{Generate Hexagon}
\usage{
gen_hex(group_id, size, padding, start)
}
\arguments{
\item{group_id}{A unique identifier for the series of polygon data points
creating a tile shape. Derived from the matrix layout.}

\item{size}{An integer detailing the point radius of the hexagon tile shape.}

\item{padding}{An integer detailing the space between surrounding hexagon
tile shapes.}

\item{start}{A vector of length two comprised of the x,y position for the next
hexagon tile shape to draw.}
}
\value{
A two element list with the shape data points and coordinates for the
next hexagon tile shapes to draw.
}
\description{
`gen_hex()` creates a series of polygon data points for an individual
hexagon tile group.
}
\examples{
gen_hex("A", 5, 2, c(0,0))
}
\seealso{
[make_hex_tiles(), make_tiles()]
}
