# {tilemakr} <img src="https://github.com/adambushman/tilemakr/blob/main/man/figures/tilemakr_package_hex.png" align="right" width="300"/>

`{tilemakr}` is a package for R that creates custom tile map data for...anything. Turn a matrix layout into coordinates that feed {ggplot2} layers.

If you've ever wanted to adopt the US tile map design for your own layout, this package is for you.

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

It's really easy to go from a tabular layout to a tile map with {tilemaker}. Create a layout in matrix form (see `make_tiles()` documentation for layout best practices), transform it to shape data coordinates, and visualize your tile map:

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

![Tile Map](https://github.com/adambushman/tilemakr/blob/main/man/figures/example_tile_map.jpeg)

Recreate the beloved US States tile map or use the same approach to create any tile map variation you choose.

# Tile Shapes

We can make all sorts of tile shapes with the package functions. Just pass the right parameter to `make_tiles()` and get the right shape data. Below are the currently supported shape types:

-   square
-   hexagon
-   circle
-   diamond

You can preview these shapes with a demo layout using the `preview_shapes()` function:

```
preview_shapes()
```

![Supported Shapes](https://github.com/adambushman/tilemakr/blob/main/man/figures/example_tile_shapes.jpeg)


# Possibilities

Using `{tilemakr}`, we can create the foundations of tile maps that turn immaculate once styled with `{ggplot2}`. Take a look at just some of the possibilities.

![Example Square Tile Map](https://github.com/adambushman/tidytuesday-contribs/blob/b78f7ad525b5ef6830db143493c0a3589b36a3db/wk27-23_historical-markers/utah-historical-markers_final.png)

![Example Hexagon Tile Map](https://github.com/adambushman/tilemakr/blob/main/man/figures/example_map_hexagon.png)

![Example Diamond Tile Map](https://github.com/adambushman/tilemakr/blob/main/man/figures/example_map_diamond.png)

# Credits

Authored and Maintained by Adam Bushman
