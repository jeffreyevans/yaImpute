\name{bestVars}
\alias{bestVars}
\title{Computes the number of \emph{best} X-variables}

\description{
  The number of \emph{best} variables is estimated by finding an 
  apparent inflection point in the relationship between the 
  generalized root mean square distance (see \code{\link{grmsd}} and the number
  of \emph{X}-variables. 
 }

\usage{
bestVars(obj,nbest=NULL)
}

\arguments{
  \item{obj}{an object create by \code{\link{varSelection}}}
  \item{nbest}{number of variables designated as the best;
   if null the number is estimated}
}

\value{
 An character vector of variable names in decreasing order of importance.
}



\seealso{
\code{\link{varSelection}}
}

\examples{
require(yaImpute)

data(iris)
set.seed(12345)

x <- iris[,1:2]  # Sepal.Length Sepal.Width 
y <- iris[,3:4]  # Petal.Length Petal.Width 

vsel <- varSelection(x=x,y=y,nboot=5,useParallel=FALSE)

bestVars(vsel)

}

\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com} \cr
}

\keyword{multivariate}

