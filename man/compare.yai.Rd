\name{compare.yai}
\alias{compare.yai}
\title{Compares different k-NN solutions}

\description{Provides a convenient display of the root mean square differences
  (see \code{\link{rmsd.yai}}) or correlations (see \code{\link{cor.yai}}) between observed and
  imputed values for each of several imputations. Each column of the returned
  data frame corresponds to an imputation result and each row corresponds to a
  variable.
}

\usage{
compare.yai(\dots,ancillaryData=NULL,vars=NULL,method="rmsd",scale=TRUE)
}

\arguments{
  \item{\dots}{a list of objects created by \code{\link{yai}} or \code{\link{impute.yai}}
    that you wish to compare.}
  \item{ancillaryData}{a data frame that defines new variables, passed to \code{\link{impute.yai}}.}
  \item{vars}{a list of variable names you want to include; if NULL all available
    variables are included.}
  \item{method}{when \emph{rmsd} is specified, the comparison is based on root mean
    square differences between observed an imputed, and \cr
    when \emph{cor} is specified, the comparison is based on correlations between
    observed and imputed.}
  \item{scale}{passed to \code{\link{rmsd.yai}}}
}

\value{
  A data.frame of class \code{c("compare.yai","data.frame")}, where the columns
  are the names of the \dots-arguments and the rows are a union of
  variable names. NA's are returned when the variables are factors. The scale values (if used)
  are returned as an attribute (all if some are different than others, a warning is issued).
}

\seealso{
\code{\link{yai}}, \code{\link{plot.compare.yai}},
\code{\link{impute.yai}}, \code{\link{rmsd.yai}}
}


\examples{
require(yaImpute)

data(iris)

# form some test data
refs=sample(rownames(iris),50)
x <- iris[,1:2]      # Sepal.Length Sepal.Width
y <- iris[refs,3:4]  # Petal.Length Petal.Width

# build yai objects using 2 methods
msn <- yai(x=x,y=y)
mal <- yai(x=x,y=y,method="mahalanobis")

# compare the y variables
compare.yai(msn,mal)

# compare the all variables in iris
compare.yai(msn,mal,ancillaryData=iris)  # Species is a factor, no comparison is made
}


\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com} \cr
  Andrew O. Finley \email{finleya@msu.edu}
}

\keyword{multivariate}

