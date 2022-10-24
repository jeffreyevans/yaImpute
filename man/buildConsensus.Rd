\name{buildConsensus}
\alias{buildConsensus}
\title{Finds the consensus imputations among a list of yai objects}

\description{Several objects of class \code{\link{yai}} are combined into a new
object forming a consensus among the many. The intention is that the many would
be formed by running yai several times with \code{bootstrap=TRUE} or by varying
other options.
}

\usage{
buildConsensus(reps, noTrgs=FALSE, noRefs=FALSE, k=NULL)
}

\arguments{
  \item{reps}{a list of objects class \code{\link{yai}}.}
  \item{noTrgs}{If \code{TRUE} neighbor relationships for target observations are not merged.}
  \item{noRefs}{If \code{TRUE} neighbor relationships for reference observations are not merged.}
  \item{k}{If not specified, the minimum value of \code{k} among the objects is used.}
}

\value{
  An object of class \code{\link{yai}}
}

\seealso{
\code{\link{yai}} 
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

reps <- replicate(20, yai(x=x,y=y,method="msn",bootstrap=TRUE,k=2),
                  simplify=FALSE)

buildConsensus(reps)

}


\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com} \cr
  John Coulston \email{jcoulston@fs.fed.us} \cr
}

\keyword{multivariate}

