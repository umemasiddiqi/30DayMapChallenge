##################################
###     30 Day Map Challenge   ###
###      Nov 14, 2023.         ###
###      Day 14: Europe        ###
###      Umema A. Siddiqi      ###
##################################

# libraries --------------------------------------------------------------------

library(giscoR)
library(dplyr)
library(sf)
library(ggplot2)

epsg_code <- 3035

# European countries -----------------------------------------------------------

EU_countries <- gisco_get_countries(region = "EU") %>%
  st_transform(epsg_code)

# Countries centroids
symbol_pos <- st_centroid(EU_countries, of_largest_polygon = TRUE)

# Countries airports
airports <- gisco_get_airports(country = EU_countries$ISO3_CODE) %>%
  st_transform(epsg_code)

number_airport <- airports %>%
  st_drop_geometry() %>%
  group_by(CNTR_CODE) %>%
  summarise(n = n())

labels_n <-
  symbol_pos %>%
  left_join(number_airport,
            by = c("CNTR_ID" = "CNTR_CODE")) %>%
  arrange(desc(n))

# Bubble choropleth map --------------------------------------------------------

ggplot() +
  geom_sf(data = EU_countries, fill = "grey95") +
  geom_sf(
    data = labels_n,
    pch = 21,
    aes(size = n, fill = n),
    col = "grey20") +
  xlim(c(2200000, 7150000)) +
  ylim(c(1380000, 5500000)) +
  scale_size(
    range = c(1, 9),
    guide = guide_legend(
      direction = "horizontal",
      nrow = 1,
      label.position = "bottom")) +
  scale_fill_gradientn(colours = hcl.colors(5, "RdBu",
                                            rev = TRUE,
                                            alpha = 0.9)) +
  guides(fill = guide_legend(title = "")) +
  labs(title = "Airports by Country (2013)",
       sub = "European Union",
       caption = "\n #30DayMapChallenge | Day 14: Europe | Design: U. Siddiqi\n\n",
       size = "") +
  theme_void() +
  theme(legend.position = "bottom")

#Save plot ---------------------------------------------------------------------

ggsave(paste0("Eur_Airports_", format(Sys.time(), "%d%m%Y"), ".png"), dpi = 320, width = 10, height = 12)

# Help taken from a tutorial at R-charts
       
