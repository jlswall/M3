\name{get.map.lines.M3.proj}
\alias{get.map.lines.M3.proj}

\title{Get map lines in the model projection units}

\description{Get map lines in the model projection units.
}


\usage{
get.map.lines.M3.proj(file, region = "state", units, ...)
}


\arguments{
  \item{file}{File name of Models3-formatted file providing the model
    projection.
  }
  \item{region}{Geogrpaphical database to use.  Choices are "state"
    (default), "world", "USA", "county", and any other databases which
    are included with the \pkg{maps} package and which can be passed to
    the \code{\link[maps]{map}} function.  Default is "state".
  }
  \item{units}{Units for coordinates of grid rows or columns.  Must be
    one of \dQuote{m}, \dQuote{km}, or \dQuote{deg}.  If
    unspecified, the default is \dQuote{deg} if the file has a
    longitude/latitude grid, and \dQuote{km} otherwise.
  }
  \item{\dots}{Other arguments to pass to \code{get.proj.info.M3}
  function.  In this case, the only relevant argument would be the
  earth radius to use for the projection in \code{file}.
  }
}


\details{This function depends on the \pkg{maps} package to get the appropriate
  map boundary lines (for states, counties, etc.), \pkg{ncdf4} to read
  the projection information from the Models3-formatted file (using a
  call to function \code{get.proj.info.M3}), and \pkg{rgdal}
  (which is an interface to GDAL (Geospatial Data Abstraction Library,
  \url{http://www.gdal.org}) to project the boundary lines to the
  specified projection.
}


\value{Map lines for the projection described in \code{file} in either
  kilometers or meters (depending on value of units.km).  This is a
  matrix, with x-coordinates in the first column and y-coordinates in
  the second column.
}


\references{\url{http://www.gdal.org}
}


\author{Jenise Swall}


\section{Warning}{This function will only work with Lambert conic
  conformal or polar stereographic projections.
}


\seealso{\code{\link{get.proj.info.M3}}, \code{\link[maps]{map}}, \code{\link[rgdal]{project}}
}


\examples{
## Find the path to the demo file.
polar.file <- system.file("extdata/surfinfo_polar.ncf", package="M3")

## Read in the terrain elevation variable.
elev <- get.M3.var(file=polar.file, var="HT")
## Make a plot.
image(elev$x.cell.ctr, elev$y.cell.ctr, elev$data[,,1],
      xlab="Projection x-coord (km)", ylab="Projection y-coord (km)",
      zlim=range(elev$data[,,1]), col=heat.colors(15))

## Superimpose national boundaries on the plot
nat.bds <- get.map.lines.M3.proj(file=polar.file, region="world")$coords
lines(nat.bds)


## Subset to a smaller geographic area in southwestern U.S.
subset.elev <- var.subset(elev, llx=-2000, urx=0, lly=-6500, ury=-4000)
## Make a plot of this subset.
image(subset.elev$x.cell.ctr, subset.elev$y.cell.ctr,
      subset.elev$data[,,1], xlab="Projection x-coord (km)",
      ylab="Projection y-coord (km)", zlim=range(subset.elev$data[,,1]),
      col=heat.colors(15))

##  Superimpose U.S. state boundaries on the plot.
state.bds <- get.map.lines.M3.proj(file=polar.file)$coords
lines(state.bds)
}