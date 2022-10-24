\name{plot.notablyDifferent}
\alias{plot.notablyDifferent}
\title{Plots the scaled root mean square differences between observed and predicted}

\description{
  Provides a descriptive plot of the \emph{Imputation Error Profile} for object(s) 
  created by \code{\link{notablyDifferent}}. 
}

\usage{
\method{plot}{notablyDifferent}(x,add=FALSE,\dots)
}

\arguments{
  \item{x}{\enumerate{
    \item an object create by \code{\link{notablyDifferent}}, or 
    \item a (named) list of such objects.}}
  \item{add}{set \code{TRUE} if you want to add this plot to an existing plot.}
  \item{\dots}{passed to plot functions.}
}

\seealso{
\code{\link{notablyDistant}} and \code{\link{yai}}}

\examples{
require(yaImpute)

data(iris)

set.seed(12345)

# form some test data
refs=sample(rownames(iris),50)
x <- iris[,1:3]      # Sepal.Length Sepal.Width Petal.Length
y <- iris[refs,4:5]  # Petal.Width Species

mal <- notablyDifferent(yai(x=x,y=y,method="mahalanobis"),vars=colnames(x))
if (require(randomForest))
{
  rf  <- notablyDifferent(yai(x=x,y=y,method="randomForest"),vars=colnames(x))
  plot.notablyDifferent(list(Mahalanobis=mal,randomForest=rf))
}

}

\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com} \cr
}

\keyword{hplot}


