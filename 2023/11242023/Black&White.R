##################################
###     30 Day Map Challenge   ###
###      Nov 24, 2023.         ###
###      Day 24: Black & White ###
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
streets <- getbb('Karachi Pakistan') %>%
  opq() %>%
  add_osm_feature(key='highway',
                  value=c('motorway', 'primary',
                          'secondary', 'tertiary')) %>%
  osmdata_sf()

small_streets <- getbb('Karachi Pakistan') %>%
  opq() %>%
  add_osm_feature(key='highway',
                  value=c('residential', 'living_street',
                          'service', 'footway')) %>%
  osmdata_sf()

rivers <- getbb('Karachi Pakistan') %>%
  opq() %>%
  add_osm_feature(key='natural',
                  value=c('water')) %>%
  osmdata_sf()

# 2. Build the map -------------------------------------------------------------

ggplot() +
  geom_sf(data=streets$osm_lines,
          inherit.aes = FALSE,
          color = '#bfbfbf',
          size = .5,
          alpha = .6) +
  geom_sf(data=small_streets$osm_lines,
          inherit.aes = FALSE,
          color = '#404040',
          size = .2,
          alpha = .6) +
  geom_sf(data=rivers$osm_polygons,
          inherit.aes = FALSE,
          fill='#01579B',
          size = .2)+
  
  #2a. To have a focused map by eliminating empty spaces
  coord_sf(ylim=c(24.901, 24.950),
           xlim=c(67.101, 67.150),
           expand=FALSE)+
  
  #2b. To add the border and title etc.
  labs(title = "Karachi", caption = "#30DayMapChallenge | Day 24: Black & White | Design: U. Siddiqi") + 
  theme(
    plot.background = element_rect(fill="#000000",color='#000000'),
    plot.margin = unit(c(0.3, 0.4, 0.5, 0.4), 'cm'),
    panel.background = element_rect(color='#ffffff', 
                                    fill='#ffffff',
                                    linewidth = 20),
    panel.grid = element_blank(),
    axis.ticks = element_blank(),
    axis.text  = element_blank(),
    plot.title = element_text(size=18, 
                              face='bold',
                              hjust=.5,
                              color='#ffffff'),
    plot.caption = element_text(size=10, 
                                face='plain',
                                hjust=.5,
                                color='#ffffff')
  )

#3. To save plot -------------------------------------------------
ggsave(paste0("Khi_B&W_", format(Sys.time(), "%d%m%Y"), ".png"), dpi = 320, width = 6, height = 6)

# Special thanks to Mr. Irfan Alghani Khaled and this tutorial by him:
# https://towardsdatascience.com/how-to-create-an-artistic-map-using-r-2a4932a23d10
