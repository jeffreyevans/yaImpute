\name{foruse}
\alias{foruse}
\title{Report a complete imputation}

\description{
  Provides a matrix of all observations with the reference observation
  identification best used to represent it, followed by the distance.
}

\usage{
foruse(object,kth=NULL,method="kth",targetsOnly=FALSE)
}

\arguments{
  \item{object}{an object created by \code{\link{yai}}}
  \item{kth}{when \code{NULL} (and \code{method="kth"}),
      the best pick is reported (a reference observation represents itself),
      otherwise the kth neighbor is picked.}
  \item{method}{the method used to select references to represent observations,
     as follows: \cr
   \code{kth}: the \emph{kth} nearest neighbor is picked; \cr
   \code{random}: for each observation, the value of \emph{kth} is selected at
     random from the 1 to \code{k} neighbors (1 to \code{kth} if is \code{kth}
     specified); \cr
   \code{randomWeighted}: \code{1/(1+d)} is used as a probability weight factor
     in selecting the value of \emph{kth}, where d is the distance..}
  \item{targetsOnly}{when is TRUE, reporting of references is not done.}
}


\examples{
require(yaImpute)

data(iris)

# form some test data
set.seed(1234)
refs=sample(rownames(iris),50)
x <- iris[,1:3]      # Sepal.Length Sepal.Width Petal.Length
y <- iris[refs,4:5]  # Petal.Width Species

# build a yai object using mahalanobis
mal <- yai(x=x,y=y,method="mahalanobis",k=3)

foruse(mal)  # for references, use is equal to the rowname
foruse(mal,kth=1) # for references, use is an row to the kth reference.

# get all the choices:
cbind(foruse(mal),foruse(mal,kth=1),foruse(mal,kth=2),foruse(mal,kth=3))

}

\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com} \cr
  Andrew O. Finley \email{finleya@msu.edu}
}

\keyword{multivariate}

