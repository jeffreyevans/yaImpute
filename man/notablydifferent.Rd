\name{notablyDifferent}
\alias{notablyDifferent}
\title{Finds obervations with large differences between observed and imputed values}

\description{
   This routine identifies observations with large errors as measured by scaled 
   root mean square error (see \code{\link{rmsd.yai}}). A \emph{threshold} 
   is used to detect observations with large differences.
}

\usage{
notablyDifferent(object,vars=NULL,threshold=NULL,p=.05,...)
}

\arguments{
  \item{object}{an object of class \code{\link{yai}}.}
  \item{vars}{a vector of character strings naming the variables to use, if 
       null the X-variables form \code{object} are used.}
  \item{threshold}{a threshold that if exceeded the observations are listed as 
        \emph{notably} different.}
  \item{p}{\code{(1-p)*100} is the percentile point in the distribution 
           of differences used to compute the threshold (used when 
           \code{threshold} is NULL).}
  \item{...}{additional arguments passed to \code{\link{impute.yai}}.} 
}

\details{
  The scaled differences are computed a follows:
  \enumerate{
  \item A matrix of differences between observed and imputed values is 
    computed for each observation (rows) and each variable (columns).
  \item These differences are scaled by dividing by the standard deviation
    of the observed values among the \emph{reference} observations.
  \item The scaled differences are squared.
  \item Row means are computed resulting in one value for each observation. 
  \item The square root of each of these values is taken.
  }
  
  These values are Euclidean distances between the target 
  observations and their nearest references as measured using specified variables. All
  the variables that are used must have observed and imputed values. Generally, this
  will be the \emph{X}-variables and not the \emph{Y}-variables. 
  
  When \code{threshold} is NULL, the function computes one using the 
  \code{\link{quantile}} function with its default arguments and \code{probs=1-p}.
}

\value{
  A named list of several items. In all cases vectors are named using the observation
  ids which are the row names of the data used to build the \code{\link{yai}}object.
  \item{call}{The call.}
  \item{vars}{The variables used (may be fewer than requested).}
  \item{threshold}{The threshold value.} 
  \item{notablyDifferent.refs}{A sorted named vector of \emph{references} that exceed 
    the threshold.}
  \item{notablyDifferent.trgs}{A sorted named vector of \emph{targets} that exceed 
    the threshold.}
  \item{rmsdS.refs}{A sorted named vector of scaled RMSD \emph{references}.}
  \item{rmsdS.trgs}{A sorted named vector of scaled RMSD \emph{targets}.} 
}


\seealso{
\code{\link{notablyDistant}}, \code{\link{plot.notablyDifferent}}, 
\code{\link{yai}}, \code{\link{grmsd}}
}

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

notablyDifferent(msn)

}

\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com} \cr
}


\keyword{multivariate}


