
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

Convert R vectors to a frictionless field (i.e., `fr_field` object):

``` r
uid <-
  replicate(34, paste0(sample(c(letters, 0:9), 8, TRUE), collapse = "")) |>
  as_fr_field(name = "uid",
              title = "Unique Identifier",
              description = "Each uid is composed of 8 random alphanumeric characters")
```

TODO Printing and other operations proceed as if `uid` were still a
character:

``` r
grep("[0-9]", uid)
```

To drop the Frictionless attributes and coerce a `fr_field` object back
to a vector, use `as_vector()`:

``` r
as_vector(uid)
#>  [1] "qkb5c78c" "ae1m7yxm" "wdgjkgk8" "lq6frw6o" "hgc6qmxc" "zcuncu2o"
#>  [7] "s4grxltv" "0sas8ze3" "p1ab1ayk" "b558hrb8" "wu48ra14" "8ndrszev"
#> [13] "hjsssh8b" "1d9ggaol" "zdej36tp" "n9botcxe" "85mp6lal" "oum1n6ke"
#> [19] "ltizvnrs" "lw0k4wz7" "86j6qdwp" "6t5pm90o" "trch3b7e" "po4xc3fg"
#> [25] "w8zjjt1k" "e2nh6ky0" "fkuphljx" "0z64n8ah" "itcdu06i" "drhzt7b6"
#> [31] "a3238o1f" "p6rhd8ol" "tmthdxwl" "l2xly8in"
```

Inspect [field
descriptors](https://specs.frictionlessdata.io/table-schema/#field-descriptors)
using `fr_descriptors()`:

``` r
## fr_descriptors(uid)
```
