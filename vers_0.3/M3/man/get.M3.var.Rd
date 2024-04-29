\name{get.M3.var}
\alias{get.M3.var}

\title{Read in variable values from Models3-formatted files
}

\description{Read in variable values from Models3-formatted files.
}


\usage{
get.M3.var(file, var, lcol, ucol, lrow, urow, llay, ulay,
                ldatetime, udatetime, hz.units)
}


\arguments{
  \item{file}{Name of Models3-formatted file to be read.
  }
  \item{var}{Name (character string) or number (positive integer) of
    variable whose values are to be read.
  }
  \item{lcol}{Lower column bound (positive integer) to be read.  The
    default is to read all columns.
  }
  \item{ucol}{Upper column bound (positive integer) to be read.  The
    default is to read all columns.
  }
  \item{lrow}{Lower row bound (positive integer) to be read.  The
    default is to read all rows.
  }
  \item{urow}{Upper row bound (positive integer) to be read.  The
    default is to read all rows.
  }
  \item{llay}{Lower layer bound (positive integer) to be read.  The
    default is to read the first layer only.
  }
  \item{ulay}{Upper layer bound (positive integer) to be read.  The
    default is to read the first layer only.
  }
  \item{ldatetime}{Starting date-time (Date or POSIX class) in GMT.
  }
  \item{udatetime}{Starting date-time (Date or POSIX class) in GMT.
  }

  The default is to read all date-times.  If the file is
  time-independent, the one available time step will be read and user
  input for ldatetime and udatetime will be disregarded.

  \item{hz.units}{Units associated with grid cell horizontal
    dimensions.  Default is degrees ("deg") if the data is indexed
    according to longitude/latitude and kilometers ("km") otherwise.
    If the file is not indexed according to longitude/latitude, the
    user could choose meters ("m").
  }
}


\details{This function assumes that the projection is either Lambert
  conic conformal or polar stereographic projection.  It also assumes
  that the Models3-formatted file is either time-independent or
  time-stepped; it cannot be of type circular-buffer.
}


\value{List with the following components:
  \item{data}{Array holding the specified variable values.  Array is
    four-dimensional, unless the Models3-formatted file is
    time-independent (which we assume if TSTEP attribute is 0), in which
    case it is three-dimensional.  Dimensions are columns, rows, layers,
    date-time steps.
  }
  \item{data.units}{Contains the units associated with \code{data}.
  }
  \item{x.cell.ctr}{X-coordinates of grid cell centers, in units given
    by \code{hz.units}.
  }
  \item{y.cell.ctr}{Y-coordinates of grid cell centers, in units given
    by \code{hz.units}.
  }
  \item{hz.units}{Contains the units associated with the horizontal
    dimensions of the grid cells (km, m, or deg).  These are the units
    in which \code{x.cell.ctr} and \code{y.cell.ctr} are given.
  }
  \item{rows}{Row numbers extracted.
  }
  \item{cols}{Column numbers extracted.
  }
  \item{layers}{Layer numbers extracted.
  }
  \item{datetime}{Date-time steps (in POSIX format) associated with the
    variable, if the file is not time-independent.  For time-independent
    files, element datetime is set to NULL.
  }
}


\references{
  \url{http://www.baronams.com/products/ioapi/VBLE.html}, \cr
  \url{http://www.baronams.com/products/ioapi/DATETIME.html}
}


\author{Jenise Swall}


\note{This function relies on the R package \pkg{ncdf4} to read
  information from Models3-formatted files, since the Models3 format
  is built on netCDF \cr
  (\url{http://www.unidata.ucar.edu/software/netcdf}). \cr
  It also relies on the \pkg{rgdal} interface with GDAL
  (Geospatial Data Abstraction Library,\cr
  \url{http://www.gdal.org}) to
  obtain the x,y-coordinates of the grid cell centers on the
  projection.
}


\seealso{\code{\link[ncdf4]{ncvar_get}}, \code{\link[ncdf4]{ncatt_get}}, \code{\link{get.coord.for.dimension}}, \cr
  \code{\link{get.datetime.seq}}, \code{\link{combine.date.and.time}}
}


\keyword{IO}


\examples{
## Find the path to the first demo file (with polar
## stereographic projection).
polar.file <- system.file("extdata/surfinfo_polar.ncf", package="M3")

## Read in the terrain elevation variable.
elev <- get.M3.var(file=polar.file, var="HT")
## Make a plot.
image(elev$x.cell.ctr, elev$y.cell.ctr, elev$data[,,1],
      xlab="Projection x-coord (km)", ylab="Projection y-coord (km)",
      zlim=range(elev$data[,,1]), col=topo.colors(20))
## Find national boundaries on this projection, superimpose them on
## the plot.
world.bds <- get.map.lines.M3.proj(file=polar.file, database="world")$coords
lines(world.bds)

## Subset to a smaller geographic area in southwestern U.S.
subset.elev <- var.subset(elev, llx=-2100, urx=0, lly=-6500, ury=-4000)
## Make a plot of this subset.
image(subset.elev$x.cell.ctr, subset.elev$y.cell.ctr,
      subset.elev$data[,,1], xlab="Projection x-coord (km)",
      ylab="Projection y-coord (km)", zlim=range(subset.elev$data[,,1]),
      col=topo.colors(20))
## Find state boundaries on this projection, superimpose them on the plot.
state.bds <- get.map.lines.M3.proj(file=polar.file)$coords
lines(state.bds)



## Find the path to second demo file (with Lambert conic
## conformal projection).
lcc.file <- system.file("extdata/ozone_lcc.ncf", package="M3")

## Read in the ozone for July 4 for eastern U.S.
oz <- get.M3.var(file=lcc.file, var="O3", lcol=80, urow=95,
                      ldatetime=as.Date("2001-07-04"),
                      udatetime=as.Date("2001-07-04"))
## Make a plot.
image(oz$x.cell.ctr, oz$y.cell.ctr, oz$data[,,1,1],
      xlab="Projection x-coord (km)", ylab="Projection y-coord (km)",
      zlim=range(oz$data), col=heat.colors(15))

## Find map lines on this projection, superimpose them on the plot.
state.bds <- get.map.lines.M3.proj(file=lcc.file)$coords
lines(state.bds)
}