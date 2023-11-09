##################################
###     30 Day Map Challenge   ###
###      Nov 9, 2023.          ###
###      Day 9: Hexagon        ###
###     Umema A. Siddiqi       ###
##################################

# libraries --------------------------------------------------------------------

library("sf")
library("tidyverse")
library("rnaturalearth")
library("rnaturalearthdata")
library("ggplot2")
library("viridis")

# Load data --------------------------------------------------------------------

PK <- ne_countries(scale = "large",
                   country = "Pakistan",
                   returnclass = "sf") |>
  st_geometry() |> ## 
  st_transform(24370) ## to reproject to Pakistan National Grid


hexgrid <- st_make_grid(PK,
                        cellsize = 2e4, ## unit: metres
                        what = 'polygons',
                        square = FALSE ## !
) |>
  st_as_sf()

hexgrid_PK <- hexgrid[c(unlist(st_contains(PK, hexgrid)), 
                        unlist(st_overlaps(PK, hexgrid))) ,] 

# Plot the map with title and caption ------------------------------------------

PK |> ggplot() +
  geom_sf(fill = "white", color = "darkblue") +
  geom_sf(data = hexgrid_PK, color = "darkblue", show.legend = "point") +
  labs(title = "Hexagonal Grid Map of Pakistan", caption = "#30DayMapChallenge | Day 9: Hexagons | Design: U. Siddiqi")

# Save this plot ---------------------------------------------------------------

ggsave(paste0("Pak_Hexagon_", format(Sys.time(), "%d%m%Y"), ".png"), dpi = 320, width = 6, height = 6)

