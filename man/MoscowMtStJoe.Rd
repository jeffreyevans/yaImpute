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
    \item ABGR_BA - Basal area \eqn{(m^2/ha)} of ABGR
    \item ABLA_BA - Basal area \eqn{(m^2/ha)} of ABLA
    \item ACGL_BA - Basal area \eqn{(m^2/ha)} of ACGL
    \item BEOC_BA - Basal area \eqn{(m^2/ha)} of BEOC
    \item LAOC_BA - Basal area \eqn{(m^2/ha)} of LAOC
    \item PICO_BA - Basal area \eqn{(m^2/ha)} of PICO
    \item PIEN_BA - Basal area \eqn{(m^2/ha)} of PIEN
    \item PIMO_BA - Basal area \eqn{(m^2/ha)} of PIMO
    \item PIPO_BA - Basal area \eqn{(m^2/ha)} of PIPO
    \item POBA_BA - Basal area \eqn{(m^2/ha)} of POBA
    \item POTR_BA - Basal area \eqn{(m^2/ha)} of POTR
    \item PSME_BA - Basal area \eqn{(m^2/ha)} of PSME
    \item SAEX_BA - Basal area \eqn{(m^2/ha)} of SAEX
    \item THPL_BA - Basal area \eqn{(m^2/ha)} of THPL
    \item TSHE_BA - Basal area \eqn{(m^2/ha)} of TSHE
    \item TSME_BA - Basal area \eqn{(m^2/ha)} of TSME
    \item UNKN_BA - Basal area \eqn{(m^2/ha)} of unknown species
    \item Total_B - Basal area \eqn{(m^2/ha)} total over all species
    \item ABGR_TD - Trees per ha of ABGR
    \item ABLA_TD - Trees per ha of ABLA
    \item ACGL_TD - Trees per ha of ACGL
    \item BEOC_TD - Trees per ha of BEOC
    \item LAOC_TD - Trees per ha of LAOC
    \item PICO_TD - Trees per ha of PICO
    \item PIEN_TD - Trees per ha of PIEN
    \item PIMO_TD - Trees per ha of PIMO
    \item PIPO_TD - Trees per ha of PIPO
    \item POBA_TD - Trees per ha of POBA
    \item POTR_TD - Trees per ha of POTR
    \item PSME_TD - Trees per ha of PSME
    \item SAEX_TD - Trees per ha of SAEX
    \item THPL_TD - Trees per ha of THPL
    \item TSHE_TD - Trees per ha of TSHE
    \item TSME_TD - Trees per ha of TSME
    \item UNKN_TD - Trees per ha of unknown species
    \item Total_T - Trees per ha total over all species
  }    
  Geographic Location, Slope and Aspect:
  \enumerate{
    \item EASTING   - UTM (Zone 11) easting at plot center
    \item NORTHING  - UTM (Zone 11) northing at plot center
    \item ELEVATION - Mean elevation (m) above sea level over plot
    \item SLPMEAN   - Mean slope (percent) over plot
    \item ASPMEAN   - Mean aspect (degrees) over plot
  }
  Advanced Land Imager (ALI):
  \enumerate{
    \item B1MEAN - Mean of 30 m ALI band 1 pixels intersecting plot
    \item B2MEAN - Mean of 30 m ALI band 2 pixels intersecting plot
    \item B3MEAN - Mean of 30 m ALI band 3 pixels intersecting plot
    \item B4MEAN - Mean of 30 m ALI band 4 pixels intersecting plot
    \item B5MEAN - Mean of 30 m ALI band 5 pixels intersecting plot
    \item B6MEAN - Mean of 30 m ALI band 6 pixels intersecting plot
    \item B7MEAN - Mean of 30 m ALI band 7 pixels intersecting plot
    \item B8MEAN - Mean of 30 m ALI band 8 pixels intersecting plot
    \item B9MEAN - Mean of 30 m ALI band 9 pixels intersecting plot
    \item PANMEA - Mean of 10 m PAN band pixels intersecting plot
    \item PANSTD - Standard deviation of 10 m PAN band pixels intersecting plot
  }
  LiDAR Intensity:
 \enumerate{
    \item INTMEAN - Mean of 2 m intensity pixels intersecting plot
    \item INTSTD  - Standard deviation of 2 m intensity pixels intersecting plot
    \item INTMIN  - Minimum of 2 m intensity pixels intersecting plot
    \item INTMAX  - Maximum of 2 m intensity pixels intersecting plot
  }
  LiDAR Height:
  \enumerate{
    \item HTMEAN - Mean of 6 m height pixels intersecting plot
    \item HTSTD  - Standard deviation of 6 m height pixels intersecting plot
    \item HTMIN  - Minimum of 6 m height pixels intersecting plot
    \item HTMAX  - Maximum of 6 m height pixels intersecting plot
  }
  LiDAR Canopy Cover:
  \enumerate{
    \item CCMEAN - Mean of 6 m canopy cover pixels intersecting plot
    \item CCSTD  - Standard deviation of 6 m canopy cover pixels intersecting plot
    \item CCMIN  - Minimum of 6 m canopy cover pixels intersecting plot
    \item CCMAX  - Maximum of 6 m canopy cover pixels intersecting plot
  }
}

\references{
  Hudak, A.T.; Crookston, N.L.; Evans, J.S.; Falkowski, M.J.; Smith,
  A.M.S.; Gessler, P.E.; Morgan, P. (2006). Regression modeling and mapping
  of coniferous forest basal area and tree density from discrete-return
  lidar and multispectral satellite data. Can. J. Remote Sensing.
  32(2):126-138. \url{https://www.tandfonline.com/doi/abs/10.5589/m06-007}
}

\source{
  Dr. Andrew T. Hudak  \cr
  USDA Forest Service \cr
  Rocky Mountain Research Station \cr
  1221 South Main \cr
  Moscow, Idaho, USA 83843
}


\keyword{datasets}

