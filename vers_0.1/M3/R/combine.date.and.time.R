## ###########################################################
## Purpose: Combine date and time to obtain date-time in POSIX format.
##
## Input:
##   1. Date in Date format or as character string in format "YYYY-MM-DD".
##   2. Time as list with hrs, mins, and secs components or as
##      character string in "HH:MM:SS" (with hours 00-23).
##
## Returns: A date-time in POSIX format.
##
## Assumes: This code assumes that the time is not negative.  (For
## instance, the Models3 I/OAPI does allow for negative time steps,
## but these negative time steps will NOT be handled properly by this
## function.)
## ###########################################################
combine.date.and.time <- function(date, time){

  ## Check whether time is a list like that returned by the
  ## decipher.M3.time() function.
  if (is.list(time))  
    datetime <- strptime(paste(as.character(date), " ", time$hrs, ":",
                               time$mins, ":", time$secs, sep=""),
                         format="%Y-%m-%d %H:%M:%S", tz="GMT")

  ## Otherwise, assume time is a character string of form HH:MM:SS.
  else
    datetime <- strptime(paste(as.character(date), " ", time, sep=""),
                         format="%Y-%m-%d %H:%M:%S", tz="GMT")

  return(datetime)
}
