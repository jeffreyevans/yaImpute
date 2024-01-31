# lleather/yaImpute - a fork

I've updated the yai.R script to retain the OOB observations in random forest models. 

# yaImpute (1.0-32) <img src="man/figures/logo.png" align="right" height="132" />

yaImpute (Crookston & Finley 2007) Performs nearest neighbor-based imputation using one or more 
alternative approaches to processing multivariate data. These include methods based on canonical 
correlation: analysis, canonical correspondence analysis, and a multivariate adaptation 
of the random forest classification and regression techniques of Leo Breiman and Adele 
Cutler. Additional methods are also offered. The package includes functions for 
comparing the results from running alternative techniques, detecting imputation targets 
that are notably distant from reference observations, detecting and correcting 
for bias, bootstrapping and building ensemble imputations, and mapping results.

Crookston NL, Finley AO (2007). "yaImpute: An R Package for kNN Imputation." Journal of Statistical Software, 23(10). 
  ISSN 1548-7660, http://www.jstatsoft.org/v23/i10.  

**Bugs**: Users are encouraged to report bugs here. Go to [issues](https://github.com/jeffreyevans/yaImpute/issues) in the menu above, and press new issue to start a new bug report, documentation correction or feature request. You can direct questions to <jeffrey_evans@tnc.org>.

**To install `yaImpute` in R use install.packages() to download current stable release from CRAN** 

**or, for the development version, run the following (requires the remotes package):**
`remotes::install_github("jeffreyevans/yaImpute")`
