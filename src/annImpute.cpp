#include <iostream>
#include <iomanip>
#include <string>
#include <fstream>
#include <ctime>
using namespace std;

#include <R.h>
#include <Rmath.h>
#include <Rinternals.h>
#include "ANN/ANN.h"
#include "util.h"

extern "C" {

  SEXP annf(SEXP args)
  {
    SEXP ref, refDims, target, tarDims, knnIndxDistMtrx;
    int nProtect = 0;
    int i,j,k;
    int report = 100;
    int rreport = 500;
    int cnt = 0;
    int rcnt = 0;
    double searchTime;
    time_t start, end;
    int refDim1, refDim2, tarDim1, tarDim2;
    bool verbose = INTEGER(getListElement(args, "verbose"))[0];
    string tree = CHAR(STRING_ELT(getListElement(args, "tree.type"), 0));
    bool pri = INTEGER(getListElement(args, "priority"))[0];
    int bucketSize = INTEGER(getListElement(args, "bucket.size"))[0];
    ANNsplitRule splitRule = (ANNsplitRule) INTEGER(getListElement(args, "split.rule"))[0];
    ANNshrinkRule shrinkRule = (ANNshrinkRule) INTEGER(getListElement(args, "shrink.rule"))[0];

    /**************************
       ref and tree structure
    ***************************/
    ANNpointArray dataPts;
    ANNkd_tree*	kdTree = NULL;    
    ANNbd_tree* bdTree = NULL;
    ANNbruteForce* brute = NULL;
    bool kd = false;
    bool bd = false;

    //ref matrix
    PROTECT(ref = getListElement(args, "ref"));  nProtect++;
    PROTECT(refDims = getAttrib(ref, R_DimSymbol)); nProtect++;      
    refDim1 = INTEGER(refDims)[0];
    refDim2 = INTEGER(refDims)[1];
    dataPts = annAllocPts(refDim1, refDim2);

    //read in pts 
    for(i = 0; i < refDim1; i++){
      for(j = 0; j < refDim2; j++){
	(dataPts[i])[j] = REAL(ref)[j*refDim1+i];
      }
    }

    if(tree == "kd"){
      kdTree = new ANNkd_tree(dataPts, refDim1, refDim2, bucketSize, splitRule);
      kd = true;
    }
    else if(tree == "bd"){
      bdTree = new ANNbd_tree(dataPts, refDim1, refDim2, bucketSize, splitRule, shrinkRule);
      bd = true;
    }
    else{
      brute = new ANNbruteForce(dataPts, refDim1, refDim2);
    }

    /**************************
         target and search
    ***************************/
    ANNpoint queryPt;
    queryPt = annAllocPt(refDim2);
    k = INTEGER(getListElement(args, "k"))[0];
    ANNidxArray nnIdx = new ANNidx[k];
    ANNdistArray dists = new ANNdist[k];
 
    double eps = REAL(getListElement(args, "eps"))[0];

    //target matrix
    PROTECT(target = getListElement(args, "target"));  nProtect++;
    PROTECT(tarDims = getAttrib(target, R_DimSymbol)); nProtect++;
    tarDim1 = INTEGER(tarDims)[0];
    tarDim2 = INTEGER(tarDims)[1];
    
    //target return matrix nnIdx and dists
    PROTECT(knnIndxDistMtrx = allocMatrix(REALSXP, tarDim1, k+k)); nProtect++;

    if(verbose){
      Rprintf("Target points completed: ");
      Rprintf("\n\t\t");
    }
    
    start = clock();

    for(i = 0; i < tarDim1; i++){

      //mk query pt
      for(j = 0; j < tarDim2; j++){
	queryPt[j] = REAL(target)[j*tarDim1+i];
      }
      
      if(kd){
	if(pri)
	  kdTree->annkPriSearch(queryPt, k, nnIdx, dists, eps);
	else
	  kdTree->annkSearch(queryPt, k, nnIdx, dists, eps);	  
      }else if(bd){
	if(pri)
	  bdTree->annkPriSearch(queryPt, k,nnIdx, dists, eps);
	else
	  bdTree->annkSearch(queryPt, k, nnIdx, dists, eps);
      }else{
	brute->annkSearch(queryPt, k, nnIdx, dists);
      }

      //write nnIdx and dist to return mtrx
      for(j = 0; j < k; j++){
	REAL(knnIndxDistMtrx)[j*tarDim1+i] = ++nnIdx[j];//plus one for R indexing
	REAL(knnIndxDistMtrx)[(j+k)*tarDim1+i] = dists[j];
      }

      //progress
      if(verbose){
	if(report == cnt){
	  Rprintf("%i...", i);
          #ifdef Win32
	  R_FlushConsole();
          #endif
	  
	  R_CheckUserInterrupt();
	  cnt = 0;
	}
	if(rreport == rcnt){
	  Rprintf("\n\t\t");
          #ifdef Win32
	  R_FlushConsole();
          #endif
	  
	  R_CheckUserInterrupt();	
	  rcnt = 0;
	}
	
	cnt++;
	rcnt++;
      }
    }
      if(verbose)
	Rprintf("\n");

    end = clock();
    searchTime = (double)(end-start)/CLOCKS_PER_SEC;

    /**************************
              plots
    ***************************/
  //   if(kd || bd){
//       ofstream ofile;
//       ofile.open("tree.dmp", ios::out);
//       if (!ofile) {
// 	cout << "Cannot open output file" << endl;
// 	exit(1);
//       }
      
//       if(kd)
// 	kdTree->Dump(ANNtrue, ofile);
//       else
// 	bdTree->Dump(ANNtrue, ofile);
      
//       ofile.close();
//     }

    /**************************
           return obj.
    ***************************/
    SEXP result, resultNames, time;
    int nResultListObjs = 2;
    PROTECT(time = allocVector(REALSXP, 1)); nProtect++;
    REAL(time)[0] = searchTime;

    PROTECT(result = allocVector(VECSXP, nResultListObjs)); nProtect++;
    PROTECT(resultNames = allocVector(STRSXP, nResultListObjs)); nProtect++;

    SET_VECTOR_ELT(result, 0, knnIndxDistMtrx);
    SET_VECTOR_ELT(result, 1, time);
    
    SET_STRING_ELT(resultNames, 0, mkChar("knnIndexDist"));
    SET_STRING_ELT(resultNames, 1, mkChar("searchTime"));
    namesgets(result, resultNames);
    


    /**************************
            clean-up
    ***************************/
    delete kdTree;
    delete bdTree;
    delete brute;
    delete [] nnIdx;
    delete [] dists;
    annDeallocPts(dataPts);
    annClose();
    UNPROTECT(nProtect);
 
    return(result);
  }

}
