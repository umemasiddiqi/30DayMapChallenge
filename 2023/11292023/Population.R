##################################
###     30 Day Map Challenge   ###
###      Nov 29, 2023.         ###
###      Day 29: Population    ###
###      Umema A. Siddiqi      ###
##################################

# Libraries --------------------------------------------------------------------
library(maps)
library(socviz)
library(ggplot2)

# Fetch the data ---------------------------------------------------------------
us_states <- map_data("state")
head(us_states)


county_map %>% sample_n(5)

county_data %>%
  select(id, name, state, pop_dens, pct_black) %>%
  sample_n(5)

county_full <- left_join(county_map, county_data, by = "id")

# Make plots --------------------------------------------------------------------

p <- ggplot(data = county_full,
            mapping = aes(x = long, y = lat,
                          fill = pop_dens, 
                          group = group))

p1 <- p + geom_polygon(color = "gray90", size = 0.05) + coord_equal()

p2 <- p1 + scale_fill_brewer(palette="Blues",
                             labels = c("0-10", "10-50", "50-100", "100-500",
                                        "500-1,000", "1,000-5,000", ">5,000"))

p2 +
  labs( fill = "Population per\nsquare mile",
    title = "Population Density, 2014",
    caption = "#30DayMapChallenge | Day 29: Population | Design: U. Siddiqi"
  ) +
  theme_map() +
  guides(fill = guide_legend(nrow = 1)) + 
  theme(legend.position = "bottom")

# To save the plot --------------------------------------------------------------

ggsave(paste0("Population_", format(Sys.time(), "%d%m%Y"), ".png"), dpi = 320, width = 6, height = 6)




