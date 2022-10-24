\name{AsciiGridImpute}
\alias{AsciiGridImpute}
\alias{AsciiGridPredict}
\title{Imputes/Predicts data for Ascii Grid maps}

\description{
   \code{AsciiGridImpute} finds nearest neighbor \emph{reference}
   observations for each point in the input grid maps and outputs maps
   of selected Y-variables in a corresponding set of output grid maps.

   \code{AsciiGridPredict} applies a predict function to each point in the
   input grid maps and outputs maps of the prediction(s) in corresponding 
   output grid maps (see Details).

  One row of each grid map is read and processed at a time thereby
  avoiding the need to build huge objects in R that would be necessary if all
  the rows of all the maps were processed together.}

\usage{
AsciiGridImpute(object,xfiles,outfiles,xtypes=NULL,ancillaryData=NULL,
                ann=NULL,lon=NULL,lat=NULL,rows=NULL,cols=NULL,
                nodata=NULL,myPredFunc=NULL,\dots)

AsciiGridPredict(object,xfiles,outfiles,xtypes=NULL,lon=NULL,lat=NULL,
                 rows=NULL,cols=NULL,nodata=NULL,myPredFunc=NULL,\dots)
}

\arguments{
  \item{object}{An object of class \code{\link{yai}}, any object for which
       a \code{\link[stats]{predict}} function is defined, or an object that is passed
       to a predict function you define using argument \code{myPredFunc}. See Details.}
  \item{xfiles}{A \code{\link[base]{list}} of input file names where there is one
       grid file for each X-variable. List elements must be given the same names
       as the X-variables they correspond with and there must be one file for
       each X-variable used when \code{object} was built.}
  \item{outfiles}{One of these two forms:
      \itemize{
       \item{(1) }{A file name that is understood to correspond to the single prediction
       returned by the generic \code{\link[stats]{predict}} function
       related to \code{object} or returned by \code{myPredFunc}. This form only
       applies to \code{AsciiGridPredict}, when the object is not class \code{yai}.}
       \item{(2) }{A \code{\link[base]{list}} of output file names where there is
       one grid file for each \emph{desired} output variable. While there may be
       many variables predicted for \code{object}, only those for which an
       output grid is desire need to be specified. Note that some predict functions return
       data frames, some return a single vector, and often what is returned depends on the
       value of arguments passed to predict. In addition to names of the
       predicted variables, the following two special names can be coded when
       the object class is \code{yai}: For \code{distance=}\emph{\dQuote{filename}}
       a map of the distances is output and if
       \code{useid=}\emph{\dQuote{filename}} a map of integer indices to row numbers of the
       reference observations is output.
       When the predict function returns a vector,
       an additional special name of \code{predict=}\emph{\dQuote{filename}} can be
       used.} }}
  \item{xtypes}{A list of data type names that corresponds exactly to data type of the
       maps listed in \code{xfiles}. Each value can be one of:
       \code{"logical", "integer", "numeric", "character"}. If NULL,
       or if a type is missing for a member of \code{xfiles}, type \code{"numeric"} is used.
       See Details if you used factors as predictors.}
  \item{ancillaryData}{A data frame of Y-variables that may not have been used in
       the original call to \code{\link{yai}}. There must be one row for
       each reference observation, no missing data, and row names must match those used
       in the original reference observations.}
  \item{ann}{if NULL, the value is taken from \code{object}. When TRUE, \code{\link{ann}} is
       used to find neighbors, and when FALSE a slow exact search is used (ignored for when
       method randomForest is used when the original \code{\link{yai}} object was created).}
  \item{lon}{if NULL, the value of \code{cols} is used. Otherwise, a 2-element
       vector given the range of longitudes (horizontal distance) desired for the output.}
  \item{lat}{if NULL, the value of \code{rows} is used. Otherwise, a 2-element
       vector given the range of latitudes (vertical distance) desired for the output.}
  \item{rows}{if NULL, all rows from the input grids are used. Otherwise, rows is a 2-element
       vector given the rows desired for the output. If the second element is greater than
       the number of rows, the header value \code{YLLCORNER} in the output is adjusted accordingly. 
       Ignored if \code{lon} is specified.}
  \item{cols}{if NULL, all columns from the input grids are used. Otherwise, cols is a 2-element
       vector given the columns desired for the output. If the first element is greater than
       one, the header value \code{XLLCORNER} in the output is adjusted accordingly. Ignored
       if \code{lat} is specified.}
  \item{nodata}{the \code{NODATA_VALUE} for the output. If NULL, the value is taken from the
       input grids.}
  \item{myPredFunc}{called by \code{AsciiGridPredict} to predict output using the \code{object} 
       and newdata from the \code{xfiles}. Two arguments are passed by \code{AsciiGridPredict} to this 
       function, the first is the value of \code{object} and the
       second is a data frame of the new predictor variables created for each row
       of data from your input maps. If NULL, the generic
       \code{predict} function is called for \code{object}.}
  \item{\dots}{passed to \code{myPredFunc}, \code{predict}, or \code{impute}.}
}

