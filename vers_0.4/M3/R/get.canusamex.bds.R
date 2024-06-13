# ###########################################################
# PURPOSE: Obtain outlines of Canada, USA, and Mexico, including
# state lines.
#
#
# INPUT: No input arguments.
#
# 
# RETURNS: A data frame containing the coordinates (longitude and latitude) to
#   draw the outlines for Canada, USA (with state lines), and Mexico.
#
##
# REVISION HISTORY:
#   Original release: Jenise Swall, 2012-05-15
#
#   2024-06-12 (JLS): The coordinates are now stored in an data frame which
#     is distributed with the package, rather than being calculated within
#     this function.
# ###########################################################
get.canusamex.bds <- function(){

  # Pull the object from the stored data and return.
  return(canusamex_bds)
}
