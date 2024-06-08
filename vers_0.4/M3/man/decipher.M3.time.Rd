\name{decipher.M3.time}
\alias{decipher.M3.time}

\title{Decipher Models3 time format (HHMMSS) into hours, minutes,
  and seconds.
}

\description{Decipher Models3 time format (HHMMSS) into hours, minutes,
  and seconds.
}


\usage{
decipher.M3.time(M3.time)
}


\arguments{
  \item{M3.time}{Time (numeric) in the format HHMMSS (hours, minutes, seconds).
  }
}


\value{List with the following components
  \item{hrs}{hours}
  \item{mins}{minutes}
  \item{secs}{seconds}
}


\references{\url{https://www.cmascenter.org/ioapi/documentation/all_versions/html/DATETIME.html}
}


\author{Jenise Swall}


\note{For more information about Models3 date-time conventions,
  see \cr
  \url{https://www.cmascenter.org/ioapi/documentation/all_versions/html/DATETIME.html}. \cr
  This function is called by function \code{\link{get.datetime.seq}},
  but it will probably not be called by most users.
}


\seealso{\code{\link{DateTimeClasses}}, \cr
  \code{\link{get.datetime.seq}}, \cr
  \code{\link{decipher.M3.date}}
}


\examples{
## Note that the function breaks up the (numeric) input,
## where hours are designated by 00-23, minutes by 00-59, 
## seconds by 00-59.  
decipher.M3.time(030105)
}