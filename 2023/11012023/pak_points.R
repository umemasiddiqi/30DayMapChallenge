##################################
### 30 Day Map Challenge #########
### Nov 1, 2023. Points    #######
#### Umema A. Siddiqi ############
##################################

# libraries ---------------------------------------------------------------
library(tidyverse)
library(showtext)
library(maps)
library(sf)
library(DescTools)

# add font ----------------------------------------------------------------
font_add_google(name = "Rubik", family = "Rubik")
font <- "Rubik"

# turn on showtext --------------------------------------------------------
showtext_auto()
showtext_opts(dpi = 320)

# get PAK map data ---------------------------------------------------------
pak<- map_data('world')[map_data('world')$region == "Pakistan",]

# get the bounding box of points ------------------------------------------
# Calculate the range of longitude and latitude
min_lon <- min(pak$long - 6)
max_lon <- max(pak$long + 6)
min_lat <- min(pak$lat - 7)
max_lat <- max(pak$lat + 7)

# calculate the grid of points --------------------------------------------
df_points <- expand_grid(x = seq(from = min_lon, to = max_lon, length.out = 100),
                         y = seq(from = min_lat, to = max_lat, length.out = 100))

# get the outline of points of map ----------------------------------------
pak_map_line <- pak %>% 
  select(1:2) %>% 
  rename(x = long, y = lat)

# calculate the points from the grid within the bounding box line ---------
map_df <- data.frame(PtInPoly(df_points, pak_map_line)) %>% 
  filter(!pip == 1) %>% 
  st_as_sf(coords = c('x', 'y')) %>%
  st_set_crs(4326)

# create plot -------------------------------------------------------------
ggplot() +
  geom_sf(data = map_df, size = 0.05, color = "#000000") +
  coord_sf() +
  theme_void() +
  theme(plot.caption = element_text(family = font, hjust = 0.9, size = 7.5, color = "#000000", margin = margin(t = 25)),
        plot.caption.position = "plot",
        plot.margin = unit(c(0.5, 0.5, 0, 0.5), "cm"),
        panel.background = element_rect(color = NA, fill = "#f7f7f5"),
        plot.background = element_rect(color = NA, fill = "#f7f7f5")) +
  labs(caption = "#30DayMapChallenge | Day 1: Points | Design: Umema Siddiqi")

# save plot ---------------------------------------------------------------
ggsave(paste0("us_neg_points_", format(Sys.time(), "%d%m%Y"), ".png"), dpi = 320, width = 6, height = 6)
