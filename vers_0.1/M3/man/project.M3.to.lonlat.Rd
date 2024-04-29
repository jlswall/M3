\name{project.M3.to.lonlat}
\alias{project.M3.to.lonlat}

\title{Project coordinates from model units to longitude/latitude}

\description{Project coordinates from model units (as specified
  according to the projection given by a user-designated
  Models3-formatted file) to longitude/latitude.
}


\usage{
project.M3.to.lonlat(x, y, file, units, ...)
}


\arguments{
  \item{x}{x-coordinates of points in model units (meters or kilometers,
    depeding on the value of \code{units}
  }
  \item{y}{y-coordinates of points in model units  (meters or kilometers,
    depeding on the value of \code{units}
  }
  \item{file}{Name of Models3-formatted file with the same projection as
    \code{x} and \code{y}.
  }
  \item{units}{Units of \code{x} and \code{y}.
  }
  \item{\dots}{Other arguments to pass to \code{get.proj.info.M3}
  function.  In this case, the only relevant argument would be the
  earth radius to use for the projection in \code{file}.
  }
}


\details{This function uses the function \code{\link[rgdal]{project}}
  from the package \pkg{rgdal} to project to longitude/latitude given
  the projection defined by the Models3-formatted file.  Package
  \pkg{rgdal} provides the R interface to GDAL (Geospatial Data
  Abstraction Library, \url{http://www.gdal.org}).
}


\value{A list containing the elements \code{coords} and \code{units}.
  The element \code{coords} contains a matrix of coordinates in
  longitude/latitude.  The element \code{units} contains the string
  "deg" to designate that \code{coords} is in degrees of
  longitude/latitude.
}


\references{\url{http://www.gdal.org}
}


\author{Jenise Swall}


\seealso{\code{\link{project.lonlat.to.M3}},
  \code{\link{project.M3.1.to.M3.2}}, \code{\link{get.proj.info.M3}}
}


\examples{
## List of state capital longitudes/latitudes
## (from http://www.xfront.com/us_states).
capitals <- data.frame(x=c(-84.39,-86.28,-81.04,-86.78,-78.64,-84.86),
                       y=c(33.76,32.36,34.00,36.17,35.77,38.20),
                       name=c("Atlanta", "Montgomery", "Columbia",
                                 "Nashville", "Raleigh", "Frankfort")
                        )
## Plot these on a map, with state lines.
plot(capitals$x, capitals$y)
map("state", add=TRUE)

## Now, put these on the same Lambert conic conformal projection used
## in the demo file below.
lcc.file <- system.file("extdata/ozone_lcc.ncf", package="M3")
lcc.capitals <- project.lonlat.to.M3(capitals$x, capitals$y, lcc.file)

## Now, project them back to longitude/latitude, make sure we get the
## same thing we started with.
chk.capitals <- project.M3.to.lonlat(lcc.capitals$coords[,"x"],
                                     lcc.capitals$coords[,"y"],
                                     lcc.file,
                                     units=lcc.capitals$units)
## These differences should be 0 or something very tiny.
summary(capitals[,c("x", "y")] - chk.capitals$coords)
}