# {tilemakr} Package <img src="https://github.com/adambushman/tilemakr/blob/main/tilemakr_package_hex.png" align="right" width="300"/>

This package creates custom tile map data for...anything. Turn a matrix layout into coordinates that feed {ggplot2} layers.

If you've ever wanted to recreate the US tile map design with your own layout, this package is for you.

# Getting Started

To get started with the package, install using `remotes`:

```         
install.packages("remotes")

remotes::install_github(
  "adambushman/tilemakr", 
  build_vignettes = TRUE
)
```

Once installed, load the package using the `library` command below or reference individual components using the `::` framework:

```         
# Load the entire library into the session

library("tilemakr")
```

# Making Your First Tile Map

It's really easy to go from a tabular layout to a tile map with {tilemaker}. Just transform the layout to shape data and visualize in {ggplot2}:

```
# Tabular layout in matrix form
layout <-
  matrix(
    c("A", 0, 0, 0, 0, "B", "C", 0, 
      0, 0, "D", 0, "E", "F", 0, 0), 
    nrow = 4, ncol = 4, byrow = TRUE
  )

# Hexagon tile map
shape_data <- tilemakr::make_tiles(layout, "hexagon")
tilemakr::plot_tiles(shape_data)
```

Create the beloved US States tile map or any such variation. And tile maps aren't just for geography; leverage the benefits of a tile map with any layout of interest.

# Credits

Authored and Maintained by Adam Bushman
