\name{yai}
\alias{yai}
\alias{yaImpute}
\title{Find K nearest neighbors}

\description{
  Given a set of observations, \code{yai} \enumerate{
  \item separates the observations into \emph{reference} and \emph{target} observations,
  \item applies the specified method to project X-variables into a Euclidean space (not
  always, see argument \code{method}), and 
  \item finds the \emph{k}-nearest neighbors within the referenece observations 
  and between the reference and target observations.
  } 
  An alternative method using \code{\link[randomForest]{randomForest}}
  classification and regression trees is provided for steps 2 and 3.
  \emph{Target} observations are those with values for X-variables and
  not for Y-variables, while \emph{reference} observations are those
  with no missing values for X-and Y-variables (see Details for the
  exception).
}

\usage{
yai(x=NULL,y=NULL,data=NULL,k=1,noTrgs=FALSE,noRefs=FALSE,
    nVec=NULL,pVal=.05,method="msn",ann=TRUE,mtry=NULL,ntree=500,
    rfMode="buildClasses",bootstrap=FALSE,ppControl=NULL,sampleVars=NULL,
    rfXsubsets=NULL)
}

\arguments{
  \item{x}{1) a matrix or data frame containing the X-variables for all
    observations with row names are the identification for the observations, or 2) a
    one-sided formula defining the X-variables as a linear formula. If
    a formula is coded for \code{x}, one must be used for \code{y} as well, if
    needed.}
  \item{y}{1) a matrix or data frame containing the Y-variables for the
    reference observations, or 2) a one-sided formula defining the
    Y-variables as a linear formula.}
  \item{data}{when \code{x} and \code{y} are formulas, then data is a data frame or
    matrix that contains all the variables with row names are the identification for the observations.
    The observations are split by \code{yai} into two sets.}
  \item{k}{the number of nearest neighbors; default is 1.}
  \item{noTrgs}{when TRUE, skip finding neighbors for target observations.}
  \item{noRefs}{when TRUE, skip finding neighbors for reference observations.}
  \item{nVec}{number of canonical vectors to use (methods \code{msn} and \code{msn2}),
     or number of independent of X-variables reference data when method
     \code{mahalanobis}. When NULL, the number is set by the function.}
  \item{pVal}{significant level for canonical vectors, used when \code{method} is
    \code{msn} or \code{msn2}.}
  \item{method}{is the strategy used for computing distance and therefore for finding neighbors; the
    options are quoted key words (see details):
    \itemize{
      \item{\code{euclidean }}{distance is computed in a normalized X space.}
      \item{\code{raw }}{like euclidean, except no normalization is done.}
      \item{\code{mahalanobis }}{ distance is computed in its namesakes space.}
      \item{\code{ica }}{like mahalanobis, but based on \emph{Independent Component Analysis} using
          package \code{\link[fastICA]{fastICA}}.}
      \item{\code{msn }}{distance is computed in a projected canonical space.}
      \item{\code{msn2 }}{like msn, but with variance weighting (canonical regression
            rather than correlation).}
      \item{\code{msnPP }}{like msn, except that the canonical correlation is computed using
            projection pursuit from \pkg{ccaPP} (see argument \code{ppControl}).}
      \item{\code{gnn }}{ distance is computed using a projected ordination of
         Xs found using canonical correspondence analysis
         (\code{\link[vegan]{cca}} from package \pkg{vegan}). 
         If \code{\link[vegan]{cca}} fails, \code{\link[vegan]{rda}} is used
         and a warning is issued.}
      \item{\code{randomForest }}{ distance is one minus the proportion of 
         \pkg{randomForest} trees where a target observation is in the same terminal node 
         as a reference observation (see \code{\link[randomForest]{randomForest}}).}
      \item{\code{random }}{ like raw except that the X space is a single vector of uniform random [0,1]
         numbers generated using \code{\link[stats]{runif}}, results in random assignment of neighbors,
         and forces \code{ann} to be FALSE.}
      \item{\code{gower }}{ distance is computed in its namesakes space using function 
        \code{\link[gower]{gower_topn}} from package \pkg{gower}; forces \code{ann} to be FALSE.}
    }   
  }
  \item{ann}{TRUE if \code{\link{ann}} is used to find neighbors, FALSE if a slow search is used.}
  \item{mtry}{the number of X-variables picked at random when method is \code{randomForest},
      see \code{\link[randomForest]{randomForest}}, default is sqrt(number of X-variables).}
  \item{ntree}{the number of classification and regression trees when method is \code{randomForest}.
      When more than one Y-variable is used, the trees are divided among the variables.
      Alternatively, ntree can be a vector of values corresponding to each Y-variable.}
  \item{rfMode}{when \code{buildClasses} and method is \code{randomForest}, continuous variables
      are internally converted to classes forcing randomForest to build classification trees for
      the variable. Otherwise, regression trees are built if your version of
      \pkg{randomForest} is newer than \code{4.5-18}.}
  \item{bootstrap}{if \code{TRUE}, the reference observations are sampled with replacement.}
  \item{ppControl}{used to control how canoncial correlation analysis via 
      projection pursuit is done, see Details.}
  \item{sampleVars}{the X- and/or Y-variables will be sampled (without replacement) 
      if this is not NULL and greater than zero. If specified as a single unnamed value, 
      that value is used to control the sample size of both X and Y variables. If two unnamed values, 
      then the first is taken for X-variables and the second for Y-variables. 
      If zero, no sampling is done. Otherwise, values are less than 1.0 they are taken as 
      the proportion of the number of variables. Values greater or equal to 1 are number of 
      variables to be included in the sample. Specification of a large number will cause the 
      sequence of variables to be randomized.}
  \item{rfXsubsets}{a named list of character vectors where there is one vector for each
      Y-variable, see details, only applies when \code{method="randomForest"}}
}

