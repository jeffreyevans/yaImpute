\name{plot.varSel}
\alias{plot.varSel}
\title{Boxplot of mean Mahalanobis distances from varSelection()}

\description{
  Provides a descriptive plot of now the mean Mahalanobis distances change
  as variables are added or deleted using \code{\link{varSelection}}.
 }

\usage{
\method{plot}{varSel}(x,main=NULL,nbest=NULL,arrows=TRUE,\dots)
}

\arguments{
  \item{x}{an object create by \code{\link{varSelection}}}
  \item{main}{becomes the plot title, if NULL one is generated}
  \item{nbest}{number of variables designated in the plot as the best;
   if null the number is computed by \code{\link{bestVars}}}
  \item{arrows}{if true, an arrow is added to the plot designating 
    the best variables.}
  \item{\dots}{passed to boxplot functions}
}

\seealso{
\code{\link{varSelection}} and \code{\link{yai}}}

\examples{
require(yaImpute)

data(iris)
set.seed(12345)

x <- iris[,1:2]  # Sepal.Length Sepal.Width 
y <- iris[,3:4]  # Petal.Length Petal.Width 

vsel <- varSelection(x=x,y=y,nboot=5,useParallel=FALSE)

plot(vsel)

}

\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com} \cr
}

\keyword{multivariate}

