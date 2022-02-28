
# nsyllable

<!-- badges: start -->

[![CRAN
Version](https://www.r-pkg.org/badges/version/nsyllable)](https://CRAN.R-project.org/package=nsyllable)
[![](https://img.shields.io/badge/devel%20version-1.0.1-royalblue.svg)](https://github.com/quanteda/nsyllable)
[![Downloads](https://cranlogs.r-pkg.org/badges/nsyllable)](https://CRAN.R-project.org/package=nsyllable)
[![Total
Downloads](https://cranlogs.r-pkg.org/badges/grand-total/nsyllable?color=orange)](https://CRAN.R-project.org/package=nsyllable)
[![R build
status](https://github.com/quanteda/nsyllable/workflows/R-CMD-check/badge.svg)](https://github.com/quanteda/nsyllable/actions)
[![codecov](https://codecov.io/gh/quanteda/nsyllable/branch/master/graph/badge.svg)](https://app.codecov.io/gh/quanteda/nsyllable)
<!-- badges: end -->

## About

Counts syllables in character vectors. For English, this looks up
syllables from the [Carnegie Mellon University Pronouncing
Dictionary](https://github.com/cmusphinx/cmudict), or guesses the
syllables as the number of vowel sequences for words not found.
User-supplied syllable word lists are also supported.

We hope to add lookup tables for additional languages in the future.

## How to Install

From CRAN:

``` r
install.packages("nsyllable")
```

From GitHub:

``` r
# remotes package required to install nsyllable from Github 
remotes::install_github("quanteda/nsyllable") 
```

## Usage

`nsyllable()` counts the syllables in each element of a character
vector, and returns the integer vector of the syllable counts. If
`use.names = TRUE`, then the output vector is named. The default (and
currently, only) language implemented is English.

``` r
library("nsyllable")

charvec <- c("testing", "Aachen", "supercalifragilisticexpialidocious")
nsyllable(charvec)
## [1]  2  2 14
nsyllable(charvec, use.names = TRUE)
##                            testing                             Aachen 
##                                  2                                  2 
## supercalifragilisticexpialidocious 
##                                 14
```

User-supplied dictionaries can also be used, and these will override the
`language` argument. Below, “excellent” is still (correctly) counted,
but not because it looked up the results in the English dictionary, but
because it counted the vowel sequences. This gets “noel” wrong, however.

``` r
nsyllable(c("excellent", "noel", "film"), use.names = TRUE)
## excellent      noel      film 
##         3         2         1

# redefine the syllables as it's pronounced in parts of Ireland
mydict <- c("film" = 2L)
# looks up "excellent" and does the vowel count
nsyllable(c("excellent", "noel", "film"), syllable_dictionary = mydict, use.names = TRUE)
## excellent      noel      film 
##         3         1         2
```

To not use the English dictionary and count only vowel sequences, set
`syllable_dictionary` to `NULL`. This will likely to be a good
approximation for many Western languages.

``` r
nsyllable(c("Dies", "ist", "eine", "Demonstration"), syllable_dictionary = NULL,
          use.names = TRUE)
##          Dies           ist          eine Demonstration 
##             1             1             2             4
```
