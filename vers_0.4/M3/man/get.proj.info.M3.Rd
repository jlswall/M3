\name{get.proj.info.M3}
\alias{get.proj.info.M3}

\title{Obtain information about the projection used in the Models3 file}

\description{Obtain information about the projection used by in the
  Models3-formatted file.  Build a string describing the projection
  which can be used by the R package rgdal.
}


\usage{get.proj.info.M3(file, earth.radius=6370000)}


\arguments{
  \item{file}{File name of Models3-formatted file which contains
    information about the projection.  Currently, this function can only
    handle files with a Lambert conic conformal, polar stereographic,
    and longitude/latitude projections.}
  \item{earth.radius}{Radius of the earth (in meters), which is assumed
    to be spherical by the Models3 I/O API.  Default value is
    6 370 000 m.  Note that the radius in some previous version of the
    Models3 I/O API was 6 370 997 m, which may be appropriate for some
    users.  For instance, this latter value was used in previous
    packages supplied by Battelle.
    }
}


\details{This function assumes that the file uses the Lambert
  conic conformal projection, polar stereographic projection, or
  longitude/latitude.\cr
  The Models3 I/O API assumes a spherical earth.  The default value for
  \code{earth.radius} is 6 370 000 m (sometimes referred to as
  \dQuote{sphere 20}), which is the current value used in the Models3
  I/O API. Note that the radius in some previous versions of the Models3
  I/O API was 6 370 997 m, and this value was also used in previous
  packages for reading Models3-formatted files, which were developed for
  EPA by Battelle.
}


\value{String describing model projection, which can be utilized by
  the \pkg{rgdal} package (for projections to and from
  longitude/latitude, for example).
}

  
\references{See information about the meaning of Models3 I/O API
  projection arguments at \cr
  \url{http://www.baronams.com/products/ioapi/GRIDS.html}.
}


\author{Jenise Swall}


\note{This function relies on the R package \pkg{ncdf4} to read
  information from Models3-formatted files, since the Models3 format
  is built on netCDF \cr
  (\url{http://www.unidata.ucar.edu/software/netcdf}). \cr
  The string that is returned by this function is appropriate for
  interface with GDAL (Geospatial Data Abstraction Library,
  \url{http://www.gdal.org}) through package \pkg{rgdal}.  Usually,
  the user will not call this function directly; instead, it will be
  called by other functions in this package.
}


\section{Warning}{Currently, this function can only handle files with
  Lambert conic conformal, polar stereographic, and longitude/latitude
  projections.
}


\seealso{\code{\link{project.lonlat.to.M3}},
  \code{\link{project.M3.to.lonlat}}, \cr
  \code{\link{project.M3.1.to.M3.2}},
  \code{\link{get.map.lines.M3.proj}}
}


\keyword{IO}


\examples{
## Find the path to a demo file on lambert conic conformal projection.
lcc.file <- system.file("extdata/ozone_lcc.ncf", package="M3")
## Get string with projection information, using previous value for
## the earth's radius.
get.proj.info.M3(lcc.file, earth.radius=6370997)

## Find the path to a demo file on polar stereographic projection.
polar.file <- system.file("extdata/surfinfo_polar.ncf", package="M3")
## Get string with projection information.
get.proj.info.M3(polar.file)
}