##################################
###     30 Day Map Challenge   ###
###      Nov 15, 2023.         ###
###      Day 15: OpenStreetMap ###
###      Umema A. Siddiqi      ###
##################################

# libraries --------------------------------------------------------------------
library(osmdata)
library(tidyverse)
library(sf)
library(ggplot2)

# To extend the timeout
options(timeout=600)

# 1. Load the data -------------------------------------------------------------
streets <- getbb('Islamabad Pakistan') %>%
  opq() %>%
  add_osm_feature(key='highway',
                  value=c('motorway', 'primary',
                          'secondary', 'tertiary')) %>%
  osmdata_sf()

small_streets <- getbb('Islamabad Pakistan') %>%
  opq() %>%
  add_osm_feature(key='highway',
                  value=c('residential', 'living_street',
                          'service', 'footway')) %>%
  osmdata_sf()

rivers <- getbb('Islamabad Pakistan') %>%
  opq() %>%
  add_osm_feature(key='natural',
                  value=c('water')) %>%
  osmdata_sf()

# 2. Build the map -------------------------------------------------------------

ggplot() +
  geom_sf(data=streets$osm_lines,
          inherit.aes = FALSE,
          color = '#58b9c7',
          size = .5,
          alpha = .6) +
  geom_sf(data=small_streets$osm_lines,
          inherit.aes = FALSE,
          color = '#239de9',
          size = .2,
          alpha = .6) +
  geom_sf(data=rivers$osm_polygons,
          inherit.aes = FALSE,
          fill='#f8cc0a',
          size = .2)+
  
#2a. To have a focused map by eliminating empty spaces
coord_sf(ylim=c(33.60, 33.65),
         xlim=c(73.02, 73.13),
         expand=FALSE)+

#2b. To add the border and title etc.
labs(title = "Is llama good or Islamabad", caption = "#30DayMapChallenge | Day 15: Open Street Map | Design: U. Siddiqi") + 
  theme(
    plot.background = element_rect(fill="#f8cc0a",color='#f8cc0a'),
    plot.margin = unit(c(0.3, 0.4, 0.5, 0.4), 'cm'),
    panel.background = element_rect(color='#08435f', 
                                    fill='#08435f',
                                    size = 20),
    panel.grid = element_blank(),
    axis.ticks = element_blank(),
    axis.text  = element_blank(),
    plot.title = element_text(size=18, 
                              face='bold',
                              hjust=.5,
                              color='#08435f'),
  )

#3. Let's save this beauty now -------------------------------------------------
ggsave(paste0("Isl_OSM_", format(Sys.time(), "%d%m%Y"), ".png"), dpi = 320, width = 6, height = 6)

# Special thanks to Mr. Irfan Alghani Khaled and this tutorial by him:
# https://towardsdatascience.com/how-to-create-an-artistic-map-using-r-2a4932a23d10
