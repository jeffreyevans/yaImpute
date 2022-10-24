\name{plot.compare.yai}
\alias{plot.compare.yai}
\title{Plots a compare.yai object}

\description{
  Provides a matrix of plots for objects created by \code{\link{compare.yai}}.
}

\usage{
\method{plot}{compare.yai}(x,pointColor=1,lineColor=2,\dots)
}

\arguments{
  \item{x}{a data frame created by \code{\link{compare.yai}}.}
  \item{pointColor}{the color used for the points.}
  \item{lineColor}{the color of the 1:1 line.}
  \item{\dots}{passed to plot functions.}
}

\seealso{
\code{\link{yai}}, \code{\link{compare.yai}},
\code{\link{impute.yai}}, \code{\link{rmsd.yai}}
}


\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com} \cr
  Andrew O. Finley \email{finleya@msu.edu}
}

\keyword{hplot}


