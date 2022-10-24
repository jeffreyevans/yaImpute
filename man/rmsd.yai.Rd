\name{rmsd.yai}
\alias{rmsd.yai}
\alias{rmsd}

\title{Root Mean Square Difference between observed and imputed}

\description{Computes the root mean square difference (RMSD) between
  observed and imputed values for each observation that has both. RMSD
  is computationally like RMSE, but they differ in interpretation. The RMSD
  values can be scaled to afford comparisons among variables.
}

\usage{
rmsd.yai (object,vars=NULL,scale=FALSE,\dots)
}

\arguments{
  \item{object}{an object created by \code{\link{yai}} or \code{\link{impute.yai}}}
  \item{vars}{a list of variable names you want to include, if NULL all available
    variables are included}
  \item{scale}{when \code{TRUE}, the values are scaled (see details), if a named vector,
    the values are scaled by the corresponding values.}
  \item{\dots}{passed to called methods, very useful for passing arugment
     \code{ancillaryData} to function \code{\link{impute.yai}}}
}

\value{
  A data frame with the row names as vars and the column as \code{rmsd}. When
  \code{scale=TRUE}, the column name is \code{rmsdS}. The scaling factors used, if any,
  are returned as an attribute.
}

\details{
  By default, RMSD is computed using standard formula for its related statistic,
  RMSE. When \code{scale=TRUE}, or set of values is supplied, RMSD is divided by the 
  scaling factor. The scaling factor is the standard deviation of the
  \emph{reference} observations under the assumption that they are representative
  of the population.
}

\seealso{
\code{\link{yai}}, \code{\link{impute.yai}} and \url{https://doi.org/10.18637/jss.v023.i10}.
}

\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com} \cr
  Andrew O. Finley \email{finleya@msu.edu}
}

\keyword{multivariate}


