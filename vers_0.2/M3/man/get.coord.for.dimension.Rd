\name{get.coord.for.dimension}
\alias{get.coord.for.dimension}


\title{Get the grid coordinates for the grid rows or columns.}

\description{For either the rows or the columns, return the coordinates
  of the centers or the edges of the grid cells.
}


\usage{
get.coord.for.dimension(file, dimension, position = "ctr", units)
}


\arguments{
  \item{file}{Name of Models3-formatted file of interest.
  }
  \item{dimension}{If \dQuote{column}/\dQuote{col}, will obtain
    coordinates for columns; if \dQuote{row} will obtain coordinates
    for rows.
  }
  \item{position}{Choose whether to obtain coordinates of cell edges or
    centers for either grid rows or columns.  If \dQuote{ctr} (default),
    get the cell center.  If \dQuote{lower}, get bottom or left cell
    edge.  If \dQuote{upper}, get top or right cell edge.
  }
  \item{units}{Units for coordinates of grid rows or columns.  Must be
    one of \dQuote{m}, \dQuote{km}, or \dQuote{deg}.  If
    unspecified, the default is \dQuote{deg} if the file has a
    longitude/latitude grid, and \dQuote{km} otherwise.
  }
}


\value{A list containing two elements, \code{coords} and
  \code{units}.  If \code{dimension} is \dQuote{row}, return as element
  \code{coords} a vector containing the y-coordinates of the centers
  (\dQuote{ctr}), left (\dQuote{lower}), or right (\dQuote{upper}) edges
  of each row, depending on the value of argument \code{position}.  If
  \code{dimension} is \dQuote{column} or \dQuote{col}, return as element
  \code{coords} a vector containing the x-coordinates of the centers
  (\dQuote{ctr}), left (\dQuote{lower}), or right (\dQuote{upper}) edges
  of each row, depending on the value of argument \code{position}.  In
  both cases, return as element \code{units} the units of the
  coordinates (can be \dQuote{km}, \dQuote{m}, or \dQuote{deg}).
}


\author{Jenise Swall}


\note{Usually, the user will not call this function directly; instead,
  it will be called by other functions such as
  \code{\link{get.matrix.all.grid.cell.ctrs}} and
  \code{\link{get.M3.var}}.
}


\seealso{\code{\link{get.matrix.all.grid.cell.ctrs}}, \code{\link{get.M3.var}}, \code{\link{get.grid.info.M3}}
}


\examples{
## As mentioned in notes above, user will not typically call
## this function directly.

## Find the path to a demo file with lambert conic conformal projection.
lcc.file <- system.file("extdata/ozone_lcc.ncf", package="M3")

## Get a list of the x-coordinates of the centers of the cells.
x.ctrs <- get.coord.for.dimension(lcc.file, dimension="col", units="km")
}