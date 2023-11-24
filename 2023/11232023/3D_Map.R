# libraries --------------------------------------------------------------------
library(ggplot2)
library(raster)
library(tidyr)
library(sf)
library(dplyr)
library(mapsf)
library(viridis)
library(mapview)
library(rayshader)

# Extract Data of Pakistan and min temp ----------------------------------------

Pakistan <- raster::getData('GADM', country = 'PAK', level = 1) 

Pakistan_sf <- Pakistan %>% st_as_sf()

clim <- raster::getData('worldclim', var = 'tmin', res = 10)

clim_masked <- clim %>% 
  raster::crop(Pakistan_sf) %>% 
  raster::mask(Pakistan_sf)

# To extract the data for July only --------------------------------------------

clim_july <- clim_masked[[7]] %>% 
  raster::extract(Pakistan_sf, fun = mean) %>% 
  as.data.frame() %>% 
  mutate(July_tmin = V1/10) %>% 
  dplyr::select(July_tmin)

Pakistan_sf_mutate <- Pakistan_sf %>% mutate(clim_july)

Pakistan_sf_transformed <- Pakistan_sf_mutate %>% st_transform(24370)

# To make a 2D map with a shadow (fake 3D :P) ----------------------------------

mf_init(Pakistan_sf_transformed, theme = 'iceberg')
mf_shadow(Pakistan_sf_transformed, col = 'purple', cex = 2)
mf_map(Pakistan_sf_transformed, add = TRUE)
mf_map(Pakistan_sf_transformed, var = 'July_tmin', type = 'choro', pal = 'Greens', add = TRUE)
mf_layout(title = 'Min July Temperature in Pakistan',
          credits = paste0("Data source: GADM and worldclim ", 'mapsf ',
                           packageVersion('mapsf'),
                           "\n#30DayMapChallenge | Day 23: 3D Map | Design: U. Siddiqi"))

# To make a 3D map -------------------------------------------------------------

gg_shp <- ggplot(data = Pakistan_sf_transformed) +
  geom_sf(aes(fill = July_tmin)) +
  scale_fill_viridis() +
  ggtitle('Minimum July temperature in Pakistan') +
  labs(
    caption = "#30DayMapChallenge | Day 23: 3D Map | Design: U. Siddiqi"
  ) +
  theme_bw()
plot_gg(gg_shp, multicore = TRUE, width = 5, height = 5, 
        scale = 200, windowsize = c(1280, 720), zoom = 0.65, 
        phi = 50, sunangle = 60, theta = 45)


# Save the plot -------------------------------------------------------------

ggsave("3D_map.png", plot = gg_shp, width = 5, height = 5, units = "in", dpi = 300)

#the command for saving the 3D plot is having some issues :(

# Huge HUGE thanks to this tutorial at R Pubs:
# https://rpubs.com/Wyclife/mapping_3D
