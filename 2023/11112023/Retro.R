##################################
###     30 Day Map Challenge   ###
###      Nov 11, 2023.         ###
###      Day 11: Retro         ###
###      Umema A. Siddiqi      ###
##################################

# libraries --------------------------------------------------------------------

library(ggplot2)
library(dplyr)
library(maps)
library(viridis)
theme_set(
  theme_void() +
    theme(plot.background = element_rect(fill = "white"))
)

#Get Data ----------------------------------------------------------------------

data("USArrests")

arrests <- USArrests 
arrests$region <- tolower(rownames(USArrests))
head(arrests)

# Retrieve the states map data and merge with crime data -----------------------

states_map <- map_data("state")
arrests_map <- left_join(states_map, arrests, by = "region")

# Create the map ---------------------------------------------------------------

ggplot(arrests_map, aes(long, lat, group = group))+
  geom_polygon(aes(fill = Assault), color = "white")+
  scale_fill_viridis_c(option = "G")+
  labs(
    title = "Arrests per 100,000 residents for Assault in 1973",
    caption = "#30DayMapChallenge | Day 11: Retro | Design: U. Siddiqi"
  ) +
  theme(
    panel.border = element_rect(color = "black", fill = NA, size = 1),
    legend.position = "right", 
    plot.title = element_text(size = 18, hjust = 0.5),  
    plot.caption = element_text(size = 14, hjust = 0.5)  
  )

#To save the plot --------------------------------------------------------------

ggsave(paste0("US_Assaults_", format(Sys.time(), "%d%m%Y"), ".png"), dpi = 320, width = 20, height = 10)