\details{
See the paper at \url{https://doi.org/10.18637/jss.v023.i10} (it includes examples).

The following information is in addition to the content in the papers.

You need not have any Y-variables to run yai for the following methods:
\code{euclidean}, \code{raw}, \code{mahalanobis}, \code{ica}, \code{random}, and
\code{randomForest} (in which case unsupervised classification is
performed). However, normally \code{yai} classifies \emph{reference}
observations as those with no missing values for X- and Y- variables and
\emph{target} observations are those with values for X- variables and
missing data for Y-variables. When Y is NULL (there are no Y-variables),
all the observations are considered \emph{references}. See
\code{\link{newtargets}} for an example of how to use yai in this
situation.

When \code{bootstrap=TRUE} the reference observations are sampled with replacement. The
sample size is set to the number of reference observations. Normally, about a third of
the reference observations are left out of the sample; they are often called out-of-bag 
samples. The out-of-bag observations are then treated as targets.

When \code{method="msnPP"} projection pursuit from \pkg{ccaPP} is used. The method is
further controlled using argument \code{ppControl} to specify a character vector that has 
has two named components.
  \itemize{
    \item{\code{method }}{One of the following 
      \code{"spearman", "kendall", "quadrant", "M", "pearson"}, default is "spearman"}
    \item{\code{search }}{If \code{"data"} or \code{"proj"}, then \code{\link[ccaPP]{ccaProj}} 
      is used, otherwise the default \code{\link[ccaPP]{ccaGrid}} is used.}
  }
  
Here are some details on argument \code{rfXsubsets}. When \code{method="randomForest"} 
one call to \code{\link[randomForest]{randomForest}} is generated for for each Y-variable. When
argument \code{rfXsubsets} is left \code{NULL}, all the X-variables are used for each of 
the Y-variables. However, sometimes better results can be achieved by using specific subsets
of X-variables for each Y-variable. This is done by setting \code{rfXsubsets} equal
to a named list of character vectors. The names correspond to the Y-variable names and the
character vectors hold the list of X-variables for the corresponding Y-variable. 
}


\value{
  An object of class \code{yai}, which is a list with
  the following tags:
  \item{call}{the call.}
  \item{yRefs, xRefs}{matrices of the X- and Y-variables for just
     the reference observations (unscaled). The scale factors
     are attached as attributes.}
  \item{obsDropped}{a list of the row names for observations
     dropped for various reasons (missing data).}
  \item{trgRows}{a list of the row names for target observations
     as a subset of all observations.}
  \item{xall}{the X-variables for all observations.}
  \item{cancor}{returned from cancor function when method \code{msn} or
    \code{msn2} is used (NULL otherwise).}
  \item{ccaVegan}{an object of class cca (from package \pkg{vegan}) when
    method \emph{gnn} is used.}
  \item{ftest}{a list containing partial F statistics and a vector of
    Pr>F (pgf) corresponding to the canonical correlation coefficients
    when method msn or msn2 is used (NULL otherwise).}
  \item{yScale, xScale}{scale data used on yRefs and xRefs as needed.}
  \item{k}{the value of \emph{k}.}
  \item{pVal}{as input; only used when method \code{msn}, \code{msn2} or \code{msnPP} is used.}
  \item{projector}{NULL when not used. For methods \code{msn}, \code{msn2}, \code{msnPP}, \code{gnn}
     and \code{mahalanobis}, this is a matrix that projects normalized X-variables
     into a space suitable for doing Eculidian distances.}
  \item{nVec}{number of canonical vectors used (methods \code{msn} and \code{msn2}),
     or number of independent X-variables in the reference data when method
     \code{mahalanobis} is used.}
  \item{method}{as input, the method used.}
  \item{ranForest}{a list of the forests if method \code{randomForest} is used. There is
     one forest for each Y-variable, or just one forest when there are no
     Y-variables.}
  \item{ICA}{a list of information from \code{\link[fastICA]{fastICA}}
      when method \code{ica} is used.}
  \item{ann}{the value of ann, TRUE when \code{\link{ann}} is used, FALSE otherwise.}
  \item{xlevels}{NULL if no factors are used as predictors; otherwise a list
        of predictors that have factors and their levels (see \code{\link[stats]{lm}}).}
  \item{neiDstTrgs}{a matrix of distances between a target
     (identified by its row name) and the \emph{k} references. There are \emph{k} columns.}
  \item{neiIdsTrgs}{a matrix of reference identifications
      that correspond to neiDstTrgs.}
  \item{neiDstRefs, neiIdsRefs}{counterparts for references.}
  \item{bootstrap}{a vector of reference rownames that constitute the bootstrap sample; 
      or the value \code{FALSE} when bootstrap is not used.}
}

\seealso{
\code{\link{grmsd}} \code{\link{ensembleImpute}} 
}


\examples{

require (yaImpute)

data(iris)

# set the random number seed so that example results are consistent
# normally, leave out this command
set.seed(12345)

# form some test data, y's are defined only for reference
# observations.
refs=sample(rownames(iris),50)
x <- iris[,1:2]      # Sepal.Length Sepal.Width
y <- iris[refs,3:4]  # Petal.Length Petal.Width

# build yai objects using 2 methods
msn <- yai(x=x,y=y)
mal <- yai(x=x,y=y,method="mahalanobis")
# compare these results using the generalized mean distances. mal wins!
grmsd(mal,msn)

# use projection pursuit and specify ppControl (loads package ccaPP)
if (require(ccaPP)) 
{
  msnPP <- yai(x=x,y=y,method="msnPP",ppControl=c(method="kendall",search="proj"))
  grmsd(mal,msnPP,msn)
}

#############

data(MoscowMtStJoe)

# convert polar slope and aspect measurements to cartesian
# (which is the same as Stage's (1976) transformation).

polar <- MoscowMtStJoe[,40:41]
polar[,1] <- polar[,1]*.01      # slope proportion
polar[,2] <- polar[,2]*(pi/180) # aspect radians
cartesian <- t(apply(polar,1,function (x)
               {return (c(x[1]*cos(x[2]),x[1]*sin(x[2]))) }))
colnames(cartesian) <- c("xSlAsp","ySlAsp")
x <- cbind(MoscowMtStJoe[,37:39],cartesian,MoscowMtStJoe[,42:64])
y <- MoscowMtStJoe[,1:35]

msn <- yai(x=x, y=y, method="msn", k=1)
mal <- yai(x=x, y=y, method="mahalanobis", k=1)
# the results can be plotted.
plot(mal,vars=yvars(mal)[1:16])

# compare these results using the generalized mean distances..
grmsd(mal,msn)

# try method="gower"
if (require(gower))
{
  gow <- yai(x=x, y=y, method="gower", k=1)
  # compare these results using the generalized mean distances..
  grmsd(mal,msn,gow)
}

# try method="randomForest"
if (require(randomForest))
{
  # reduce the plant community data for randomForest.
  yba  <- MoscowMtStJoe[,1:17]
  ybaB <- whatsMax(yba,nbig=7)  # see help on whatsMax
  
  rf <- yai(x=x, y=ybaB, method="randomForest", k=1)
  
  # build the imputations for the original y's
  rforig <- impute(rf,ancillaryData=y)
  
  # compare the results using individual rmsd's
  compare.yai(mal,msn,rforig)
  plot(compare.yai(mal,msn,rforig))
  
  # build another randomForest case forcing regression
  # to be used for continuous variables. The answers differ
  # but one is not clearly better than the other.
  
  rf2 <- yai(x=x, y=ybaB, method="randomForest", rfMode="regression")
  rforig2 <- impute(rf2,ancillaryData=y)
  compare.yai(rforig2,rforig)
}
  
}


\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com} \cr
  John Coulston \email{jcoulston@fs.usda.gov} \cr
  Andrew O. Finley \email{finleya@msu.edu} 
}

\keyword{multivariate}

