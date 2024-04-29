\name{get.matrix.all.grid.cell.ctrs}
\alias{get.matrix.all.grid.cell.ctrs}

\title{Obtain a matrix giving the locations of the grid cell centers}

\description{Obtain a two-column matrix giving the locations of the grid
cell centers in grid units.}

\usage{
get.matrix.all.grid.cell.ctrs(file, units)
}


\arguments{
  \item{file}{File name of Models3-formatted file which contains
    information about the projection.  Currently, this function can only
    handle files with a Lambert conic conformal or polar stereographic
    projection.
  }
  \item{units}{Units for coordinates of grid rows and columns.  Must be
    one of \dQuote{m}, \dQuote{km}, or \dQuote{deg}.  If
    unspecified, the default is \dQuote{deg} if the file has a
    longitude/latitude grid, and \dQuote{km} otherwise.
  }
}


\value{Matrix with number of rows equal to the number of grid cells and
  two columns.  The first column contains the x-coordinate of the grid
  cell centers; the second column contains the y-coordinate of the grid
  cell centers.  The rows are listed in order such that all cell
  centers with same y-coordinate are grouped together, with groups
  ordered by the y-coordinate, and ordered within these groups by the
  x-coordinate).
}


\note{This function relies on calls \code{get.coord.for.dimensions}.}


\section{Warning}{Currently, this function can only handle files with
  Lambert conic conformal, polar stereographic, and longitude/latitude
  projections.
}


\author{Jenise Swall}


\seealso{\code{\link{get.coord.for.dimension}}
}


\examples{
## As mentioned in notes above, user will not typically call
## this function directly.

## Find the path to a demo file on lambert conic conformal projection.
lcc.file <- system.file("extdata/ozone_lcc.ncf", package="M3")
## Get a list of the x- and y-coordinates of the centers of all
## grid cells.
ctrs <- get.matrix.all.grid.cell.ctrs(lcc.file, units="km")
}