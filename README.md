
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fr

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/fr)](https://CRAN.R-project.org/package=fr)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/cole-brokamp/fr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/cole-brokamp/fr/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

`fr` provides `fr_field` and `fr_tdr` objects for implementing
[frictionless](https://specs.frictionlessdata.io)
[tabular-data-resource](https://specs.frictionlessdata.io/tabular-data-resource)
standards in R.

## Installation

You can install the development version of codec from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("cole-brokamp/fr")
```

## Usage

``` r
library(fr)
```

Create a frictionless field (`fr_field` object):

``` r
uid <-
  replicate(34, paste0(sample(c(letters, 0:9), 8, TRUE), collapse = "")) |>
  as_fr_field(
    name = "uid",
    title = "Unique Identifier",
    description = "Each identifier is composed of 8 alphanumeric characters."
  )

uid
#> <fr::fr_field>
#>  @ value      : chr [1:34] "j60eip5e" "wmblidse" "5xm18b5x" "x9y4i2j8" "a6cvdtik" ...
#>  @ name       : chr "uid"
#>  @ type       : chr "string"
#>  @ title      : chr "Unique Identifier"
#>  @ description: chr "Each identifier is composed of 8 alphanumeric characters."
#>  @ constraints: list()
```
