###############################################
###     30 Day Map Challenge                ###
###      Nov 28, 2023.                      ###
###      Day 28: Is this a chart or a map?  ###
###      Umema A. Siddiqi                   ###
###############################################

# libraries --------------------------------------------------------------------

library(maps)
library(socviz)
library(ggplot2)

#Fetch data

us_states <- map_data("state")
head(us_states)

county_map %>% sample_n(5)

county_data %>%
  select(id, name, state, hh_income) %>%
  sample_n(5)

county_full <- left_join(county_map, county_data, by = "id")

#To plot

p <- ggplot(data = county_full,
            mapping = aes(x = long, y = lat,
                          fill = hh_income, 
                          group = group))

p1 <- p + geom_polygon(color = "gray90", size = 0.05) + coord_equal()

p2 <- p1 + scale_fill_viridis_c(name = "Household Income",
                                labels = scales::comma_format())  

p2 +
  labs(
    title = "Median Household Income, 2013",
    caption = "#30DayMapChallenge | Day 28: Is this a chart or a map? | Design: U. Siddiqi"
  ) +
  theme_map() +
  guides(fill = guide_legend(nrow = 1)) + 
  theme(legend.position = "bottom")

#To save the plot
ggsave(paste0("ChartorMap_", format(Sys.time(), "%d%m%Y"), ".png"), dpi = 320, width = 6, height = 6)

