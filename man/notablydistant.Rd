\name{notablyDistant}
\alias{notablyDistant}
\title{Find notably distant targets}

\description{
   Notably distant \emph{targets} are those with relatively large distances from the
   closest \emph{reference} observation. A suitable \emph{threshold} is used to
   detect large distances.
}

\usage{
notablyDistant(object,kth=1,threshold=NULL,p=0.01,method="distribution")
}

\arguments{
  \item{object}{an object of class \code{\link{yai}}.}
  \item{kth}{the kth neighbor is used.}
  \item{threshold}{the thereshold distance that identifies
        \emph{notably} large distances between observations.}
  \item{p}{\code{(1-p)*100} is the percentile point in the distribution 
           of distances used to compute the threshold (only used when 
           \emph{threshold} is NULL).}
  \item{method}{the method used to compute the \emph{threshold}, see details.} 
}

\details{
  When \code{threshold} is NULL, the function computes one using one of
  two methods. When \code{method} is "distribution", assumption is made that 
  distances follow the lognormal distribution, unless the method used
  to find neighbors is \code{randomForest}, in which case the distances
  are assumed to follow the beta distribution. A specified \code{p} value
  is used to compute the \code{threshold}, which is the point in the distribution
  where a fraction, \code{p}, of the neighbors are larger than the \code{threshold}.
  
  When \code{method} is "quantile", the function uses the \code{\link{quantile}} 
  function with \code{probs=1-p}.
}

\value{
  List of two data frames that contain 1) the \emph{references} that are notably
  distant from other \emph{references}, 2) the \emph{targets} that are notably distant
  from the \emph{references}, 3) the \emph{threshold} used, and 4) the \emph{method} used.
}

\seealso{
\code{\link{notablyDifferent}} \code{\link{yai}}}

\examples{
data(iris)

set.seed(12345)

# form some test data
refs=sample(rownames(iris),50)
x <- iris[,1:3]      # Sepal.Length Sepal.Width Petal.Length
y <- iris[refs,4:5]  # Petal.Width Species

# build an msn run, first build dummy variables for species.

sp1 <- as.integer(iris$Species=="setosa")
sp2 <- as.integer(iris$Species=="versicolor")
y2 <- data.frame(cbind(iris[,4],sp1,sp2),row.names=rownames(iris))
y2 <- y2[refs,]

names(y2) <- c("Petal.Width","Sp1","Sp2")

msn <- yai(x=x,y=y2,method="msn")

notablyDistant(msn)

}

\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com} \cr
}

\keyword{misc}
\keyword{multivariate}


