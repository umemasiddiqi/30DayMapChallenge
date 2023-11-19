##################################
###     30 Day Map Challenge   ###
###      Nov 19, 2023.         ###
###      Day 19: 5-min map     ###
###      Umema A. Siddiqi      ###
##################################

# library --------------------------------------------------------------------
library(leaflet)

# Create data ------------------------------------------------------------------

marker_data <- data.frame(
  lat = 24.8240,
  lon = 67.0398,
  name = "My prev. residence"
)

# Create a leaflet map ---------------------------------------------------------
my_map <- leaflet() %>%
  addTiles() %>%  
  addMarkers(data = marker_data, ~lon, ~lat, popup = ~name)  

# Plot --------------------------------------------------------------
my_map
