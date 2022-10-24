\name{whatsMax}
\alias{whatsMax}
\title{Find maximum column for each row}

\description{
  For each row, the function identifies the column that has the maximum
  value. The function returns a data frame with two columns: the first is
  the column name corresponding to the column of maximum value and the
  second is the correspond maximum. The first column is convereted to a
  factor.

  If the maximum is zero, the maximum column is identified as "zero".

  If there are over \code{nbig} factors in column 1, the maximum values
  that are less than the largest are combined and identified as "other".

  Intended use is to transform community ecology data for use in \code{\link{yai}}
  where method is \emph{randomForest}.
}

\usage{
whatsMax(x,nbig=30)
}

\arguments{
  \item{x}{a data frame or matrix of numeric values.}
  \item{nbig}{see description--the maximum number of factors, the remainder called 'other'.}
}

\value{
  A data frame.
}

\examples{
data(MoscowMtStJoe)

# get the basal area by species columns
yba  <- MoscowMtStJoe[,1:17]

# for each row, pick the species that has the max basal area
# create "other" for those not in the top 7.

ybaB <- whatsMax(yba,nbig=7)
levels(ybaB[,1])
}


\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com} \cr
  Andrew O. Finley \email{finleya@msu.edu}
}

\keyword{misc}