\details{
  The input maps are assumed to be Asciigrid maps with 6-line headers
  containing the following tags: \code{NCOLS, NROWS, XLLCORNER, YLLCORNER,
  CELLSIZE} and \code{NODATA_VALUE} (case insensitive). The headers should be
  identical for all input maps, a warning is issued if they are not. 
  It is critical that \code{NODATA_VALUE} is the same on all input maps.

  The function builds data frames from the input maps one row at a time and
  builds predictions using those data frames as \emph{newdata}. Each row of the
  input maps is processed in sequence so that the entire maps are not stored in
  memory. The function works by opening all the input and reads one line (row)
  at a time from each. The output file(s) are created one line at time as the
  input maps are processed.

  Use \code{AsciiGridImpute} for objects builts with \code{\link{yai}},
  otherwise use \code{AsciiGridPredict}. When \code{AsciiGridPredict} is
  used, the following rules apply. First, when \code{myPredFunc} is not
  null it is called with the arguments \code{object, newdata, \dots} where the
  new data is the data frame built from the input maps, otherwise the
  generic \code{\link{predict}} function is called with these same arguments.
  When \code{object} and \code{myPredFunc} are both NULL a copy
  \code{newdata} used as the prediction. This is useful when \code{lat, lon, rows,}
  or \code{cols} are used in to subset the maps.

  The \code{NODATA_VALUE} is output for every \code{NODATA_VALUE} found on any
  grid cell on any one of the input maps (the predict function is not called for
  these grid cells). \code{NODATA_VALUE} is also output for any grid cell where
  the predict function returns an \code{NA}. 
  
  If factors are used as X-variables in
  \code{object}, the levels found the map data are checked against those used in
  building the \code{object}. If new levels are found, the corresponding output
  map grid point is set to \code{NODATA_VALUE}; the predict function is not called
  for these cells as most predict functions will fail in these circumstances.
  Checking on factors depends on \code{object} containing a meaningful member
  named \code{xlevels}, as done for objects produced by \code{\link[stats]{lm}}.

  Asciigrid maps do not contain character data, only numbers. The numbers in the
  maps are matched the \code{xlevels} by subscript (the first entry in a level corresponds
  to the numeric value 1 in the Asciigrid maps, the second to the number 2 and so
  on). Care must be taken by the user to insure that the coding scheme used in
  building the maps is identical to that used in building the \code{object}. See Value for
  information on how you can check the matching of these codes.
}


\seealso{
\code{\link{yai}}, \code{\link{impute}}, and \code{\link{newtargets}}
}

\value{
An \code{\link[base]{invisible}} list containing the following named elements:

  \item{unexpectedNAs}{A data frame listing the map row numbers and the number
     of \code{NA} values generated by the predict function for each row. If none
     are generated for a row the row is not reported, if none are generated for any rows,
     the data frame is NULL.}
  \item{illegalLevels}{A data frame listing levels found in the maps that
     were not found in the \code{xlevels} for the \code{object}. The row names
     are the illegal levels, the column names are the variable names, and the
     values are the number of grid cells where the illegal levels were found.}
  \item{outputLegend}{A data frame showing the relationship between levels in
     the output maps and those found in \code{object}. The row names are
     level index values, the column names are variable names, and the values
     are the levels. NULL if no factors are output.}
  \item{inputLegend}{A data frame showing the relationship between levels found in
     the input maps and those found in \code{object}. The row names are
     level index values (this function assumes they correspond to numeric values
     on the maps), the column names are variable names, and the values
     are the levels. NULL if no factors are input. This information is consistent with
     that in \code{xlevels}.}
}

