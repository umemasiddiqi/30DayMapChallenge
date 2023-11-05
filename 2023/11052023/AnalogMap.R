##################################
###   30 Day Map Challenge     ###
###      Nov 5, 2023.          ###
###      Day 5: Analog Map     ###
###     Umema A. Siddiqi       ###
##################################

# Load required libraries
library(jpeg)
library(grid)

# Read and import the JPEG image
image_path <- "C:/Users/uy128/Desktop/Academics/30DayMapChallenge/Pakistan-Embroidery-Map.jpg"  
image <- readJPEG(image_path)

# Set preferred width and height in millimeters
custom_width_mm <- 150  
custom_height_mm <- 170   

# Create a grid object with the image
grid.newpage()
grid.raster(image, width = unit(custom_width_mm, "mm"), height = unit(custom_height_mm, "mm"))

# Add title and caption with customized font size and color
title <- "Pakistani Embroidery Map"
caption <- "#30DayMapChallenge | Day 5: Analog Map | Design: U. Siddiqi"

# Define custom graphical parameters (font size and color)
title_gp <- gpar(fontsize = 12, col = "darkblue")  
caption_gp <- gpar(fontsize = 8, col = "maroon")  

grid.text(title, x = unit(0.5, "npc"), y = unit(0.95, "npc"), just = "center", gp = title_gp)
grid.text(caption, x = unit(0.5, "npc"), y = unit(0.05, "npc"), just = "center", gp = caption_gp)

#ggsave didn't work because the output file was too big and R crashed every time I tried it :(
