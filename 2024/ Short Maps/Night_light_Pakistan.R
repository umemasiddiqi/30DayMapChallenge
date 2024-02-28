# Load the library
library(leaflet)

# Background 1: NASA
m <- leaflet() %>% 
  addTiles() %>% 
  setView( lng = 69.3451, lat = 30.3753, zoom = 5 ) %>% 
  addProviderTiles("NASAGIBS.ViirsEarthAtNight2012")
m

# Background 2: World Imagery
m <- leaflet() %>% 
  addTiles() %>% 
  setView( lng = 69.3451, lat = 30.3753, zoom = 3 ) %>% 
  addProviderTiles("Esri.WorldImagery")
m
