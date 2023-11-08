##################################
###     30 Day Map Challenge   ###
###      Nov 8, 2023.          ###
###      Day 8: Africa         ###
###      Umema A. Siddiqi      ###
##################################

# libraries --------------------------------------------------------------------

library(WDI)
library(tidyverse)
library(magrittr) 
library(ggthemes)
library(rnaturalearth)
library(viridis) # for pretty colors


#2. Check the WDI for your desired indicator -----------------------------------
WDIsearch('fertility rate') # it will yield a sub list, so you can choose your indicator code from there

#3. Using the specific indicator and comparing Niger (NE) and South Africa (ZA) ----------
tfr_data = WDI(indicator='SP.DYN.TFRT.IN', country=c('NE', 'ZA'), start=1980, end=2021)

#4. Plotting the comparative results -------------------------------------------
# only to show that there's a vast difference in TFR across Africa
my_palette = c("#DA0000", "#239f40")

tfr_graph <- ggplot(tfr_data, aes(year, SP.DYN.TFRT.IN, color =  country)) + 
  geom_line(size = 1.4) +
  labs(title = "Total Fertility Rate (births per woman)",
       subtitle = "In Niger & South Africa from 1980 to 2021",
       x = "Year",
       y = "TFR (births per woman)",
       color = " ") +
  scale_color_manual(values = my_palette)

tfr_graph + 
  ggthemes::theme_fivethirtyeight() + 
  theme(
    plot.title = element_text(size = 30), 
    axis.title.y = element_text(size = 20),
    axis.title.x = element_text(size = 20))

#5. To save this chart ---------------------------------------------------------
ggsave(paste0("TFR_NE_ZA_", format(Sys.time(), "%d%m%Y"), ".png"), dpi = 320, width = 10, height = 6)


#6. Now lets see the TFR in whole Africa ---------------------------------------
africa_map <- ne_countries(scale = "medium", continent = 'Africa', returnclass = "sf")

#7. 
tf_rates = WDI(indicator='SP.DYN.TFRT.IN', start=1980, end=2021)

#8. Merge the tf rates with Africa map -----------------------------------------
africa_rates <- merge(africa_map, tf_rates, by.x = "iso_a2", by.y = "iso2c", all = TRUE)

#9. If we want to see the TFR for one year only --------------------------------
map_2021 <- africa_rates [which(africa_rates$year == 2021),]

#10. To plot it all ------------------------------------------------------------
africa_rates_graph <- ggplot(data = map_2021) +
  geom_sf(aes(fill = SP.DYN.TFRT.IN), 
          position = "identity") + 
  labs(fill ='TFR (births per woman)') +
  labs(title = "Total Fertility Rate (births per woman)", caption = "#30DayMapChallenge | Day 8: Africa | Design: U. Siddiqi")+
  scale_fill_viridis_c(option = "viridis")

africa_rates_graph + theme_map()

#11. Let's save this plot ------------------------------------------------------
ggsave(paste0("TFR_Africa_", format(Sys.time(), "%d%m%Y"), ".png"), dpi = 320, width = 6, height = 6)

