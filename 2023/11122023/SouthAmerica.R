##################################
###     30 Day Map Challenge   ###
###      Nov 12, 2023.         ###
###      Day 12: South America ###
###      Umema A. Siddiqi      ###
##################################

# libraries --------------------------------------------------------------------

library(viridis)
library(ggplot2)
library(prisonbrief) 

#Get data ----------------------------------------------------------------------

south_america <- wpb_table(region = "South America") #Using data from World Prison Brief

#Plot --------------------------------------------------------------------------

ggplot(south_america, aes(fill = prison_population_rate)) +
  geom_sf() +
  scale_fill_viridis_c(option = "D")+
  labs(
    title = "Prison Population Rate 2022-23",
    caption = "#30DayMapChallenge | Day 12: South America | Design: U. Siddiqi"
  ) +
  theme(
    panel.border = element_rect(color = "black", fill = NA, size = 1),
    legend.position = "right", 
    plot.title = element_text(size = 18, hjust = 0.5),  
    plot.caption = element_text(size = 12, hjust = 0.5)  
  ) +
  guides(fill = guide_colorbar(title = "Prison population rate\n(per 100,000 of national population)"))

#To save the plot --------------------------------------------------------------

ggsave(paste0("SA_PrisonPop_", format(Sys.time(), "%d%m%Y"), ".png"), dpi = 320, width = 20, height = 10)
