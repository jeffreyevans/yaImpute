\name{newtargets}
\alias{newtargets}
\title{Finds K nearest neighbors for new target observations}

\description{
   Finds nearest neighbor \emph{reference} observations for a given set of \emph{target}
   observations using an established (see \code{\link{yai}}) object. Intended use is to
   facilitate breaking up large imputation problems (see \code{\link{AsciiGridImpute}}).
}

\usage{
newtargets(object,newdata,k=NULL,ann=NULL)
}

\arguments{
  \item{object}{an object of class \code{\link{yai}}.}
  \item{newdata}{a data frame or matrix of new \emph{targets} for which neighbors are
       are found. Must include at least the \emph{X}-variables used in the original call to
       \code{\link{yai}}.}
  \item{k}{if NULL, the value is taken from \code{object}, otherwise the number of nearest 
       neighbors to find.}
  \item{ann}{if NULL, the value is taken from \code{object}. When TRUE \code{\link{ann}} is
       used to find neighbors, and when FALSE a slow exact search is used.}
}

\value{
  An object of class \code{yai}, that is a copy of the first argument with the
  following elements replaced:
  \item{call}{the call.}
  \item{obsDropped}{a list of the row names for observations
     dropped for various reasons (missing data).}
  \item{trgRows}{a list of the row names for target observations
     as a subset of all observations.}
  \item{xall}{the \emph{X}-variables for all observations.}
  \item{neiDstTrgs}{a matrix of distances between a target
     (identified by its row name) and the k references. There are k columns.}
  \item{neiIdsTrgs}{a matrix of reference identifications
      that correspond to neiDstTrgs.}
  \item{neiDstRefs}{set NULL as if \code{noRefs=TRUE} in the original call to \code{\link{yai}}.}
  \item{neiIdsRefs}{set NULL as if \code{noRefs=TRUE} in the original call to \code{\link{yai}}.}
  \item{k}{the value of k, replaced if changed.}
  \item{ann}{the value of the ann argument.}
}

\seealso{
\code{\link{yai}}}

\examples{

require (yaImpute)

data(iris)

# set the random number seed so that example results are consistant
# normally, leave out this command
set.seed(12345)

# form some test data
refs=sample(rownames(iris),50) # just the reference observations
x <- iris[refs,1:3]  # Sepal.Length Sepal.Width Petal.Length
y <- iris[refs,4:5]  # Petal.Width Species

# build a yai object using mahalanobis
mal <- yai(x=x,y=y,method="mahalanobis")

# get imputations for the target observations (not references)
malNew <- newtargets(mal,iris[!(rownames(iris) \%in\% rownames(x)),])

# output a data frame of observed and imputed values for
# the observations that are not in the original yai object

impute(malNew,vars=yvars(malNew))

# in this example, Y is not specified (not required for mahalanobis).
mal2 <- yai(x=x,method="mahalanobis")
identical(foruse(mal),foruse(mal2))

if (require(randomForest))
{
  # here, method randomForest's unsupervised classification is used (no Y).
  rf <- yai(x=x,method="randomForest")
  # now get imputations for the targets in the iris data (those that are
  # not references).
  rfNew <- newtargets(rf,iris[!(rownames(iris) \%in\% rownames(x)),])
}

}


\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com} \cr
  Andrew O. Finley \email{finleya@msu.edu}
}

\keyword{multivariate}

