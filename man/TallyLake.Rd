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
  \enumerate{
     \item TopHt   - Height of tallest trees (ft)
     \item LnVolL  - Log of the volume \eqn{(ft^3/acre)} of western larch
     \item LnVolDF - Log of the volume \eqn{(ft^3/acre)} of Douglas-fir
     \item LnVolLP - Log of the volume \eqn{(ft^3/acre)} of lodgepole pine
     \item LnVolES - Log of the volume \eqn{(ft^3/acre)} of Engelmann spruce
     \item LnVolAF - Log of the volume \eqn{(ft^3/acre)} of alpine fir
     \item LnVolPP - Log of the volume \eqn{(ft^3/acre)} of ponderosa pine
     \item CCover  - Canopy cover (percent)
  }
  Geographic Location, Slope, and Aspect (X-variables):
  \enumerate{
    \item utmx - UTM easting at plot center
    \item utmy - UTM northing at plot center
    \item elevm - Mean elevation (ft) above sea level over plot
    \item eevsqrd - \eqn{(elevm-1600)^2}
    \item slopem - Mean slope (percent) over plot
    \item slpcosaspm - Mean of slope (proportion) times the cosine of aspect (see
      Stage (1976) for description of this transformation
    \item slpsinaspm - Mean of slope (proportion) times the sine of aspect
  }
  Additional X-variables:
  \enumerate{
    \item ctim     - Mean of slope curviture over pixels in stand
    \item tmb1m    - Mean of LandSat band 1 over pixels in stand
    \item tmb2m    - Mean of LandSat band 2 over pixels in stand
    \item tmb3m    - Mean of LandSat band 3 over pixels in stand
    \item tmb4m    - Mean of LandSat band 4 over pixels in stand
    \item tmb5m    - Mean of LandSat band 5 over pixels in stand
    \item tmb6m    - Mean of LandSat band 6 over pixels in stand
    \item durm     - Mean of light duration over pixels in stand
    \item insom    - Mean of solar insolation over pixels in stand
    \item msavim   - Mean of AVI for pixels in stand
    \item ndvim    - Mean of NDVI for pixels in stand
    \item crvm     - Mean of slope curviture for pixels in stand
    \item tancrvm  - Mean of tangent curvature for pixels in stand
    \item tancrvsd - Standard deviation of tangent curvature for pixels in stand
  }
}

\references{
  Stage, A.R.; Crookston, N.L. 2007. Partitioning error components
  for accuracy-assessment of near neighbor methods of imputation.
  \emph{For. Sci.} 53(1):62-72 \url{https://academic.oup.com/forestscience/article/53/1/62/4604364}
                                                                                     
  Stage, A.R. (1976). An expression for the effect of aspect, slope, and
  habitat type on tree growth. \emph{For. Sci.} 22(4):457-460.  
  \url{https://academic.oup.com/forestscience/article-abstract/22/4/457/4675852}
}

\source{
  USDA Forest Service
}

\keyword{datasets}

