\name{vars}
\alias{vars}
\alias{xvars}
\alias{yvars}
\title{List variables in a yai object}

\description{Provides a character vector, or a list of character vectors
  of all the variables in a \code{\link{yai}} object,
  just the X-variables (\code{xvars}), or just the Y-variables (\code{yvars}).}

\usage{
vars(object)
xvars(object)
yvars(object)
}

\arguments{
  \item{object}{an object created by \code{\link{yai}}.}
}

\value{
  \item{yvars}{A charactor vector of \emph{Y}-variables.}
  \item{xvars}{A charactor vector of \emph{X}-variables.}
  \item{vars}{A list of both vectors.}
}

\seealso{
\code{\link{yai}}}

\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com} \cr
  Andrew O. Finley \email{finleya@msu.edu}
}

\keyword{misc}

