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

You'll find helpful functions for turning custom layouts into plottable data frames in {ggplot2}.

# Credits

Authored and Maintained by Adam Bushman
