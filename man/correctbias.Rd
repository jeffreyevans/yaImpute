\name{correctBias}
\alias{correctBias}
\title{Correct bias by selecting different near neighbors}

\description{
   Change the neighbor selections in a \code{\link{yai}} object such that 
   bias (if any) in the average value of an \emph{expression} 
   of one or more variables is reduced to be within a defined 
   confidence interval. 
}

\usage{
correctBias(object,trgVal,trgValCI=NULL,nStdev=1.5,excludeRefIds=NULL,trace=FALSE)
}

\arguments{
  \item{object}{an object of class \code{\link{yai}} with \code{k > 1}.}
  \item{trgVal}{an \code{\link{expression}} defining a variable or combination of
    variables that is applied to each member of the population (see details). If 
    passed as a character string it is coerced into an expression. The expression can 
    refer to one or more X- and Y-variables defined for the reference observations.} 
  \item{trgValCI}{The confidence interval that should contain the \code{mean(trgVal)}.
    If the mean falls within this interval, the problem is solved. If \code{NULL}, the
    interval is based on \code{nStdev}.}
  \item{nStdev}{the number of standard deviations in the vector of values used to 
    compute the confidence interval when one is computed, ignored if \code{trgValCI} 
    is not \code{NULL}.}
  \item{excludeRefIds}{identities of reference observations to exclude from the 
    population, if coded as "all" then all references are excluded (see details).}
  \item{trace}{if \code{TRUE}, detailed output is produced.}
}

\details{
  Imputation as it is defined in \code{yaImpute} can yield biased
  results. Lets say that you have a collection of reference
  observations that happen to be selected in a non-biased way among a
  population. In this discussion, \emph{population} is a finite set of all
  individual sample units of interest; the reference plus target observations
  often represent this population (but this need not be true, see below). 
  If the average of a measured attribute is computed from
  this random sample, it is an unbiased estimate of the true mean. 
  \cr\cr  
  Using \code{\link{yai}}, while setting \emph{k=1}, values for each of several
  attributes are imputed from a single reference observation to a target
  observation. Once the imputation is done over all the target observations, an
  average of any one measured attribute can be computed over all the observations 
  in the population. There is no guarantee that this average will be within a 
  pre-specified confidence interval.
  \cr\cr
  Experience shows that despite any lack of guarantee, the results are accurate 
  (not biased). This tends to hold true when the reference data contains
  samples that cover the variation of the targets, even when they are not a
  random sample, and even if some of the reference observations are from sample
  units that are outside the target population. 
  \cr\cr
  Because there is no guarantee, and because the reference observations might
  profitably come from sample units beyond those in the population 
  (so as to insure all kinds of targets have a matching reference), it is necessary 
  to test the imputation results for bias. If bias is found, it would be helpful to 
  do something to correct it.
  \cr\cr
  The \code{correctBias()} function is designed to check for, and correct
  discovered bias by selecting alternative nearby reference observations 
  to be imputed to targets that contribute to the bias. The idea is that even if
  one reference is closest to a target, its attribute(s) of interest might 
  be greater (or less) than the mean. An alternative neighbor, one that may be
  almost as close, might reduce the overall bias if it were used instead. If this is
  the case, \code{correctBias()} switches the neighbor selections. 
  It makes as many switches as it can until the mean among the population 
  targets falls within the specified confidence interval. 
  There is no guarantee that the goal will be met.
  \cr\cr
  The details of the method are: 
  \cr\cr
  1. An attribute of interest is established by naming one in the call with
  argument \code{tarVal}. Note that this can be a simple variable name enclosed
  in quotations marks or it can be an \code{\link{expression}} of one or more variables. 
  If the former, it is converted into an expression that is executed in the 
  environment of the \code{reference} observations (both the X- and Y-variables). 
  A confidence interval is computed for this value under the assumption that the 
  reference observations are an unbiased sample of the target population. This may 
  not be the case. Regardless, a confidence interval is \emph{necessary} and it can
  alternatively be supplied using \code{trgValCI}. 
  \cr\cr
  2. One of several possible passes through the data are taken to find neighbor switches
  that will result in the bias being corrected. A pass includes computing the
  attribute of interest by applying the \code{expression} to values imputed to all 
  the targets, under the assumption that the next neighbor is used 
  in place of the currently used neighbor. This computation results in a 
  vector with one element for each target observation that 
  measures the contribution toward reducing the bias that would be made if 
  a switch were made. The target observations are then ordered 
  into increasing order of how much the distance from the currently selected 
  reference would increase if the switch were to take place. Enough switches are 
  made in this order to correct the bias. 
  If the bias is not corrected by the first pass, another pass is done 
  using the next neighbor(s).
  The number of possible passes is equal to \emph{k-1} where \emph{k} is
  set in the original call to \code{\link{yai}}. Note that switches are made
  among targets only, and never among reference observations that may make up the
  population. That is, reference observations are always left 
  to represent themselves with \code{k=1}.   
  \cr\cr
  3. Here are details of the argument \code{excludeRefIds}. When computing the mean
  of the attribute of interest (using the \code{expression}), 
  \code{correctBias()} must know which observations represent the
  population. Normally, all the target observations would be in this set, but perhaps
  not all of the reference observations. When \code{excludeRefIds} 
  is left NULL, the population is made of all reference and all
  target observations. Reference observations that should be left out
  of the calculations because they are not part of the population can be specified
  using the \code{excludeRefIds} argument as a vector of character strings identifing 
  the rownames to leave out, or a vector of row numbers that identify the row numbers to 
  leave out. If \code{excludeRefIds="all"}, all reference observations are excluded.
}

\value{
 An object of class \code{\link{yai}} where \code{k = 1} and the neighbor selections
 have been changed as described above. In addition, the \code{call} element is changed
 to show both the original call to \code{\link{yai}} and the call to this function. 
 A new list called \code{biasParameters} is added to the \code{\link{yai}} object  
 with these tags:
 
 \item{trgValCI}{the target CI.}
 \item{curVal}{the value of the bias that was achieved.}
 \item{npasses}{the number of passes through the data taken to achieve the result.}
 \item{oldk}{the old value of \code{k}.}
}

\seealso{
\code{\link{yai}}}

\examples{
data(iris)

set.seed(12345)

# form some test data
refs=sample(rownames(iris),50)
x <- iris[,1:3]      # Sepal.Length Sepal.Width Petal.Length
y <- iris[refs,4:5]  # Petal.Width Species

# build an msn run, first build dummy variables for species.

sp1 <- as.integer(iris$Species=="setosa")
sp2 <- as.integer(iris$Species=="versicolor")
y2 <- data.frame(cbind(iris[,4],sp1,sp2),row.names=rownames(iris))
y2 <- y2[refs,]

names(y2) <- c("Petal.Width","Sp1","Sp2")

# find 5 refernece neighbors for each target
msn <- yai(x=x,y=y2,method="msn",k=5)

# check for and correct for bias in mean "Petal.Width". Neighbor  
# selections will be changed as needed to bring the imputed values 
# into line with the CI. In this case, no changes are made (npasses 
# returns as zero).

msnCorr = correctBias(msn,trgVal="Petal.Width")
msnCorr$biasParameters

}

\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com} \cr
}

\keyword{misc}
\keyword{multivariate}


