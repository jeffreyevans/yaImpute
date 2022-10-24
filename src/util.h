#include <iostream>
#include <iomanip>
#include <string>
#include <vector>
#include <map>
using namespace std;

#include <R.h>
#include <Rmath.h>
#include <Rinternals.h>


void showMatrix(double *x, int xnrow, int xncol);
SEXP getListElement (SEXP list, const char *str);
