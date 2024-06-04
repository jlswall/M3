\name{get.canusamex.bds}
\alias{get.canusamex.bds}

\title{Obtain map boundaries for Canada, USA, and Mexico}

\description{Obtain map boundaries of Canada, USA, and Mexico, including
  state boundaries, in longitude/latitude.
}


\usage{get.canusamex.bds()
}


\details{This function depends on the \pkg{maps} and \pkg{mapdata}
  packages to get the appropriate map boundary lines.  The function uses
  the high-resolution boundaries (\dQuote{worldHires} database) in the
  \pkg{mapdata} to find the coastlines and national boundaries for
  Canada, the USA, and Mexico.  Then, it appends the state boundaries
  (in \dQuote{state} from the \pkg{maps} package), removing the
  coastlines and national boundaries so that they don't conflict with
  the higher-resolution ones (from \dQuote{worldHires}). This allows the
  user to draw the national and state boundaries with high-resolution
  and without with conflicting boundaries yielded by the \dQuote{world}
  database.  This function is intended to be called by the function
  \code{\link{get.map.lines.M3.proj}}; in practice, it would rarely be
  called directly by the user.
}


\value{Matrix specifying the polylines needed to plot the national
  (Canada, USA, Mexico) and state outlines. This matrix has two columns,
  with longitude in the first column and latitude in the second.  }


\author{Jenise Swall}


\seealso{\code{\link[maps]{map}}, \code{\link{get.map.lines.M3.proj}}
}


\examples{
## Set up a plotting region (in longitude/latitude) that includes an
## eastern portion of the Canada/USA border.
plot(c(-82,-67), c(39,49), type="n", xlab="Longitude", ylab="Latitude")
## Superimpose national boundaries from "world" database, which is
## fairly low-resolution (since it includes worldwide national boundaries).
map("world", regions="canada", add=TRUE)
## Now, if we try to superimpose the the USA state boundaries from the
## higher resolution "state" database, we have a conflict.  (See
## particularly the Maine border.)
map("state", add=TRUE, col="blue")
## The high-resolution national boundaries in database "worldHires" (in
## mapdata) also don't match up with the state lines.
map("worldHires", add=TRUE, col="magenta")

## Instead, we get the national boundaries (Canada, USA, Mexico) at
## high-resolution from database "worldHires" and the state boundaries
## (without the coastlines and national boundaries) from the "state"
## database.
dev.new()
plot(c(-82,-67), c(39,49), type="n", xlab="Longitude", ylab="Latitude")
lines(get.canusamex.bds())
}