\name{get.canmex.bds}
\alias{get.canmex.bds}

\title{Obtain outlines of Canada and Mexico}

\description{Obtain outlines of Canada and Mexico (not including
  boundaries with USA) in longitude/latitude.
}


\usage{get.canmex.bds()
}


\details{This function depends on the \pkg{maps} package to get the
  appropriate map boundary lines from the (somewhat low-resolution)
  \dQuote{world} database.  The function finds and removes the outline
  of the USA, as well as the boundaries between Canada/USA and
  USA/Mexico.  This allows the user to draw in the USA with the higher
  resolution maps in the other \pkg{maps} package databases, such as
  \dQuote{state}.  Otherwise, the low-resolution USA boundaries in the
  \dQuote{world} database conflict with the boundaries given in database
  \dQuote{state}.  This function is intended to be called by the
  function \code{\link{get.map.lines.M3.proj}}; in practice, it would
  rarely be called directly by the user.}


\value{Matrix specifying the polylines needed to plot the outlines of Canada
  and Mexico.  This matrix has two columns, with longitude in the first
  column and latitude in the second.
}


\author{Jenise Swall}


\seealso{\code{\link[maps]{map}}, \code{\link{get.map.lines.M3.proj}}
}


\examples{
## Set up a plotting region (in longitude/latitude) that includes an
## eastern portion of the Canada/USA border.
plot(c(-82,-67), c(39,49), type="n", xlab="Longitude", ylab="Latitude")
## Superimpose national boundaries from "world" database, which is
## fairly low-resolution (since it includes worldwide national boundaries).
map("world", region="canada", add=TRUE)
## Now, if we try to superimpose the the USA state boundaries from the
## higher resolution "state" database, we have a conflict.  (See
## particularly the Maine border.)
map("state", add=TRUE, col="blue")

## Instead, we get Canadian/Mexican boundaries, excluding the borders
## with the US.  We overlay this onto our region, and then plot the
## US states.
X11()
plot(c(-82,-67), c(39,49), type="n", xlab="Longitude", ylab="Latitude")
lines(get.canmex.bds())
map("state", add=TRUE, col="blue")
}