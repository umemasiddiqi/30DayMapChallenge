
########################################
###     30 Day Map Challenge         ###
###      Nov 26 & 27, 2023.          ###
###      Day 26 & 27: Dot & Minimal  ###
###      Umema A. Siddiqi            ###
########################################

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

# Get centroids of hexagons (to have dots)
hexgrid_centroids <- st_centroid(hexgrid)

# Filter centroids within Pakistan
hexgrid_centroids_PK <- st_intersection(hexgrid_centroids, PK)


# Plot the map ---------------------------------------------------------------

PK |> ggplot() +
  geom_sf(fill = "white", color = "darkgreen") +
  geom_sf(data = hexgrid_centroids_PK, color = "darkgreen", size = 0.8) +
  labs(title = "Connect the Dots", caption = "#30DayMapChallenge | Day 26 & 27: Minimal & Dots | Design: U. Siddiqi")

# Save this plot ---------------------------------------------------------------

ggsave(paste0("Min_Dots_", format(Sys.time(), "%d%m%Y"), ".png"), dpi = 320, width = 6, height = 6)
