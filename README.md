
# nsyllable

<!-- badges: start -->

[![CRAN
Version](https://www.r-pkg.org/badges/version/nsyllable)](https://CRAN.R-project.org/package=nsyllable)
[![](https://img.shields.io/badge/devel%20version-0.90-royalblue.svg)](https://github.com/quanteda/nsyllable)
[![Downloads](https://cranlogs.r-pkg.org/badges/nsyllable)](https://CRAN.R-project.org/package=nsyllable)
[![Total
Downloads](https://cranlogs.r-pkg.org/badges/grand-total/nsyllable?color=orange)](https://CRAN.R-project.org/package=nsyllable)
[![R build
status](https://github.com/quanteda/nsyllable/workflows/R-CMD-check/badge.svg)](https://github.com/quanteda/nsyllable/actions)
[![codecov](https://codecov.io/gh/quanteda/nsyllable/branch/master/graph/badge.svg)](https://codecov.io/gh/quanteda/nsyllable)
<!-- badges: end -->

## About

Counts syllables in character vectors for English words, based on the
[Carnegie Mellon University Pronouncing
Dictionary](http://www.speech.cs.cmu.edu/cgi-bin/cmudict). Imputes
syllables as the number of vowel sequences for words not found.

We hope to add more languages soon.

## How to Install

Currently, **nsyllable** is currently only on GitHub. To install:

``` r
# devtools package required to install nsyllable from Github 
devtools::install_github("quanteda/nsyllable") 
```

## Demonstration

``` r
library("nsyllable")

charvec <- c("testing", "Aachen", "supercalifragilisticexpialidocious")
nsyllable(charvec)
## [1]  2  2 13
nsyllable(charvec, use.names = TRUE)
##                            testing                             Aachen 
##                                  2                                  2 
## supercalifragilisticexpialidocious 
##                                 13
```
