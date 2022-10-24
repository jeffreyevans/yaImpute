\name{errorStats}
\alias{errorStats}
\title{Compute error components of k-NN imputations}

\description{
Error properties of estimates derived from imputation differ from those of regression-based
estimates because the two methods include a different mix of error components. This function
computes a partitioning of error statistics as proposed by Stage and Crookston (2007).
}

\usage{
errorStats(mahal,\dots,scale=FALSE,pzero=0.1,plg=0.5,seeMethod="lm")
}

\arguments{
  \item{mahal}{An object of class \code{\link{yai}} computed with \code{method="mahalanobis"}.}
  \item{\dots}{Other objects of class \code{\link{yai}} for which statistics are desired. All
         objects should be for the same data and variables used for the first argument.}
  \item{scale}{When \code{TRUE}, the errors are scaled by their respective standard deviations.}
  \item{pzero}{The lower tail p-value used to pick \emph{reference} observations that are zero
         distance from each other (used to compute \code{rmmsd0}).}
  \item{plg}{The upper tail p-value used to pick \emph{reference} observations that are
         substantially distant from each other (used to compute \code{rmsdlg}).}
  \item{seeMethod}{Method used to compute \code{SEE}: \code{seeMethod="lm"} uses \code{\link[stats]{lm}}
       and \code{seeMethod="gam"} uses \code{\link[gam]{gam}}. In both cases, the model formula is
       a simple linear combination of the X-variables.}
}

\value{
  A list that contains several data frames. The column names of each are a combination
  of the name of the object used to compute the statistics and the name of the statistic. The
  rownames correspond the the Y-variables from the first argument. The data frame names are as follows:
  \item{common}{statistics used to compute other statistics.}
  \item{name of first argument}{error statistics for the first \code{\link{yai}} object.}
  \item{names of \dots arguments}{error statistics for each of the remaining \code{\link{yai}} objects,
       if any.}
  \item{see}{standard error of estimate for individual regressions fit for
     corresponding Y-variables.}
  \item{rmmsd0}{root mean square difference for imputations based on \code{method="mahalanobis"}
     (always based on the first argument to the function).}
  \item{mlf}{square root of the model lack of fit: \eqn{sqrt(see^2 - (rmmsd0^2/2))}.}
  \item{rmsd}{root mean square error.}
  \item{rmsdlg}{root mean square error of the observations with larger distances.}
  \item{sei}{standard error of imputation \eqn{sqrt(rmsd^2 - (rmmsd0^2/2))}.}
  \item{dstc}{distance component: \eqn{sqrt(rmsd^2 - rmmsd0^2)}.}
  Note that unlike Stage and Crookston (2007), all statistics reported here are in the natural
  units, not squared units.
}

\details{
See \url{https://www.fs.usda.gov/research/treesearch/28385}
}

\seealso{
\code{\link{yai}}, \code{\link{TallyLake}}
}

\examples{

require (yaImpute)

data(TallyLake)

diag(cov(TallyLake[,1:8])) # see col A in Table 3 in Stage and Crookston

mal=yai(x=TallyLake[,9:29],y=TallyLake[,1:8],
        noTrgs=TRUE,method="mahalanobis")


msn=yai(x=TallyLake[,9:29],y=TallyLake[,1:8],
        noTrgs=TRUE,method="msn")


# variable "see" for "mal" matches col B (when squared and scaled)
# other columns don't match exactly as Stage and Crookston used different
# software to compute values

errorStats(mal,msn)

}

\references{
  Stage, A.R.; Crookston, N.L. (2007). Partitioning error components
  for accuracy-assessment of near neighbor methods of imputation.
  \emph{For. Sci.} 53(1):62-72.
  \url{https://www.fs.usda.gov/research/treesearch/28385}
}


\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com} \cr
  Albert R. Stage
}

\keyword{multivariate}


