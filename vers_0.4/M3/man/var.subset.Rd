\name{var.subset}
\alias{var.subset}

\title{Subset the array resulting from a call to \code{get.M3.var}.
}

\description{Subset the array resulting from a call to
  \code{get.M3.var} using projection units and/or human-readable
  dates and times.
}


\usage{
var.subset(var.info, llx, urx, lly, ury, ldatetime, udatetime,
           hz.strict=TRUE)
}


\arguments{
  \item{var.info}{Variable list given by function \code{get.M3.var}.
  }
  \item{llx}{Lower x-coordinate bound for the subsetted grid
    using the same units given in element \code{hz.units} of
    \code{var.info}.  Default is the left boundary of the grid.
  }
  \item{urx}{Upper x-coordinate bound for the subsetted grid
    using the same units given in element \code{hz.units} of
    \code{var.info}.  Default is the right boundary of the grid.
  }
  \item{lly}{Lower y-coordinate bound for the subsetted grid
    using the same units given in element \code{hz.units} of
    \code{var.info}.  Default is the lower boundary of the grid.
  }
  \item{ury}{Upper y-coordinate bound for the subsetted grid
    using the same units given in element \code{hz.units} of
    \code{var.info}.  Default is the upper boundary of the grid.
  }
  \item{ldatetime}{Beginning date-time (either Date or POSIX
    class) bound for the subset.  Default is earliest date-time.
  }
  \item{udatetime}{Ending date-time (either Date or POSIX
    class) bound for the subset.  Default is latest date-time.
  }
  \item{hz.strict}{If TRUE (default), to be allowed in the
    subset, the whole grid cell must fit within the bounds given by
    llx, urx, lly, and ury.  If FALSE, grid cells will be included
    in the subset if any portion of the grid cell's area falls
    within the given bounds.
  }
}


\details{If the user wants to subset the variable by row, column, layer,
  or time step number, this can be accomplished easily using standard R
  methods for subsetting the array of variable values.  This function
  was written to help the user who does not know the row, column, or
  time step numbers, but who wants to subset according to human-readable
  dates and times or according to projection units.
}


\value{Subsetted array of variable values.  (The array's format is
  preserved.)
}


\references{\url{https://www.cmascenter.org/ioapi/documentation/all_versions/html/VBLE.html}, \cr
  \url{https://www.cmascenter.org/ioapi/documentation/all_versions/html/DATETIME.html}
}


\author{Jenise Swall}


\seealso{\code{\link{get.M3.var}}
}


\examples{
## Find the path to the demo file.
polar.file <- system.file("extdata/surfinfo_polar.ncf", package="M3")

## Read in the terrain elevation variable.
elev <- get.M3.var(file=polar.file, var="HT")
## Make a plot.
image(elev$x.cell.ctr, elev$y.cell.ctr, elev$data[,,1],
      xlab="Projection x-coord (km)", ylab="Projection y-coord (km)",
      zlim=range(elev$data[,,1]), col=heat.colors(15))

## Subset to a smaller geographic area in southwestern U.S.
subset.elev <- var.subset(elev, llx=-2000, urx=0, lly=-6500, ury=-4000)
## Make a plot of this subset.
image(subset.elev$x.cell.ctr, subset.elev$y.cell.ctr,
      subset.elev$data[,,1], xlab="Projection x-coord (km)",
      ylab="Projection y-coord (km)", zlim=range(subset.elev$data[,,1]),
      col=heat.colors(15))

## Superimpose U.S. state boundaries on the plot.
state.bds <- get.map.lines.M3.proj(file=polar.file)$coords
lines(state.bds)
}
