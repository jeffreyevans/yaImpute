#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* .Call calls */
extern SEXP annf(SEXP);
extern SEXP rfoneprox(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);

static const R_CallMethodDef CallEntries[] = {
    {"annf",      (DL_FUNC) &annf,      1},
    {"rfoneprox", (DL_FUNC) &rfoneprox, 6},
    {NULL, NULL, 0}
};

void R_init_yaImpute(DllInfo *dll)
{
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
