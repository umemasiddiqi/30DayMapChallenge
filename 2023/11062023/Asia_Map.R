##################################
###   30 Day Map Challenge     ###
###      Nov 6, 2023.          ###
###      Day 6: Asia Map       ###
####    Umema A. Siddiqi      ####
##################################

# libraries ----------------------------------------------------------------------------------------
library(rnaturalearth)
library(ggplot2)
library(viridis)

# Get a world map ----------------------------------------------------------------------------------
world_map <- ne_countries(scale = "medium", returnclass = "sf")

# Filter the world map to include only Asian countries ---------------------------------------------
asia_map <- world_map[world_map$region_un %in% "Asia", ]

# Extract unique values from the "income group" variable -------------------------------------------
unique_income <- unique(asia_map$income_grp)

# Print the unique categories ----------------------------------------------------------------------
print(unique_income)

# Define a gradient color palette ------------------------------------------------------------------
palette <- viridis_pal(option = "D")(length(unique(asia_map$income_grp)))

# Create a ggplot to map the "income group" variable with the gradient color palette ---------------
ggplot(asia_map) +
  geom_sf(aes(fill = factor(income_grp)), color = "black") +
  scale_fill_manual(values = palette) +
  labs(
    title = "Income Group of Asian Countries",
    fill = "Income Groups",
    caption = "#30DayMapChallenge | Day 6: Asia | Design: U. Siddiqi"
  ) +
  theme_minimal()

# save plot ----------------------------------------------------------------------------------------
ggsave(paste0("asia_", format(Sys.time(), "%d%m%Y"), ".png"), dpi = 320, width = 6, height = 6)
