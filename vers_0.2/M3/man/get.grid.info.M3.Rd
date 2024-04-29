\name{get.grid.info.M3}
\alias{get.grid.info.M3}

\title{Get information about the grid used by the air quality model}

\description{Pull information about the grid used from the
  Models3-formatted file.  This includes information such as the origin
  of the grid (lower left corner coordinates in grid units), cell
  spacing, etc.
}


\usage{get.grid.info.M3(file)}


\arguments{
  \item{file}{File name of Models3-formatted file which contains
    information about the projection.  Currently, this function can only
    handle files with Lambert conic conformal, polar stereographic, and
    longitude/latitude projections.}
}


\details{This function assumes that the projection is either Lambert
  conic conformal or polar stereographic projection.  Information about
  grid cell size, extent of grid, etc. is stored in the global
  attributes of the Models3-formatted file, which this function reads.
}


\value{List with the following components:
  \item{x.orig}{X-coordinate of the origin point of the grid (lower
    left corner, coordinates in model projection units)}
  \item{y.orig}{Y-coordinate of the origin point of the grid (lower
    left corner, coordinates in model projection units)}
  \item{x.cell.width}{Width of grid cells in x-direction (in model
    projection units)}
  \item{y.cell.width}{Width of grid cells in y-direction (in model
    projection units)}
  \item{hz.units}{Units of the projection (\dQuote{m}, \dQuote{km},
    or \dQuote{deg})}
  \item{ncols}{Number of columns of grid cells}
  \item{nrows}{Number of rows of grid cells}
  \item{nlays}{Number of vertical layers}
}


\author{Jenise Swall}


\note{This function relies on the R package \pkg{ncdf4} to read
  information from Models3-formatted files, since the Models3 format
  is built on netCDF \cr
  (\url{http://www.unidata.ucar.edu/software/netcdf}). \cr
  Usually, the user will not call this function directly; instead, it
  will be called by the function \code{\link{get.coord.for.dimension}}.
}


\section{Warning}{Currently, this function can only handle files with
  Lambert conic conformal, polar stereographic, and longitude/latitude
  projections.
}


\seealso{\code{\link{get.proj.info.M3}}, \code{\link{get.coord.for.dimension}}
}


\keyword{ IO }


\examples{
## As mentioned in notes above, user will not typically call
## this function directly.

## Find the path to a demo file with lambert conic conformal projection.
lcc.file <- system.file("extdata/ozone_lcc.ncf", package="M3")
## Get a list containing information about the grid in this file.
grid.info <- get.grid.info.M3(lcc.file)


## Find the path to a demo file with polar stereographic projection.
polar.file <- system.file("extdata/surfinfo_polar.ncf", package="M3")
## Get a list containing information about the grid in this file.
grid.info <- get.grid.info.M3(polar.file)
}