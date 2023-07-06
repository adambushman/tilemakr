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

# Tile Shapes

We can make all sorts of tile shapes with the package functions. Just pass the right parameter to `make_tiles()` and get the right shape data. Below are the possibilities:

-   square
-   hexagon
-   circle
-   diamond

```
layout <-
  matrix(
    c("A", 0, 0, 0, 0, "B", "C", 0, 
      0, 0, "D", 0, "E", "F", 0, 0), 
    nrow = 4, ncol = 4, byrow = TRUE
  )

shapes <- c("square", "hexagon", "circle", "diamond")
full_data = data.frame(matrix(nrow = 0, ncol = 6))
colnames(full_data) = c("id", "x", "y", "center_x", "center_y", "shape")

for(s in shapes) {
  temp = make_tiles(layout, s, 10, 2)
  temp$shape = s
  full_data = rbind(full_data, temp)
}

ggplot() +
geom_polygon(aes(x, y, group = id), full_data) + 
  coord_equal() +
  facet_wrap(~shape)
```

# Credits

Authored and Maintained by Adam Bushman
