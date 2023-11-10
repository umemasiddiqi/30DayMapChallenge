##################################
###     30 Day Map Challenge   ###
###      Nov 10, 2023.         ###
###      Day 10: North America ###
###      Umema A. Siddiqi      ###
##################################

# libraries --------------------------------------------------------------------

library(WDI)
library(tidyverse)
library(magrittr)
library(ggthemes)
library(rnaturalearth)
library(viridis) 

### Make a comparative chart 

#2. Check the WDI for the desired indicator -----------------------------------
WDIsearch('intentional homicide')

#3. Using the specific indicator and comparing US and Mexico ----------
homi_data = WDI(indicator='VC.IHR.PSRC.P5', country=c('US', 'MX'), start=2000, end=2021)

#4. Plotting the comparative results -------------------------------------------
my_palette = c("#DA0000", "#355E3B")

homi_graph <- ggplot(homi_data, aes(year, VC.IHR.PSRC.P5, color =  country)) + 
  geom_line(size = 1.4) +
  labs(title = "Intentional Homicide (per 100,000 people)",
       subtitle = "In US & Mexico from 2000 to 2021",
       x = "Year",
       y = "Homicide (per 100k people)",
       color = " ") +
  scale_color_manual(values = my_palette)

homi_graph + 
  ggthemes::theme_fivethirtyeight() + 
  theme(
    plot.title = element_text(size = 30), 
    axis.title.y = element_text(size = 20),
    axis.title.x = element_text(size = 20))

#5. To save this chart ---------------------------------------------------------
ggsave(paste0("Homi_US_MX_", format(Sys.time(), "%d%m%Y"), ".png"), dpi = 320, width = 12, height = 8)


#6. Now lets see the Homicide in North America ---------------------------------------
na_map <- ne_countries(scale = "medium", continent = 'South America', returnclass = "sf")

#7. 
homi_rates = WDI(indicator='VC.IHR.PSRC.P5', start=2000, end=2021)

#8. Merge the homicide rates with North America map -----------------------------------------
na_rates <- merge(na_map, homi_rates, by.x = "iso_a2", by.y = "iso2c", all = TRUE)

#9. If we want to see the Homicide for one year only --------------------------------
na_map_2021 <- na_rates [which(na_rates$year == 2021),]

#10. To plot it all ------------------------------------------------------------
na_rates_graph <- ggplot(data = na_map_2021) +
  geom_sf(aes(fill = VC.IHR.PSRC.P5), 
          position = "identity") + 
  labs(fill ='') +
  labs(title = "Intentional Homicide (per 100,000 people)")+
  labs(caption = "#30DayMapChallenge | Day 10: North America | Design: U. Siddiqi")+
  scale_fill_viridis_c(option = "viridis")

na_rates_graph + theme_map()

#11. Let's save this plot ------------------------------------------------------
ggsave(paste0("Homi_NA_", format(Sys.time(), "%d%m%Y"), ".png"), dpi = 320, width = 12, height = 12)
