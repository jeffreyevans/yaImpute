\name{yaiRFsummary}
\alias{yaiRFsummary}
\title{Build Summary Data For Method RandomForest }

\description{
  When method \code{randomforest} is used to build a \code{\link{yai}}
  object, the \code{\link[randomForest]{randomForest}} package computes
  several statistics. This function summarizes some of them, including
  the variable importance scores computed by function \code{\link{yaiVarImp}}.
}

\arguments{
  \item{object}{an object of class \code{\link{yai}}.}
  \item{nTop}{the \code{nTop} most important variables are plotted (returned).}
}

\usage{
yaiRFsummary(object, nTop=0)
}

\value{
  A list containing:
  \item{forestAttributes}{a data frame reporting the error rates and other data
     from the randomForest(s).}
  \item{scaledImportance}{the data frame computed by \code{\link{yaiVarImp}}.}
}

\seealso{
  \code{\link{yai}}, \code{\link{yaiVarImp}}
}

\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com} \cr
  Andrew O. Finley \email{finleya@msu.edu}
}

\keyword{misc}
\keyword{multivariate}
\keyword{tree}


