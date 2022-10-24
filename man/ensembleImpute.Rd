\name{ensembleImpute}
\alias{ensembleImpute}
\title{Computes the mean, median, or mode among a list of impute.yai objects}

\description{Several objects of class \code{\link{impute.yai}} or \code{\link{yai}} 
are combined by computing the mean, median, or mode of separate, individual imputations.
The intention is that the members of the first argument would be formed by running 
yai several times with \code{bootstrap=TRUE} or by varying other options. 
}

\usage{
ensembleImpute(imputes, method="mean",\dots)
}

\arguments{
  \item{imputes}{a list of objects class \code{\link{impute.yai}} or \code{\link{yai}}. 
        Function \code{\link{impute.yai}} is called for list members where the class is yai.}
  \item{method}{when "mean", the continuous variables are averaged using \code{mean},
        otherwise the \code{median} is used. Mode is always used for character data 
        (generally the case for factors).}
  \item{\dots}{passed to \code{\link{impute.yai}}.}
}

\value{
  An object of class \code{c("impute.yai","data.frame")}, see \code{\link{impute.yai}}.
  The attributes of the data.frame include the following:
  \itemize{
    \item{\code{sd }}{A data.frame of standard deviations for continuous variables
       if there are any. The columns are not reported if the standard deviation is
       zero for all observations which is typically true of "observed" values. }
    \item{\code{N }}{the number of replictions used to compute the corresponding data; 
       reported only if the number differs from the total number of replications. This 
       will be the case when \code{bootstrap}, \code{sampleVar}, or both are used in 
       \code{\link{yai}}.}
    \item{\code{methods }}{the method used for each variable.}
  }   
}

\seealso{
\code{\link{yai}} \code{\link{buildConsensus}} \code{\link{impute.yai}} 
}

\examples{

require (yaImpute)
data(iris)

set.seed(123) 

# form some test data, y's are defined only for reference
# observations.
refs=sample(rownames(iris),50)
x <- iris[,1:2]      # Sepal.Length Sepal.Width
y <- iris[refs,3:4]  # Petal.Length Petal.Width

reps <- replicate(10, yai(x=x,y=y,method="msn",bootstrap=TRUE,k=2),
                  simplify=FALSE)

ensembleImpute(reps,ancillaryData=iris)

}


\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com} \cr
  John Coulston \email{jcoulston@fs.fed.us}
}

\keyword{multivariate}

