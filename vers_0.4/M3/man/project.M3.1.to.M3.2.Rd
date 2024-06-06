\name{project.M3.1.to.M3.2}
\alias{project.M3.1.to.M3.2}

\title{ Project coordinates based on projection in the first file to
  the projection given in the second
}

\description{Project coordinates based on projection in the first
  Models3-formatted file to the projection given in the second
  Models3-formatted file.
}


\usage{
project.M3.1.to.M3.2(x, y, from.file, to.file, units, ...)
}


\arguments{
  \item{x}{x-coordinates in model units from projection in first file
  }
  \item{y}{y-coordinates in model units from projection in first file
  }
  \item{from.file}{Name of Models3-formatted file with the same
    model projection as \code{x} and \code{y}.  These coordinates will
    be re-projected to the projection given in file2.
  }
  \item{to.file}{Name of Models3-formatted file with the model
    projection to which you want \code{x} and \code{y} to be projected.
  }
  \item{units}{Units of \code{x} and \code{y}.  The coordinates returned
    will also be in these units.
  }
  \item{\dots}{Other arguments to pass to \code{get.proj.info.M3}
  function.  In this case, the only relevant argument would be the
  earth radius to use when doing the projections.
  }
}


\details{This function calls \code{get.proj.info.M3} which reads
  the projection information (using the package \pkg{ncdf4}) and
  transforms it to strings that are understood by functions in
  \pkg{sf}.
}


\value{ A list containing the elements \code{coords} and \code{units}.
  The element \code{coords} contains a matrix of coordinates using
  projection in \code{to.file}.  The element \code{units} contains
  the units of the coordinates, which are the same as those specified
  for input \code{x} and \code{y}.
}


\author{Jenise Swall}


\section{Warning}{This function assumes the projections in
  \code{from.file} and \code{to.file} are Lambert conic conformal or
  polar stereographic.
}


\seealso{\code{\link{project.lonlat.to.M3}}, \code{\link{project.M3.to.lonlat}}, \code{\link{get.proj.info.M3}}
}


\examples{
## Find the path to a demo file with lambert conic conformal projection.
lcc.file <- system.file("extdata/ozone_lcc.ncf", package="M3")

## Read in the ozone for July 4 for eastern U.S.
lcc.oz <- get.M3.var(file=lcc.file, var="O3",
                      lcol=90, ucol=130, lrow=30, urow=80,
                      ldatetime=as.Date("2001-07-04"),
                      udatetime=as.Date("2001-07-04"))

## Get the cell centers for this subset.
east.ctrs <- expand.grid(lcc.oz$x.cell.ctr, lcc.oz$y.cell.ctr)
plot(east.ctrs, cex=0.3, xlab="x", ylab="y")

## Find map lines on this projection, superplot.
lcc.state.bds <- get.map.lines.M3.proj(file=lcc.file)$coords
lines(lcc.state.bds, col="darkblue")


## Find the path to a demo file with polar stereographic projection.
polar.file <- system.file("extdata/surfinfo_polar.ncf", package="M3")

## Put the cell centers from the subsetted ozone data on this polar
## stereographic projection.
polar.oz <- project.M3.1.to.M3.2(east.ctrs[,1], east.ctrs[,2],
                                 from.file=lcc.file,
                                 to.file=polar.file,
                                 units=lcc.oz$hz.units)

## Plot the cells centers and boundary lines on the polar
## stereographic projection.
dev.new()
plot(polar.oz$coords)
polar.state.bds <- get.map.lines.M3.proj(file=polar.file)$coords
lines(polar.state.bds, col="darkblue")
}
