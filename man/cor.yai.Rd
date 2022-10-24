\name{cor.yai}
\alias{cor.yai}
\title{Correlation between observed and imputed}

\description{Computes the correlation between observed and imputed values
  for each observation that has both.
}

\usage{
cor.yai (object,vars=NULL,\dots)
}

\arguments{
  \item{object}{an object created by \code{\link{yai}} or \code{\link{impute.yai}}.}
  \item{vars}{a list of variables names you want to include, if NULL all available
    variables are included.}
  \item{\dots}{passed to called methods (not currently used)}
}

\value{
  A data frame with the row names as vars and the column as \code{cor}.
}

\details{
  The correlations are computed using \code{\link{cor.yai}}. For data imputation, such
  correlations are likely not appropriate (Stage and Crookston 2007).
}

\seealso{
\code{\link{yai}}, \code{\link{impute.yai}}, \code{\link{rmsd.yai}}}

\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com} \cr
  Andrew O. Finley \email{finleya@msu.edu}
}

\references{
  Stage, A.R.; Crookston, N.L. (2007). Partitioning error components
  for accuracy-assessment of near neighbor methods of imputation.
  \emph{For. Sci.} 53(1):62-72.
  \url{https://www.fs.usda.gov/rm/pubs_other/rmrs_2007_stage_a001.pdf}
}


\keyword{misc}
\keyword{multivariate}