\examples{

## These commands write new files to your working directory

# Use the iris data
data(iris)

# Section 1: Imagine that the iris are planted in a planting bed.
# The following set of commands create Asciigrid map
# files for four attributes to illustrate the planting layout.

# Change species from a character factor to numeric (the sp classes
# can not handle character data).

sLen <- matrix(iris[,1],10,15)
sWid <- matrix(iris[,2],10,15)
pLen <- matrix(iris[,3],10,15)
pWid <- matrix(iris[,4],10,15)
spcd <- matrix(as.numeric(iris[,5]),10,15)

# Create and change to a temp directory. You can delete these steps
# if you wish to keep the files in your working directory.
curdir <- getwd()
setwd(tempdir())
cat ("Using working dir",getwd(),"\n")

# Make maps of each variable.
header = c("NCOLS 15","NROWS 10","XLLCORNER 1","YLLCORNER 1",
           "CELLSIZE 1","NODATA_VALUE -9999")
cat(file="slen.txt",header,sep="\n")
cat(file="swid.txt",header,sep="\n")
cat(file="plen.txt",header,sep="\n")
cat(file="pwid.txt",header,sep="\n")
cat(file="spcd.txt",header,sep="\n")


write.table(sLen,file="slen.txt",append=TRUE,col.names=FALSE,
            row.names=FALSE)
write.table(sWid,file="swid.txt",append=TRUE,col.names=FALSE,
            row.names=FALSE)
write.table(pLen,file="plen.txt",append=TRUE,col.names=FALSE,
            row.names=FALSE)
write.table(pWid,file="pwid.txt",append=TRUE,col.names=FALSE,
            row.names=FALSE)
write.table(spcd,file="spcd.txt",append=TRUE,col.names=FALSE,
            row.names=FALSE)

# Section 2: Create functions to predict species

# set the random number seed so that example results are consistant
# normally, leave out this command
set.seed(12345)

# sample the data
refs <- sample(rownames(iris),50)
y <- data.frame(Species=iris[refs,5],row.names=rownames(iris[refs,]))

# build a yai imputation for the reference data.
rfNN <- yai(x=iris[refs,1:4],y=y,method="randomForest")

# make lists of input and output map files.

xfiles <- list(Sepal.Length="slen.txt",Sepal.Width="swid.txt",
               Petal.Length="plen.txt",Petal.Width="pwid.txt")
outfiles1 <- list(distance="dist.txt",Species="spOutrfNN.txt",
                  useid="useindx.txt")

# map the imputation-based predictions for the input maps
AsciiGridImpute(rfNN,xfiles,outfiles1,ancillaryData=iris)
# read the asciigrids and get them ready to plot
spOrig <- t(as.matrix(read.table("spcd.txt",skip=6)))
sprfNN <- t(as.matrix(read.table("spOutrfNN.txt",skip=6)))
dist <- t(as.matrix(read.table("dist.txt",skip=6)))

# demonstrate the use of useid:
spViaUse <- read.table("useindx.txt",skip=6)
for (col in colnames(spViaUse)) spViaUse[,col]=as.character(y$Species[spViaUse[,col]])

# demonstrate how to use factors:
spViaLevels  <- read.table("spOutrfNN.txt",skip=6)
for (col in colnames(spViaLevels)) spViaLevels[,col]=levels(y$Species)[spViaLevels[,col]]

identical(spViaLevels,spViaUse)

if (require(randomForest))
{
  # build a randomForest predictor
  rf <- randomForest(x=iris[refs,1:4],y=iris[refs,5])
  AsciiGridPredict(rf,xfiles,list(predict="spOutrf.txt"))
  sprf <- t(as.matrix(read.table("spOutrf.txt",skip=6)))
} else sprf <- NULL

# reset the directory to that where the example was started.
setwd(curdir)

par(mfcol=c(2,2),mar=c(1,1,2,1))
image(spOrig,main="Original",col=c("red","green","blue"),
      axes=FALSE,useRaster=TRUE)
image(sprfNN,main="Using Impute",col=c("red","green","blue"),
      axes=FALSE,useRaster=TRUE)
if (!is.null(sprf))
  image(sprf,main="Using Predict",col=c("red","green","blue"),
      axes=FALSE,useRaster=TRUE)
image(dist,main="Neighbor Distances",col=terrain.colors(15),
      axes=FALSE,useRaster=TRUE)

}


\author{
  Nicholas L. Crookston \email{ncrookston.fs@gmail.com} 
}

\keyword{spatial}
\keyword{utilities}
