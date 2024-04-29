## ###########################################################
## PURPOSE: Obtain outlines of Canada and Mexico, WITHOUT including
##   the borders between Canada/USA or USA/Mexico.  The user can then
##   use a higher-resolution database like "state" to plot USA
##   boundaries on (at higher resolution than is available for the
##   boundaries of Canada or Mexico.).
## 
## INPUT:
##   No input arguments.
## 
## RETURNS: A list containing two elements "coords" and "units", The
##   element "coords" contains a matrix with the map lines in the
##   projection coordinates.  The element "units" contains the units
##   of the coordinates ("km" or "m").
##
## ASSUMES:
##   Availability of R packages maps.
##
##
## REVISION HISTORY:
##   Original release: Jenise Swall, 2012-01-11
## ###########################################################
get.canmex.bds <- function(){

  ## Get maps of Canada, USA, Mexico.
  canusmex <- map("world", region=c("Canada", "USA", "Mexico"), exact=F,
                  resolution=0, plot=F)
  canusmex.lonlat <- cbind(canusmex$x, canusmex$y)
  rm(canusmex)

  ## Get map of just USA.
  us <- map("world", region="USA", exact=F, resolution=0, plot=F)
  us.lonlat <- cbind(us$x, us$y)
  rm(us)

  ## See if we can find which ones are duplicated.  These are the
  ## borders of the US, and we'll want to delete them.
  ## Remove NAs from us.lonlat.
  us.lonlat.noNA <- na.omit(us.lonlat)
  rm (us.lonlat)
  

  ## Find matrix which has the distances between all the points.  We
  ## look at the subset of the matrix giving the distances between the
  ## US boundaries (us.lonlat.noNA) and the boundary lines for Canada,
  ## US, and Mexico.
  dist.mat <- as.matrix(dist(rbind(us.lonlat.noNA, canusmex.lonlat)))[1:nrow(us.lonlat.noNA), (nrow(us.lonlat.noNA)+1):(nrow(us.lonlat.noNA)+nrow(canusmex.lonlat))]
  
  ## Identify the non-duplicates (points that define borders of Canada
  ## and Mexico, but not the US) by checking each column to see if it is
  ## non-zero.  The duplicates may be excluded in some cases (they may
  ## be obtained by adding on state boundaries), but the non-duplicates
  ## are crucial to define the outlines of Canada and Mexico.
  is.zero <- (dist.mat==0) & (!is.na(dist.mat))
  count.zero.per.col <- apply(is.zero, 2, sum)
  indic.non.dupl <- count.zero.per.col == 0
  rm(dist.mat, is.zero, count.zero.per.col)
  

  ## Loop through the vector indic.non.dupl, which shows which points
  ## are duplicates.  (The first point is a special case, so we do
  ## that outside the loop to make the control logic in the loop
  ## easier.)  All points that are non-duplicates will be included in
  ## the new map.  Some points which are duplicates will be included
  ## if they are adjacent to non-duplicate points.  This is necessary
  ## to retain the connecting line segments between the US border
  ## and the Canadian/Mexican borders.
  {
    if (indic.non.dupl[1])
      new.map <- canusmex.lonlat[1,]
    else
      new.map <- NULL
  }
  for (i in 2:length(indic.non.dupl)){
    ## If point i is not a duplicate, it will be included in the new
    ## map.  In addition, we test the previous point.  If the previous
    ## point WAS a duplicate, then we need to add a row of NAs, this
    ## previous point (i-1), and point i to the map.  This allows for
    ## the inclusion of the line segment between the US and
    ## Canadian/Mexican borders.
    if (indic.non.dupl[i]){
      if (indic.non.dupl[i-1])
        new.map <- rbind(new.map, canusmex.lonlat[i,])
      else{
        new.map <- rbind(new.map, c(NA, NA))
        new.map <- rbind(new.map, canusmex.lonlat[(i-1):i,])
      }
    }
    
    ## If point i is a duplicate, then check the previous point (i-1).
    ## If the previous point was not a duplicate, we include this
    ## point i.  This allows for the inclusion of the line segment
    ## between the US and Canadian/Mexican borders.
    else{
      if ( indic.non.dupl[i-1] )
        new.map <- rbind(new.map, canusmex.lonlat[i,])
    }
  }


  ## Return the boundaries to the calling program/function.
  return(new.map)
}
