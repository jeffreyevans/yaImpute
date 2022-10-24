\name{varSelection}
\alias{varSelection}
\title{Select variables for imputation models}

\description{
  Computes \code{\link{grmsd}} (generalized root mean square distance)   
  as variables are added to (\code{method="addVars"}) or removed from 
  (\code{method="delVars"}) an k-NN imputation model. When adding variables
  the function keeps variables that strengthen imputation and
  deletes that weaken the imputation the least.
  The measure of model strength is grmsd between
  imputed and observed \emph{Y}-variables among the reference observations.
}

\usage{
varSelection(x,y,method="addVars",yaiMethod="msn",imputeMethod="closest",
  wts=NULL,nboot=20,trace=FALSE,
  useParallel=if (.Platform$OS.type == "windows") FALSE else TRUE,...)
}

\arguments{
  \item{x}{a set of \emph{X}-Variables as used in \code{\link{yai}}.}
  \item{y}{a set of \emph{Y}-Variables as used in \code{\link{yai}}.}
  \item{method}{if \code{addVars}, the X-Varialbes are added and  
     if \code{delVars} they are deleted (see details).}
  \item{yaiMethod}{passed as \code{method} to \code{\link{yai}}.}
  \item{imputeMethod}{passed as \code{method} to \code{\link{impute.yai}}.}
  \item{wts}{passed as argument \code{wts} to \code{\link{grmsd}} 
     which is used to score the alternative varialbe sets.}
  \item{nboot}{the number of bootstrap samples used at each variable selection 
    step (see Details). When nboot is zero, NO bootstraping is done.} 
  \item{trace}{if \code{TRUE} information at each step is output.}
  \item{useParallel}{function \code{link{parallel:mclapply}} from \pkg{parallel} 
    will be used if it is available for running the bootstraps. It it is
    not available, \code{link{lapply}} is used (which is the only option
    on windows).} 
  \item{\dots}{passed to \code{link{yai}}}
}

\details{
This function tracks the effect on generalized root mean square distance 
(see \code{\link{grmsd}}) when variables are added or deleted one at a time. 
When adding variables, the function starts with none, and keeps the single 
variable that provides the smallest \code{grmsd}. When deleting variables, 
the functions starts with all \emph{X}-Variables and deletes them one at a 
time such that those that remain provide the smallest
\code{grmsd}. The function uses the following steps:

  \enumerate{
  \item Function \code{\link{yai}} is run for all the Y-variables and candidate
  X-variable(s). The result is passed to \code{\link{impute.yai}} to get imputed
  values of Y-variables. That result is passed to \code{\link{grmsd}} to compute a
  mean Mahalanobis distance for the case where the candidate variable is included
  (or deleted depending on \code{method}). However, these steps are done once
  for each bootstrap replication and the resulting values are averaged to provide
  an average mean Mahalanobis distance over the bootstraps. 
   
  \item Step one is done for each candidate X-variable forming a vector of 
  \code{\link{grmsd}} values, one corresponding to the case where each candidate
  is added or deleted. 
   
  \item When variables are being added (\code{method="addVars"}), the variable that
  is related to the smallest \code{grmsd} is kept. When variables are being 
  deleted (\code{method="delVars"}), the variable that
  is related to the largest \code{grmsd} is deleted.
          
  \item Once a variable has been added or deleted, the function proceeds to select
  another variable for selection or deletion by considering all remaining varialbes.
  }
}

\value{
 An list of class \code{varSel} with these tags:
 
 \item{call}{the call}
 \item{grmsd}{a 2-column matrix of the mean and std dev of the mean Mahalanobis 
   distances associated with adding or removing the variables stored as 
   the rownames. When nboot<2, the std dev are NA}
 \item{allgrmsd}{a list of the grmsd values that correspond to each bootstrap
   replication. The data in grmsd are based on these vectors of information.}  
 \item{method}{the value of argument \code{method}.}
}

\seealso{
\code{\link{yai}}, \code{\link{impute.yai}}, \code{\link{bestVars}} and 
\code{\link{grmsd}} 
}

\examples{
data(iris)

set.seed(12345)

x <- iris[,1:2]  # Sepal.Length Sepal.Width 
y <- iris[,3:4]  # Petal.Length Petal.Width 

vsel <- varSelection(x=x,y=y,nboot=5,useParallel=FALSE)
vsel

bestVars(vsel)

plot(vsel)

}

\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com} \cr
}

\keyword{multivariate}


