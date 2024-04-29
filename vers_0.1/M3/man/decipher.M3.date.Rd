\name{decipher.M3.date}
\alias{decipher.M3.date}

\title{Decipher Models3 date format (YYYYDDD) into R's Date class.
}

\description{Decipher Models3 date format (YYYYDDD) into R's Date class.
}


\usage{
decipher.M3.date(M3.date)
}


\arguments{
  \item{M3.date}{Date (numeric) in the format YYYYDDD,
    where DDD is a Julian day (since the beginning of year YYYY).  
  }
}


\value{Date specified by YYYYDDD in R's Date class.
}


\references{\url{http://www.baronams.com/products/ioapi/DATETIME.html}
}


\author{Jenise Swall}


\note{For more information about M3 date-time conventions,
  see \cr
  \url{http://www.baronams.com/products/ioapi/DATETIME.html}. \cr
  This function is called by function \code{\link{get.datetime.seq}},
  but it will probably not be called by most users.
}


\seealso{\code{\link{DateTimeClasses}}, \cr
  \code{\link{get.datetime.seq}}, \cr
  \code{\link{decipher.M3.time}}
}


\examples{
## Returns 2011-03-10, which is the 69th day of 2011.
decipher.M3.date(2011069)  

## Returns 2012-02-29.  This leap day is the 60th day of 2012.
decipher.M3.date(2012060)  
}