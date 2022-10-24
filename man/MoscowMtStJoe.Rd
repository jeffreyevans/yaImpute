\name{MoscowMtStJoe}
\docType{data}
\alias{MoscowMtStJoe}

\title{Moscow Mountain and St. Joe Woodlands (Idaho, USA) Tree and LiDAR Data}

\description{
  Data used to compare the utility of discrete-return light detection
  and ranging (LiDAR) data and multispectral satellite imagery, and their
  integration, for modeling and mapping basal area and tree density across
  two diverse coniferous forest landscapes in north-central Idaho, USA.
}

\usage{
data(MoscowMtStJoe)
}

\format{
  A data frame with 165 rows and 64 columns: \cr\cr
  Ground based measurements of trees:
  \itemize{
    \item{\code{ABGR\_BA }}{Basal area \eqn{(m^2/ha)} of ABGR}
    \item{\code{ABLA\_BA }}{Basal area \eqn{(m^2/ha)} of ABLA}
    \item{\code{ACGL\_BA }}{Basal area \eqn{(m^2/ha)} of ACGL}
    \item{\code{BEOC\_BA }}{Basal area \eqn{(m^2/ha)} of BEOC}
    \item{\code{LAOC\_BA }}{Basal area \eqn{(m^2/ha)} of LAOC}
    \item{\code{PICO\_BA }}{Basal area \eqn{(m^2/ha)} of PICO}
    \item{\code{PIEN\_BA }}{Basal area \eqn{(m^2/ha)} of PIEN}
    \item{\code{PIMO\_BA }}{Basal area \eqn{(m^2/ha)} of PIMO}
    \item{\code{PIPO\_BA }}{Basal area \eqn{(m^2/ha)} of PIPO}
    \item{\code{POBA\_BA }}{Basal area \eqn{(m^2/ha)} of POBA}
    \item{\code{POTR\_BA }}{Basal area \eqn{(m^2/ha)} of POTR}
    \item{\code{PSME\_BA }}{Basal area \eqn{(m^2/ha)} of PSME}
    \item{\code{SAEX\_BA }}{Basal area \eqn{(m^2/ha)} of SAEX}
    \item{\code{THPL\_BA }}{Basal area \eqn{(m^2/ha)} of THPL}
    \item{\code{TSHE\_BA }}{Basal area \eqn{(m^2/ha)} of TSHE}
    \item{\code{TSME\_BA }}{Basal area \eqn{(m^2/ha)} of TSME}
    \item{\code{UNKN\_BA }}{Basal area \eqn{(m^2/ha)} of unknown species}
    \item{\code{Total\_BA}}{Basal area \eqn{(m^2/ha)} total over all species}
    \item{\code{ABGR\_TD }}{Trees per ha of ABGR}
    \item{\code{ABLA\_TD }}{Trees per ha of ABLA}
    \item{\code{ACGL\_TD }}{Trees per ha of ACGL}
    \item{\code{BEOC\_TD }}{Trees per ha of BEOC}
    \item{\code{LAOC\_TD }}{Trees per ha of LAOC}
    \item{\code{PICO\_TD }}{Trees per ha of PICO}
    \item{\code{PIEN\_TD }}{Trees per ha of PIEN}
    \item{\code{PIMO\_TD }}{Trees per ha of PIMO}
    \item{\code{PIPO\_TD }}{Trees per ha of PIPO}
    \item{\code{POBA\_TD }}{Trees per ha of POBA}
    \item{\code{POTR\_TD }}{Trees per ha of POTR}
    \item{\code{PSME\_TD }}{Trees per ha of PSME}
    \item{\code{SAEX\_TD }}{Trees per ha of SAEX}
    \item{\code{THPL\_TD }}{Trees per ha of THPL}
    \item{\code{TSHE\_TD }}{Trees per ha of TSHE}
    \item{\code{TSME\_TD }}{Trees per ha of TSME}
    \item{\code{UNKN\_TD }}{Trees per ha of unknown species}
    \item{\code{Total\_TD}}{Trees per ha total over all species}}
    
  Geographic Location, Slope and Aspect:
  \itemize{
    \item{\code{EASTING  }}{UTM (Zone 11) easting at plot center}
    \item{\code{NORTHING }}{UTM (Zone 11) northing at plot center}
    \item{\code{ELEVATION}}{Mean elevation (m) above sea level over plot}
    \item{\code{SLPMEAN  }}{Mean slope (percent) over plot}
    \item{\code{ASPMEAN  }}{Mean aspect (degrees) over plot}
  }
  Advanced Land Imager (ALI):
  \itemize{
    \item{\code{B1MEAN }}{Mean of 30 m ALI band 1 pixels intersecting plot}
    \item{\code{B2MEAN }}{Mean of 30 m ALI band 2 pixels intersecting plot}
    \item{\code{B3MEAN }}{Mean of 30 m ALI band 3 pixels intersecting plot}
    \item{\code{B4MEAN }}{Mean of 30 m ALI band 4 pixels intersecting plot}
    \item{\code{B5MEAN }}{Mean of 30 m ALI band 5 pixels intersecting plot}
    \item{\code{B6MEAN }}{Mean of 30 m ALI band 6 pixels intersecting plot}
    \item{\code{B7MEAN }}{Mean of 30 m ALI band 7 pixels intersecting plot}
    \item{\code{B8MEAN }}{Mean of 30 m ALI band 8 pixels intersecting plot}
    \item{\code{B9MEAN }}{Mean of 30 m ALI band 9 pixels intersecting plot}
    \item{\code{PANMEAN}}{Mean of 10 m PAN band pixels intersecting plot}
    \item{\code{PANSTD }}{Standard deviation of 10 m PAN band pixels intersecting plot}
  }
  LiDAR Intensity:
 \itemize{
    \item{\code{INTMEAN}}{Mean of 2 m intensity pixels intersecting plot}
    \item{\code{INTSTD }}{Standard deviation of 2 m intensity pixels intersecting plot}
    \item{\code{INTMIN }}{Minimum of 2 m intensity pixels intersecting plot}
    \item{\code{INTMAX }}{Maximum of 2 m intensity pixels intersecting plot}
  }
  LiDAR Height:
  \itemize{
    \item{\code{HTMEAN}}{Mean of 6 m height pixels intersecting plot}
    \item{\code{HTSTD }}{Standard deviation of 6 m height pixels intersecting plot}
    \item{\code{HTMIN }}{Minimum of 6 m height pixels intersecting plot}
    \item{\code{HTMAX }}{Maximum of 6 m height pixels intersecting plot}
  }
  LiDAR Canopy Cover:
  \itemize{
    \item{\code{CCMEAN}}{Mean of 6 m canopy cover pixels intersecting plot}
    \item{\code{CCSTD }}{Standard deviation of 6 m canopy cover pixels intersecting plot}
    \item{\code{CCMIN }}{Minimum of 6 m canopy cover pixels intersecting plot}
    \item{\code{CCMAX }}{Maximum of 6 m canopy cover pixels intersecting plot}
  }
}

\references{
  Hudak, A.T.; Crookston, N.L.; Evans, J.S.; Falkowski, M.J.; Smith,
  A.M.S.; Gessler, P.E.; Morgan, P. (2006). Regression modeling and mapping
  of coniferous forest basal area and tree density from discrete-return
  lidar and multispectral satellite data. Can. J. Remote Sensing.
  32(2):126-138. \url{https://www.fs.usda.gov/research/treesearch/24612}
}

\source{
  Dr. Andrew T. Hudak  \cr
  USDA Forest Service \cr
  Rocky Mountain Research Station \cr
  1221 South Main \cr
  Moscow, Idaho, USA 83843
}


\keyword{datasets}

