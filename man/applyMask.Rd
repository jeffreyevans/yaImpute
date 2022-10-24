\name{applyMask}
\alias{applyMask}
\title{Removes neighbors that share (or not) group membership with targets.}

\description{Some of the nearest neighbors found using \code{\link{yai}} or
\code{\link{newtargets}} are removed using this function. This is possible when there 
are several reference observations for each target as is the case with \emph{k>1}. 
The function removes neighbor reference observations for a given target if the reference
and target are in (a) the same group or (b) from different
groups, depending on the \code{method} used. Group membership is identified for 
reference and target observations using two vectors, \code{refGroups} for references 
and \code{trgGroups} for targets. If the group membership code is the same for a 
refernece and a target, then they are in the same group while different codes mean  
a lack of common group membership. 
}

\usage{
applyMask(object,refGroups=NULL, trgGroups=NULL, method="removeWhenCommon", k=1)
}

\arguments{
  \item{object}{an object of class \code{\link{yai}}.}
  \item{refGroups}{a vector, with length equal to the number of \emph{reference} observations, 
        of codes that indicate group membership.}
  \item{trgGroups}{a vector, with length equal to the number of \emph{target} observations, 
        of codes that indicate group membership. The data type and coding scheme of \code{refGroups} 
        and \code{trgGroups} must be the same.}
  \item{method}{is the strategy used for removing neighbors from the \code{object}, as follows:
    \itemize{
      \item{\code{removeWhenCommon }}{remove neighbors where the group membership of a
         target is the same as the group membership of the near neighbor reference (that is, keep 
         near neighbors if they are not in the same group).}
      \item{\code{keepWhenCommon }}{keep near neighbors only when the reference is in the same
         group as the target (that is, remove near neighbors if they are not in the same group).}
     }}
  \item{k}{the number of nearest neighbors to keep.}
}

\value{
  An object of class \code{yai}, that is a copy of the first argument with the
  following elements replaced:
  \item{call}{the call.}
  \item{neiDstTrgs}{a matrix of distances between a target
     (identified by its row name) and the k references. There are k columns.}
  \item{neiIdsTrgs}{a matrix of reference identifications
      that correspond to neiDstTrgs.}
  \item{neiDstRefs}{set NULL as if \code{noRefs=TRUE} in the original call to \code{\link{yai}}.}
  \item{neiIdsRefs}{set NULL as if \code{noRefs=TRUE} in the original call to \code{\link{yai}}.}
  \item{noRefs}{set TRUE regardless of original value.}
  \item{k}{the value of k.}
}

\seealso{
\code{\link{yai}} \code{\link{newtargets}}}

\examples{

require (yaImpute)

data(iris)

# build a base case, there are no targets, 
#    turn off getting references neighbors.
mal <- yai(x=iris[,-5],method="mahalanobis", noRefs = TRUE)

# create a new data, just a copy of the old with new row names.
iris2 <- iris
rownames(iris2) <- paste0("new.",rownames(iris))

# do an imputation with k=55
m55 <- newtargets(mal,newdata=iris2,k=55)

# get the 2 closest where the species codes don't match by
#  removing neighbors when the ref group membership is 
#  in common with the target group membership (same species),
#  thereby forcing neighbors to be from different species. 

#  in this case, the groups are species codes. 

applyMask(m55,refGroups=iris$Species,trgGroups=iris2$Species,
          method="removeWhenCommon",k=2)

# get the 2 closest where the species codes do match by
#  removing neighbors when the ref group membership is 
#  different than the target group membership (different species),
#  thereby forcing neighbors to be from the same species (this
#  is generally true anyway using the iris data). 

applyMask(m55,iris$Species,trgGroups=iris2$Species,
          method="keepWhenCommon",k=2)

}


\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com} \cr
  Acknowledgement: This function was inspired by correspondence with Clara Anton Fernandez.
}

\keyword{multivariate}

