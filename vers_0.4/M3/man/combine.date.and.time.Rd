\name{combine.date.and.time}
\alias{combine.date.and.time}

\title{Combine date and time to obtain date-time in POSIX format
}

\description{Combine date and time to obtain date-time in POSIX format
}


\usage{
combine.date.and.time(date, time)
}


\arguments{
  \item{date}{Date in Date format or as character string in format
    \dQuote{YYYY-MM-DD}.
  }
  \item{time}{Time as list with hours (\code{hrs}), minutes
    (\code{mins}), and seconds (\code{secs}) components or as
    character string in format HH:MM:SS (with hours ranging
    from 00-23).
  }
}


\value{A date-time in R's POSIX class.
}


\author{Jenise Swall}


\note{This function is called by \code{\link{get.datetime.seq}}, \code{\link{get.M3.var}}, and \code{\link{var.subset}}, but it will probably not be called by most users.
}


\seealso{\code{\link{DateTimeClasses}}, \code{\link{strptime}}
}


\keyword{chron}


\examples{
## This function can accept dates as a character string:
combine.date.and.time(date="2011-05-03", time="16:15:30")

## Or, the dates can be in R's Date format.
combine.date.and.time(date=as.Date("2011-05-03"), time="16:15:30")

## The time can also be given as a list:
combine.date.and.time(date="2011-05-03", time=list(hrs=16, mins=15, secs=30))
}
