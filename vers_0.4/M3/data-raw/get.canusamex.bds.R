# ###########################################################
# PURPOSE: Build a data frame with the longitude and latitude coordinates for
# the outlines of Canada, USA, and Mexico, including state lines.
#
#
# INPUT: No input arguments.
#
# 
# ASSUMES:
#   Availability of R packages maps and mapdata.
#
#
# REVISION HISTORY:
#   Original release: Jenise Swall, 2024-06-10
#     Built on previous function get.canusamex.bds(), which has been removed
#     from the M3 package.  We now build the dataset in advance, so that we
#     can save the time it would take to build it with each use.
# ###########################################################

library(maps)
library(mapdata)

# Get maps of Canada, USA, Mexico in high-resolution from mapdata
# package.
canusamex.natl <- map("worldHires", regions=c("Canada", "USA", "Mexico"),
                      exact=FALSE, resolution=0, plot=FALSE)
canusamex.natl.lonlat <- cbind(canusamex.natl$x, canusamex.natl$y)
rm(canusamex.natl)


# Get map of state borders, without including the outer boundaries.
# These outer boundaries are provided by the the high-resolution
# national maps created in the previous step.
state <- map("state", exact=F, boundary=FALSE, resolution=0, plot=FALSE)
state.lonlat <- cbind(state$x, state$y)
rm(state)


# Put it national and state boundaries together.
canusamexMat <- rbind(canusamex.natl.lonlat, matrix(NA, ncol=2), state.lonlat)
canusamex_bds <- data.frame(long=canusamexMat[,1], lat=canusamexMat[,2])
rm(canusamex.natl.lonlat, state.lonlat, canusamexMat)


# To save these boundaries in csv file for a human-readable format.
# write.csv(canusamex_bds, file="canusamex_bds.csv", row.names=FALSE)

# Save these boundaries in R data format.
save(canusamex_bds, file="../R/sysdata.rda", version=2)


