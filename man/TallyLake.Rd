\name{TallyLake}
\docType{data}
\alias{TallyLake}

\title{Tally Lake, Flathead National Forest, Montana, USA}

\description{
  Polygon-based reference data used by Stage and Crookston (2007)
  to demonstrate partitioning of error components and related statistics.
  Observations are summaries of data collected on forest stands (ploygons).
}

\usage{
data(TallyLake)
}

\format{
  A data frame with 847 rows and 29 columns: \cr\cr
  Ground based measurements of trees (Y-variables):
  \itemize{
     \item{\code{TopHt     }}{Height of tallest trees (ft)}
     \item{\code{LnVolL    }}{Log of the volume \eqn{(ft^3/acre)} of western larch}
     \item{\code{LnVolDF   }}{Log of the volume \eqn{(ft^3/acre)} of Douglas-fir}
     \item{\code{LnVolLP   }}{Log of the volume \eqn{(ft^3/acre)} of lodgepole pine}
     \item{\code{LnVolES   }}{Log of the volume \eqn{(ft^3/acre)} of Engelmann spruce}
     \item{\code{LnVolAF   }}{Log of the volume \eqn{(ft^3/acre)} of alpine fir}
     \item{\code{LnVolPP   }}{Log of the volume \eqn{(ft^3/acre)} of ponderosa pine}
     \item{\code{CCover    }}{Canopy cover (percent)}
  }
  Geographic Location, Slope, and Aspect (X-variables):
  \itemize{
    \item{\code{utmx      }}{UTM easting at plot center}
    \item{\code{utmy      }}{UTM northing at plot center}
    \item{\code{elevm     }}{Mean elevation (ft) above sea level over plot}
    \item{\code{eevsqrd   }}{\eqn{(elevm-1600)^2}}
    \item{\code{slopem    }}{Mean slope (percent) over plot}
    \item{\code{slpcosaspm}}{Mean of slope (proportion) times the cosine of aspect (see
      Stage (1976) for description of this transformation)}
    \item{\code{slpsinaspm}}{Mean of slope (proportion) times the sine of aspect}
  }
  Additional X-variables:
  \itemize{
    \item{\code{ctim    }}{Mean of slope curviture over pixels in stand}
    \item{\code{tmb1m   }}{Mean of LandSat band 1 over pixels in stand}
    \item{\code{tmb2m   }}{Mean of LandSat band 2 over pixels in stand}
    \item{\code{tmb3m   }}{Mean of LandSat band 3 over pixels in stand}
    \item{\code{tmb4m   }}{Mean of LandSat band 4 over pixels in stand}
    \item{\code{tmb5m   }}{Mean of LandSat band 5 over pixels in stand}
    \item{\code{tmb6m   }}{Mean of LandSat band 6 over pixels in stand}
    \item{\code{durm    }}{Mean of light duration over pixels in stand}
    \item{\code{insom   }}{Mean of solar insolation over pixels in stand}
    \item{\code{msavim  }}{Mean of AVI for pixels in stand}
    \item{\code{ndvim   }}{Mean of NDVI for pixels in stand}
    \item{\code{crvm    }}{Mean of slope curviture for pixels in stand}
    \item{\code{tancrvm }}{Mean of tangent curvature for pixels in stand}
    \item{\code{tancrvsd}}{Standard deviation of tangent curvature for pixels in stand}
  }
}

\references{
  Stage, A.R.; Crookston, N.L. 2007. Partitioning error components
  for accuracy-assessment of near neighbor methods of imputation.
  \emph{For. Sci.} 53(1):62-72 \url{https://www.fs.usda.gov/research/treesearch/28385}
                                                                                     
  Stage, A.R. (1976). An expression for the effect of aspect, slope, and
  habitat type on tree growth. \emph{For. Sci.} 22(4):457-460.  
  \url{https://www.fs.usda.gov/research/treesearch/46339}
}

\source{
  USDA Forest Service
}

\keyword{datasets}

