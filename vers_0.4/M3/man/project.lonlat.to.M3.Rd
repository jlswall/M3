\name{project.lonlat.to.M3}
\alias{project.lonlat.to.M3}

\title{Project coordinates from longitude/latitude to model units.}

\description{Project coordinates from longitude/latitude to model
  units as specified according to the projection given by a
  user-designated Models3-formatted file.}


\usage{
project.lonlat.to.M3(longitude, latitude, file, units, ...)
}


\arguments{
  \item{longitude}{Vector of longitudes for the points to be
    projected.
  }
  \item{latitude}{Vector of latitudes for the points to be projected.
  }
  \item{file}{File name of Models3-formatted file which contains
    information about the projection to which you want \code{x} and
    \code{y} to be projected.
  }
  \item{units}{Units in which to return \code{x} and \code{y}.  Options
    are "km" or "m", with "km" as the default.
  }
  \item{\dots}{Other arguments to pass to \code{get.proj.info.M3}
  function.  In this case, the only relevant argument would be the
  earth radius to use for the projection in \code{file}.
  }
}


\details{This function uses the function \code{\link[sf]{sf_project}}
  from the package \pkg{sf} to project from longitude/latitude to
  the projection defined by the Models3-formatted file.
}


\value{A list containing the elements \code{coords} and \code{units}.
  The element \code{coords} contains a matrix of coordinates using the
  projection in \code{file}.  The element \code{units} contains the
  units of the coordinates, as specifed by \code{units} or "km" by
  default.
}


\author{Jenise Swall}


\seealso{\code{\link{project.M3.to.lonlat}}, \code{\link{project.M3.1.to.M3.2}}, \code{\link{get.proj.info.M3}}
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

## Put these on a new plot.
dev.new()
plot(lcc.capitals$coords)
## Project state lines to this projection.
lcc.map <- get.map.lines.M3.proj(lcc.file)
lines(lcc.map$coords)
}