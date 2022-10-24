\name{unionDataJoin}
\alias{unionDataJoin}
\title{Combines data from several sources}

\description{
  Takes any combination of several data frames or matrices and creates a new data
  frame. The rows are defined by a union of all row names in the arguments,
  and the columns are defined by a union of all column names in the arguments. The data
  are loaded into this new frame where column and row names match the individual
  inputs. Duplicates are tolerated with the last one specified being the one
  kept. NAs are returned for combinations of rows and columns where no data
  exist. Factors are processed as necessary.}

\usage{
unionDataJoin(\dots,warn=TRUE)
}

\arguments{
  \item{\dots}{a list of data frames, matrices, or any combination.}
  \item{warn}{when TRUE, warn when a column name is found in more than one data source.}
}

\examples{
require(yaImpute)

d1=data.frame(x1=c("a","b","c","d","e","f"))
d2=data.frame(x1=as.character(seq(1,4)),row.names=seq(5,8))
d3=data.frame(x2=seq(1:10))

# note the levels
levels(d1$x1)
# [1] "a" "b" "c" "d" "e" "f"

levels(d2$x1)
# [1] "1" "2" "3" "4"

all=unionDataJoin(d1,d2,d3,warn=FALSE)
all
#      x1 x2
# 1     a  1
# 2     b  2
# 3     c  3
# 4     d  4
# 5     1  5
# 6     2  6
# 7     3  7
# 8     4  8
# 9  <NA>  9
# 10 <NA> 10

levels(all$x1)
# [1] "1" "2" "3" "4" "a" "b" "c" "d"

}

\value{
  A data frame.
}

\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com} \cr
  Andrew O. Finley \email{finleya@msu.edu}
}

\keyword{misc}

