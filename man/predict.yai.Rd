\name{predict.yai}
\alias{predict.yai}
\title{Generic predict function for class yai}

\description{Provides a generic interface for getting predicted values for \code{\link{yai}} objects.}

\usage{
\method{predict}{yai}(object,newdata,\dots)
}

\arguments{
  \item{object}{an object of class \code{\link{yai}} which is passed as argument to 
    \code{\link{newtargets}}, \code{\link{impute.yai}}, or both of these functions, see details.}
  \item{newdata}{a data frame that at a minimum contains the \emph{X}-variables for 
    new observations.}
  \item{\dots}{passed to \code{\link{newtargets}} and \code{\link{impute.yai}}, see details.}
}

\details{
When argument \code{newdata} is present function \code{\link{newtargets}} is called followed by a
call to \code{\link{impute.yai}}. If include in the \dots, the arguments \code{k} and \code{ann} 
are passed to \code{\link{newtargets}}. 

When argument \code{newdata} is absent, \code{\link{impute.yai}} is called without first calling
\code{\link{newtargets}}.

All of the \dots arguments are passed to \code{\link{impute.yai}}.

Another form of prediction in imputation is to get the identity of the imputed observations.
Use function \code{\link{foruse}} for this purpose.
}


\value{
  An object of class \code{impute.yai}.
}

\seealso{
\code{\link{foruse}}, \code{\link{newtargets}} \code{\link{impute.yai}}}

\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com}
}

\keyword{predict}

