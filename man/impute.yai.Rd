\name{impute.yai}
\alias{impute.yai}
\alias{impute}
\title{Impute variables from references to targets}

\description{
   Imputes the observation for variables from a \emph{reference} observation to a
   \emph{target} observation. Also, imputes a value for a \emph{reference} from other
   \emph{references}. This practice is useful for validation (see \code{\link{yai}}). Variables
   not available in the original data may be imputed using argument \code{ancillaryData}.
}

\usage{
\method{impute}{yai}(object,ancillaryData=NULL,method="closest",
       method.factor=method,k=NULL,vars=NULL,
       observed=TRUE,\dots)
}

\arguments{
  \item{object}{an object of class \code{\link{yai}}.}
  \item{ancillaryData}{a data frame of variables that may not have been used in
       the original call to \code{\link{yai}}. There must be one row for
       each reference observation, no missing data, and row names must match those used
       in the reference observations.}
  \item{method}{the method used to compute the imputed values for continuous variables,
     as follows: \cr
   \code{closest}: use the single neighbor that is closest (this is the default and is
       always used when \emph{k}=1); \cr
   \code{mean}: the mean of the \emph{k} neighbors is taken;\cr
   \code{median}: the median of the \emph{k} neighbors is taken;\cr
   \code{dstWeighted}: a weighted mean is taken over the \emph{k} neighbors where the
       weights are 1/(1+d).}
  \item{method.factor}{the method used to compute the imputed values for factors, as follows: \cr
   \code{closest}: use the single neighbor that is closest (this is the default and is
       always used when \emph{k}=1); \cr
   \code{mean or median}: actually is the \emph{mode}\-\-it is the factor level that occurs
       the most often among the \emph{k} neighbors;\cr
   \code{dstWeighted}: a \emph{mode} where the count is the sum of the weights (1/(1+d)) rather than
       each having a weight of 1.}
  \item{k}{the number neighbors to use in averages, when NULL all present are used.}
  \item{vars}{a character vector of variables to impute, when NULL, the behaviour depends
     on the value of \code{ancillaryData}: when it is NULL, the Y-variables are imputed and 
     otherwise all present in \code{ancillaryData} are imputed.}
  \item{observed}{when TRUE, columns are created for \emph{observed} values (those from the
    \emph{target} observations) as well as imputed values (those from the
    \emph{reference} observations.}
  \item{\dots}{passed to other methods, currently not used.}
}

\value{
  An object of class \code{c("impute.yai","data.frame")}, with rownames
  identifying observations and column names identifying variables. When
  \emph{observed=TRUE} additional columns are created with a suffix of
  \emph{.o}. \cr\cr NA's fill columns of observed values when no
  corresponding value is known, as in the case for \emph{Y}-variables from
  \emph{target} observations.\cr\cr Scale factors for each variable are
  returned as an attribute (see \code{\link{attributes}}).
}

\seealso{
\code{\link{yai}}}

\examples{
require(yaImpute)

data(iris)

# form some test data
refs=sample(rownames(iris),50)
x <- iris[,1:3]      # Sepal.Length Sepal.Width Petal.Length
y <- iris[refs,4:5]  # Petal.Width Species

# build a yai object using mahalanobis
mal <- yai(x=x,y=y,method="mahalanobis")

# output a data frame of observed and imputed values
# of all variables and observations.

impute(mal)
malImp=impute(mal,ancillaryData=iris)
plot(malImp)

}

\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com} \cr
  Andrew O. Finley \email{finleya@msu.edu} \cr
  Emilie Henderson \email{emilie.henderson@oregonstate.edu}
}

\keyword{misc}
\keyword{multivariate}


