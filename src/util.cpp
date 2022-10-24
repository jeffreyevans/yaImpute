#include <iostream>
#include <iomanip>
#include <string>
#include <vector>
#include <map>
using namespace std;

#include <R.h>
#include <Rmath.h>
#include <Rinternals.h>
#include "util.h"


void showMatrix(double *x, int xnrow, int xncol){
//R does not allow:  int i,j;
//R does not allow:  for(i = 0; i < xnrow; i++){
//R does not allow:    for(j = 0; j < xncol; j++){
//R does not allow:      cout << x[j*xnrow+i] << "\t";
//R does not allow:    }
//R does not allow:    cout << endl;
//R does not allow:  }      
}

SEXP getListElement (SEXP list, const char *str)
{
  SEXP elmt = R_NilValue, names = getAttrib(list, R_NamesSymbol);
  int i;
  
  for (i = 0; i < length(list); i++)
    if(strcmp(CHAR(STRING_ELT(names, i)), str) == 0) {
      elmt = VECTOR_ELT(list, i);
      break;
    }
  
  if(elmt == R_NilValue){
    Rprintf("\nlist element %s not found\n", str);
  }
  return elmt;
}
