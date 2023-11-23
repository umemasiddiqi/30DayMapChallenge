##################################
###     30 Day Map Challenge   ###
###      Nov 21, 2023.         ###
###      Day 21: Raster        ###
###      Umema A. Siddiqi      ###
##################################

# libraries --------------------------------------------------------------------
library(ggplot2)
library(raster)
library(tidyr)
library(rnaturalearth)
library(geodata)
library(cowplot)

# Data acquisition--------------------------------------------------------------
climate = getData('worldclim', var = 'bio', res = 2.5)

#Crop the data to Asia ---------------------------------------------------------
climate_Asia = crop(climate, extent(20, 150, -20, 90))

raster_rainfall = climate_Asia$bio12

asia = rnaturalearth::ne_countries(continent = 'asia', returnclass = 'sf')

plot(asia)

rasdf = as.data.frame(raster_rainfall, xy = TRUE)%>%drop_na()

head(rasdf)

# Plot -------------------------------------------------------------------------

Asiaplot = ggplot() +
  geom_tile(aes(x=x, y=y, fill=bio12), data = rasdf) +
  geom_sf(fill = 'transparent', data = asia) +
  scale_fill_viridis_c(name= 'mm/yr', direction = -1 ) +
  labs(x= 'Longitude' , y = 'Latitude',
       title = "Asia's Climate Map 2020",
       subtitle = "Annual precipitation",
       caption = '#30DayMapChallenge | Day 21: Raster | Design: U. Siddiqi') +
  cowplot::theme_cowplot() +
  theme(panel.grid.major = element_line(color = "black",
                                        linetype = 'dashed',
                                        size = .5),
        panel.grid.minor = element_blank(),
        panel.ontop = TRUE,
        panel.background = element_rect(fill = NA, color = 'black'))

Asiaplot

# Save plot -------------------------------------------------------------------
ggsave(paste0("Raster_Asia_", format(Sys.time(), "%d%m%Y"), ".png"), dpi = 320, width = 10, height = 10)
