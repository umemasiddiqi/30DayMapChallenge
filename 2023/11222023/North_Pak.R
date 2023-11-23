############################################
###     30 Day Map Challenge             ###
###      Nov 22, 2023.                   ###
###      Day 22: North is not always Up  ###
###      Umema A. Siddiqi                ###
############################################

# libraries --------------------------------------------------------------------
library(maps)
library(ggplot2)
library(mapproj)
library(grid)

# Load world dataset -----------------------------------------------------------
world <- map_data("world")

# Extract data for Pakistan
pakistan <- subset(world, region == "Pakistan")

# City coordinates -------------------------------------------------------------
cities <- data.frame(
  city = c("Karachi", "Lahore", "Islamabad", "Peshawar", "Quetta"),
  lon = c(67.0011, 74.3587, 73.0479, 71.5249, 67.0082),
  lat = c(24.8607, 31.5204, 33.6844, 35.2220, 30.1798)
)

# Create a lateral map of Pakistan ---------------------------------------------
map <- ggplot() +
  geom_polygon(data = pakistan, aes(x = long, y = lat, group = group),
               fill = "lightblue", color = "white", size = 0.3) +
  
  geom_text(data = cities, aes(x = lon, y = lat, label = city),
            size = 3, vjust = -0.5, hjust = 0.5, color = "black") +
  
  labs(title = "Where's North of Pakistan?",
       caption = "#30DayMapChallenge | Day 22: North is not always up | Design: U. Siddiqi") +
  
  theme_minimal() +
  theme(legend.position = "none")

print(map)

# Add a north arrow ------------------------------------------------------------
arrow_data <- data.frame(
  lon_start = 70,
  lat_start = 35,
  lon_end = 68,
  lat_end = 37,
  label = "↑ North",
  color = "red"
)

map_with_arrow <- map +
  geom_segment(
    data = arrow_data,
    aes(x = lon_start, y = lat_start, xend = lon_end, yend = lat_end),
    arrow = arrow(length = unit(0.2, "inches"), type = "closed"),
    color = arrow_data$color, size = 1
  ) +
  geom_text(data = arrow_data, aes(x = lon_end, y = lat_end, label = label),
            size = 5, color = arrow_data$color)

print(map_with_arrow)

# Save plot --------------------------------------------------------------------
ggsave(paste0("North_Pak_", format(Sys.time(), "%d%m%Y"), ".png"), dpi = 320, width = 10, height = 10)
