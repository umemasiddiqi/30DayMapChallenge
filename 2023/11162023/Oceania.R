##################################
###     30 Day Map Challenge   ###
###      Nov 16, 2023.         ###
###      Day 16: Oceania       ###
###      Umema A. Siddiqi      ###
##################################

# libraries --------------------------------------------------------------------

library(spData)
library(tmap)    
library(viridis)
library(ggplot2)

# Load the nz dataset from spData ----------------------------------------------
nz <- spData::nz

# Plot the map with city populations in New Zealand ----------------------------
ggplot() +
  geom_sf(data = nz, aes(fill = Population)) +
  scale_fill_viridis_c(option = "viridis", name = "City Population") +
  theme_minimal() +
  labs(title = "New Zealand City Populations Choropleth",
       caption = "#30DayMapChallenge | Day 16: Oceania | Design: U. Siddiqi")

#To save the plot --------------------------------------------------------------

ggsave(paste0("Oceania_Pop_", format(Sys.time(), "%d%m%Y"), ".png"), dpi = 320, width = 20, height = 10)
