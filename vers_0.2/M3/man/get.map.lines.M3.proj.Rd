\name{get.map.lines.M3.proj}
\alias{get.map.lines.M3.proj}

\title{Get map lines in the model projection units}

\description{Get map lines in the model projection units.
}


\usage{
get.map.lines.M3.proj(file, database = "state", units, ...)
}


\arguments{
  \item{file}{File name of Models3-formatted file providing the model
    projection.
  }
  \item{database}{Geographical database to use.  Choices include
    \dQuote{state} (default), \dQuote{world}, \dQuote{canmex}, etc.
    Use \dQuote{canmex} to get the outlines of Canada and Mexico,
    without the border lines between Canada/USA or USA/Mexico.  The
    other choices (\dQuote{state}, \dQuote{world}, etc.)
    are the names of databases included with the \pkg{maps} package.
    (See the \code{\link[maps]{map}} function.)  Default is \dQuote{state}.
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


\seealso{\code{\link{get.proj.info.M3}}, \code{\link[maps]{map}},
  \code{\link[rgdal]{project}}, \code{\link{get.canmex.bds}}
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
nat.bds <- get.map.lines.M3.proj(file=polar.file, database="world")$coords
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
## Superimpose Mexico national outline on the plot, without overriding
## state boundaries along the Mexican border (since they are given by
## higher-resolution "state" database).
canmex.bds <- get.map.lines.M3.proj(file=polar.file, "canmex")$coords
lines(canmex.bds)
}