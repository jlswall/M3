\name{get.datetime.seq}
\alias{get.datetime.seq}

\title{Read in a sequence of date-time steps from a
  Models3-formatted file.
}

\description{Read the date-time steps in the Models3-formatted file.
  Put these into R's datetime format.
}


\usage{
get.datetime.seq(file)
}


\arguments{
  \item{file}{File name of Models3-formatted file which contains
    the date-time information of interest.
  }
}


\details{This function relies on the R package \pkg{ncdf4} to read
  information from Models3-formatted files, since the Models3 format
  is built on netCDF \cr
  (\url{http://www.unidata.ucar.edu/software/netcdf}).

}


\value{Vector of sequence of datetimes included in the Models3-formatted
  file, in \code{\link[=DateTimeClasses]{POSIXct}} format.
}


\references{Information about the Models3 date-time conventions is
  available at \cr
  \url{http://www.baronams.com/products/ioapi/DATETIME.html}.
}


\author{Jenise Swall}


\note{ This function is called by function \code{\link{get.M3.var}},
  but it will probably not be called by most users.
}


\section{Warning}{This code assumes that the time step is not negative.  For
  instance, the Models3 I/OAPI does allow for negative time steps,
  but these negative time steps will NOT be handled properly by this
  function.  For more information about Models3 date-time
  conventions, see \cr
  \url{http://www.baronams.com/products/ioapi/DATETIME.html}.
}


\seealso{\code{\link{DateTimeClasses}}, \code{\link{seq.POSIXt}}, \code{\link{get.M3.var}}
}


\keyword{chron}


\examples{
## As mentioned in notes above, user will not typically call
## this function directly.

## Find the path to a demo file with lambert conic conformal projection.
lcc.file <- system.file("extdata/ozone_lcc.ncf", package="M3")

## Get vector containing date-times available in this file.
datetime.seq <- get.datetime.seq(lcc.file)
}