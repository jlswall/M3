# M3 0.4

* Re-release, as package was previously archived on CRAN

* Contains minor updates and fixes.

## Fixes

* Map projections now call functions in package `sf`.  Previously, functions
  from packages `rgdal` and `sp` were used, but those are no longer available.

## Minor changes

* `get.canusamex.bds()` has been removed.  The data produced by that function
  is now shipped with the package to save computational time.

* `get.canmex.bds()` has been removed.  It had previously been superseded by
  `get.canusamex.bds()` and was no longer needed.
  
