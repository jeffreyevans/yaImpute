
\name{ann}
\alias{ann}
\title{Approximate nearest neighbor search routines}

\description{
  Given a set of reference data points \eqn{S}, \code{ann} constructs a
  kd-tree or box-decomposition tree (bd-tree) for efficient \eqn{k}-nearest
  neighbor searches.
}

\usage{
ann(ref, target, k=1, eps=0.0, tree.type="kd",
    search.type="standard", bucket.size=1, split.rule="sl_midpt",
    shrink.rule="simple", verbose=TRUE, \dots)
}

\arguments{
  \item{ref}{an \eqn{n \times d}{n x d} matrix containing the reference point set
    \eqn{S}. Each row in \code{ref} corresponds to a point in \eqn{d}-dimensional space. }
  \item{target}{an \eqn{m \times d}{m x d} matrix containing the points
    for which \eqn{k} nearest neighbor reference points are sought. }
  \item{k}{defines the number of nearest neighbors to find. The default
    is \eqn{k}=1. }
  \item{eps}{the \eqn{i^{th}}{i-th} nearest neighbor is at most
    (1+\code{eps}) from true \eqn{i^{th}}{i-th} nearest neighbor, where \code{eps}\eqn{\ge 0}{>=0} . Specifically, the true (not
    squared) difference between the true \eqn{i^{th}}{i-th} and the
    approximation of the \eqn{i^{th}}{i-th} point is a factor of
    (1+\code{eps}). The default value of \code{eps}=0 is an exact
    search. }
  \item{tree.type}{the data structures kd-tree or bd-tree as
    quoted key words \emph{kd} and \emph{bd}, respectively.  A brute force
    search can be specified with the quoted key word \emph{brute}. If
    \emph{brute} is specified, then all subsequent arguments are
    ignored.  The default is the kd-tree. }
  \item{search.type}{either standard or priority search in the kd-tree
    or bd-tree, specified by quoted key words \emph{standard} and \emph{priority},
    respectively. The default is the standard search. }
  \item{bucket.size}{the maximum number of reference points in the leaf
    nodes. The default is 1. }
  \item{split.rule}{is the strategy for the recursive splitting of those
    nodes with more points than the bucket size.  The splitting
    rule applies to both the kd-tree and bd-tree.  Splitting rule
    options are the quoted key words:
    \itemize{
      \item{\code{standard}}{ - standard kd-tree}
      \item{\code{midpt}}{ - midpoint}
      \item{\code{fair}}{ - fair-split}
      \item{\code{sl\_midpt}}{ - sliding-midpoint (default)}
      \item{\code{sl\{fair}}{ - fair-split rule}
    }
    See supporting documentation, reference below, for a thorough
    description and discussion of these splitting rules. }
  \item{shrink.rule}{applies only to the bd-tree and is an additional
    strategy (beyond the splitting rule) for the recursive partitioning
    of nodes.  This argument is ignored if \code{tree.type} is specified
    as \emph{kd}. Shrinking rule options are quoted key words:
    \itemize{
      \item{\code{none}}{ - equivalent to the kd-tree}
      \item{\code{simple}}{ - simple shrink (default)}
      \item{\code{centroid}}{ - centroid shrink}
    }
    See supporting documentation, reference below, for a thorough description and
    discussion of these shrinking rules. }
  \item{verbose}{if true, search progress is printed to the screen. }
  \item{\dots}{currently no additional arguments. }
}

\value{
  An object of class \code{ann}, which is a list with some or all of
  the following tags:
  \item{knnIndexDist}{an \eqn{m \times 2k}{m x 2k} matrix.
    Each row corresponds to a target point in \code{target} and columns
    1:\eqn{k} hold the \code{ref} matrix row indices of the nearest
    neighbors, such that column 1 index holds the \code{ref} matrix row
    index for the first nearest
    neighbor and column \eqn{k} is the \eqn{k^{th}}{k-th} nearest
    neighbor index.  Columns \eqn{k+1}:2k hold the Euclidean distance from the
    target to each of the \eqn{k} nearest neighbors indexed in columns 1:\eqn{k}. }
  \item{searchTime}{total search time, not including data structure
    construction, etc. }
  \item{k}{as defined in the \code{ann} function call. }
  \item{eps}{as defined in the \code{ann} function call. }
  \item{tree.type}{as defined in the \code{ann} function call. }
  \item{search.type}{as defined in the \code{ann} function call. }
  \item{bucket.size}{as defined in the \code{ann} function call. }
  \item{split.rule}{as defined in the \code{ann} function call. }
  \item{shrink.rule}{as defined in the \code{ann} function call. }
}

\details{
  The \code{ann} function calls portions of the Approximate Nearest
  Neighbor Library, written by David M. Mount.  All of the \code{ann}
  function arguments are detailed in the ANN Programming Manual
  found at \url{https://www.cs.umd.edu/~mount/ANN}.
}


\author{
  Andrew O. Finley \email{finleya@msu.edu} \cr
}

\examples{

## Make a couple of bivariate normal classes
rmvn <- function(n, mu=0, V = matrix(1))
{
  p <- length(mu)
  if(any(is.na(match(dim(V),p))))
    stop("Dimension problem!")
  D <- chol(V)
  matrix(rnorm(n*p), ncol=p) \%*\% D + rep(mu,rep(n,p))
}

m <- 10000

## Class 1.
mu.1 <- c(20, 40)
V.1 <- matrix(c(-5,1,0,5),2,2); V.1 <- V.1\%*\%t(V.1)
c.1 <- cbind(rmvn(m, mu.1, V.1), rep(1, m))

## Class 2.
mu.2 <- c(30, 60)
V.2 <- matrix(c(4,2,0,2),2,2); V.2 <- V.2\%*\%t(V.2)
c.2 <- cbind(rmvn(m, mu.2, V.2), rep(2, m))

## Class 3.
mu.3 <- c(15, 60)
V.3 <- matrix(c(5,5,0,5),2,2); V.3 <- V.3\%*\%t(V.3)
c.3 <- cbind(rmvn(m, mu.3, V.3), rep(3, m))

c.all <- rbind(c.1, c.2, c.3)
max.x <- max(c.all[,1]); min.x <- min(c.all[,1])
max.y <- max(c.all[,2]); min.y <- min(c.all[,2])

## Check them out.
plot(c.1[,1], c.1[,2], xlim=c(min.x, max.x), ylim=c(min.y, max.y),
     pch=19, cex=0.5,
     col="blue", xlab="Variable 1", ylab="Variable 2")
points(c.2[,1], c.2[,2], pch=19, cex=0.5, col="green")
points(c.3[,1], c.3[,2], pch=19, cex=0.5, col="red")


## Take a reference sample.
n <- 2000
ref <- c.all[sample(1:nrow(c.all), n),]

## Compare search times
k <- 10
## Do a simple brute force search.
brute <- ann(ref=ref[,1:2], target=c.all[,1:2],
             tree.type="brute", k=k, verbose=FALSE)
print(brute$searchTime)

## Do an exact kd-tree search.
kd.exact <- ann(ref=ref[,1:2], target=c.all[,1:2],
                tree.type="kd", k=k, verbose=FALSE)
print(kd.exact$searchTime)

## Do an approximate kd-tree search.
kd.approx <- ann(ref=ref[,1:2], target=c.all[,1:2],
                 tree.type="kd", k=k, eps=100, verbose=FALSE)
print(kd.approx$searchTime)

## Takes too long to calculate for this many targets.
## Compare overall accuracy of the exact vs. approximate search
##knn.mode <- function(knn.indx, ref){
##  x <- ref[knn.indx,]
##  as.numeric(names(sort(as.matrix(table(x))[,1],
##                        decreasing=TRUE))[1])
##}

}

\keyword{misc}
