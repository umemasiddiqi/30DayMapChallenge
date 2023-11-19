##################################
###     30 Day Map Challenge   ###
###      Nov 17, 2023.         ###
###      Day 17: Flow          ###
###      Umema A. Siddiqi      ###
##################################

# libraries --------------------------------------------------------------------

library(maps)
library(geosphere)

# fetching maps & restricting to US only ---------------------------------------
map("state")

map("world")

xlim <- c(-120.738281, -89.601563)
ylim <- c(12.039321, 51.856229)
map("world", col="#f2f2f2", fill=TRUE, bg="white", lwd=0.05, xlim=xlim, ylim=ylim)

# identifying & mapping cities where mum's visiting ----------------------------
lat_austin <- 30.266666
lon_austin <- -97.733330
lat_frisco <- 33.155373
lon_frisco <- -96.818733
lat_la <- 34.052235
lon_la <- -118.243683
lat_chicago <- 41.881832
lon_chicago <- -87.623177
lat_nj <- 39.833851
lon_nj <- -74.871826

inter <- gcIntermediate(c(lon_frisco, lat_frisco), c(lon_austin, lat_austin), n=50, addStartEnd=TRUE)
lines(inter, col="red")

inter <- gcIntermediate(c(lon_frisco, lat_frisco), c(lon_la, lat_la), n=50, addStartEnd=TRUE)
lines(inter, col="darkblue")

inter <- gcIntermediate(c(lon_la, lat_la), c(lon_frisco, lat_frisco), n=50, addStartEnd=TRUE)
lines(inter, col="darkgreen")

inter <- gcIntermediate(c(lon_frisco, lat_frisco), c(lon_chicago, lat_chicago), n=50, addStartEnd=TRUE)
lines(inter, col="orange")

inter <- gcIntermediate(c(lon_frisco, lat_frisco), c(lon_nj, lat_nj), n=50, addStartEnd=TRUE)
lines(inter, col="maroon")

# Adding title and caption -----------------------------------------------------

mtext("Mum's travel in the US", line = 0.5, cex = 1.5, font = 2)

mtext("#30DayMapChallenge | Day 17: Flow | Design: U. Siddiqi", side = 1, line = 4, cex = 0.8, font = 3)

