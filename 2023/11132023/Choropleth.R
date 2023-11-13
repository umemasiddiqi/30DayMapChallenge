##################################
###     30 Day Map Challenge   ###
###      Nov 13, 2023.         ###
###      Day 13: Choropleth    ###
###      Umema A. Siddiqi      ###
##################################

# libraries --------------------------------------------------------------------

library(WDI)
library(tidyverse)
library(magrittr) 
library(ggthemes)
library(rnaturalearth)
library(viridis) 

# To see the TFR in whole world ---------------------------------------
world_map <- ne_countries(scale = "medium", continent = c( 'Africa', 'Asia', 'North America', 'South America', 'Europe', 'Oceania'), returnclass = "sf")

# We then select the WDI indicator for TFR 
tf_rates = WDI(indicator='SP.DYN.TFRT.IN', start=2021, end=2021)

# Merge the tf rates with world map -----------------------------------------
world_rates <- merge(world_map, tf_rates, by.x = "iso_a2", by.y = "iso2c", all = TRUE)

# If we want to see the TFR for one year only --------------------------------
map_2021 <- world_rates [which(world_rates$year == 2021),]

# To plot it ------------------------------------------------------------
world_rates_graph <- ggplot(data = map_2021) +
  geom_sf(aes(fill = SP.DYN.TFRT.IN), 
          position = "identity") + 
  labs(fill ='TFR in 2021') +
  labs(title = "Total Fertility Rate (births per woman)", caption = "#30DayMapChallenge | Day 13: Choropleth | Design: U. Siddiqi")+
  scale_fill_viridis_c(option = "viridis")

world_rates_graph + theme_map()

#11. Let's save this plot ------------------------------------------------------
ggsave(paste0("world_TFR_", format(Sys.time(), "%d%m%Y"), ".png"), dpi = 320, width = 12, height = 8)
