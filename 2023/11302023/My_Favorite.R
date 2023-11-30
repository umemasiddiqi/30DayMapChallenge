##################################
###     30 Day Map Challenge   ###
###      Nov 30, 2023.         ###
###      Day 30: My favorite   ###
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
streets <- getbb('Barcelona Spain') %>%
  opq() %>%
  add_osm_feature(key='highway',
                  value=c('motorway', 'primary',
                          'secondary', 'tertiary')) %>%
  osmdata_sf()

small_streets <- getbb('Barcelona Spain') %>%
  opq() %>%
  add_osm_feature(key='highway',
                  value=c('residential', 'living_street',
                          'service', 'footway')) %>%
  osmdata_sf()

rivers <- getbb('Barcelona Spain') %>%
  opq() %>%
  add_osm_feature(key='natural',
                  value=c('water')) %>%
  osmdata_sf()

# 2. Build the map -------------------------------------------------------------

ggplot() +
  geom_sf(data=streets$osm_lines,
          inherit.aes = FALSE,
          color = '#872007',
          size = .5,
          alpha = .6) +
  geom_sf(data=small_streets$osm_lines,
          inherit.aes = FALSE,
          color = '#934d05',
          size = .2,
          alpha = .6) +
  geom_sf(data=rivers$osm_polygons,
          inherit.aes = FALSE,
          fill='#ae6b03',
          size = .2)+
  
  #2a. To have a focused map by eliminating empty spaces
  coord_sf(ylim=c(41.375, 41.395),
           xlim=c(2.142, 2.168),
           expand=FALSE)+
  
  #2b. To add the border and title etc.
  labs(title = "Barcelona", caption = "#30DayMapChallenge | Day 30: My favorite | Design: U. Siddiqi") + 
  theme(
    plot.background = element_rect(fill="#5a1204",color='#5a1204'),
    plot.margin = unit(c(0.3, 0.4, 0.5, 0.4), 'cm'),
    panel.background = element_rect(color='#C2A03D', 
                                    fill='#C2A03D',
                                    size = 20),
    panel.grid = element_blank(),
    axis.ticks = element_blank(),
    axis.text  = element_blank(),
    plot.title = element_text(size=18, 
                              face='bold',
                              hjust=.5,
                              color='#D2A03F'),
    plot.caption = element_text(size=11, color = '#D2A03F')
  )

#3. To save the plot -------------------------------------------------
ggsave(paste0("Fav_1_", format(Sys.time(), "%d%m%Y"), ".png"), dpi = 320, width = 6, height = 6)

# Special thanks to Mr. Irfan Alghani Khaled and this tutorial by him:
# https://towardsdatascience.com/how-to-create-an-artistic-map-using-r-2a4932a23d10
