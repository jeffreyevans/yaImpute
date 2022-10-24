\name{mostused}
\alias{mostused}
\title{Tabulate references most often used in imputation}

\description{
  Provides a matrix of reference observations that are used most often
  as sources of imputation and a column of the counts. The observations
  are listed in sorted order, most often used first.
}

\usage{
mostused(object,n=20,kth=NULL)
}

\seealso{
  \code{\link{yai}}
}

\arguments{
  \item{object}{(1) a data frame created by \code{\link{foruse}}, or (2) an object
    created by \code{\link{yai}} in which case \code{\link{foruse}} is called automatically.}
  \item{n}{the number of mostused in sorted order.}
  \item{kth}{passed to \code{\link{foruse}}, if called.}
}

\examples{
require(yaImpute)

data(iris)

# form some test data
refs=sample(rownames(iris),50)
x <- iris[,1:3]      # Sepal.Length Sepal.Width Petal.Length
y <- iris[refs,4:5]  # Petal.Width Species

# build a yai object using mahalanobis
mal <- yai(x=x,y=y,method="mahalanobis")

mostused(mal,kth=1)

}

\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com} \cr
  Andrew O. Finley \email{finleya@msu.edu}
}

\keyword{misc}
\keyword{multivariate}


