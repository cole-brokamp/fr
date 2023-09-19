
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

### Frictionless Field

Create a frictionless field (i.e., `fr_field` object) by converting an R
vector and specifying named [field
descriptors](https://specs.frictionlessdata.io/table-schema/#field-descriptors):

``` r
uid <-
  replicate(6, paste0(sample(c(letters, 0:9), 8, TRUE), collapse = "")) |>
  as_fr_field(name = "uid",
              title = "Unique Identifier",
              description = "Each uid is composed of 8 random alphanumeric characters.")
```

Printing works as usual except that `fr_field` objects prepend extra
lines for the Frictionless attributes:

``` r
uid
#> name: uid
#> type: string
#> title: Unique Identifier
#> description: Each uid is composed of 8 random alphanumeric characters.
#> [1] "dzwnuts4" "gu1fcw1w" "ex6z10yx" "43lt1nec" "x1a7d2on" "i53fvop3"
```

Extract the descriptors as a list using `fr_desc`:

``` r
fr_desc(uid)
#> $name
#> [1] "uid"
#> 
#> $type
#> [1] "string"
#> 
#> $title
#> [1] "Unique Identifier"
#> 
#> $description
#> [1] "Each uid is composed of 8 random alphanumeric characters."
```

`fr_field` objects can be used anywhere that the underlying vector in
`@value` can be used. Because `uid`’s Frictionless `type` is `string`,
the underlying vector in this case is a character vector.

``` r
grepl("[[:alnum:]]", uid)
#> [1] TRUE TRUE TRUE TRUE TRUE TRUE
paste(uid, collapse = "-")
#> [1] "dzwnuts4-gu1fcw1w-ex6z10yx-43lt1nec-x1a7d2on-i53fvop3"
```

Explicitly drop the Frictionless attributes and extract just the
underlying vector that contains the data vector with `as.vector()`:

``` r
as.vector(uid)
#> [1] "dzwnuts4" "gu1fcw1w" "ex6z10yx" "43lt1nec" "x1a7d2on" "i53fvop3"
```

### Frictionless Tabular-Data-Resource

Convert a data frame into a frictionless tabular-data-resource (i.e.,
`fr_tdr` object) with `as_fr_tdr()`. An `fr_tdr` object is essentially a
list of `fr_field`s with table-specific metadata descriptors.

``` r
d_fr <-
  mtcars |>
  as_fr_tdr(name = "mtcars", description = "The mtcars dataset included with R")

d_fr
#> <fr_tdr>
#>  @ value      :List of 11
#>  .. $ mpg : <fr_field>
#>  ..  ..@ value      : num [1:32] 21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
#>  ..  ..@ name       : chr "mpg"
#>  ..  ..@ type       : chr "numeric"
#>  ..  ..@ title      : chr(0) 
#>  ..  ..@ description: chr(0) 
#>  ..  ..@ constraints: list()
#>  .. $ cyl : <fr_field>
#>  ..  ..@ value      : num [1:32] 6 6 4 6 8 6 8 4 4 6 ...
#>  ..  ..@ name       : chr "cyl"
#>  ..  ..@ type       : chr "numeric"
#>  ..  ..@ title      : chr(0) 
#>  ..  ..@ description: chr(0) 
#>  ..  ..@ constraints: list()
#>  .. $ disp: <fr_field>
#>  ..  ..@ value      : num [1:32] 160 160 108 258 360 ...
#>  ..  ..@ name       : chr "disp"
#>  ..  ..@ type       : chr "numeric"
#>  ..  ..@ title      : chr(0) 
#>  ..  ..@ description: chr(0) 
#>  ..  ..@ constraints: list()
#>  .. $ hp  : <fr_field>
#>  ..  ..@ value      : num [1:32] 110 110 93 110 175 105 245 62 95 123 ...
#>  ..  ..@ name       : chr "hp"
#>  ..  ..@ type       : chr "numeric"
#>  ..  ..@ title      : chr(0) 
#>  ..  ..@ description: chr(0) 
#>  ..  ..@ constraints: list()
#>  .. $ drat: <fr_field>
#>  ..  ..@ value      : num [1:32] 3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
#>  ..  ..@ name       : chr "drat"
#>  ..  ..@ type       : chr "numeric"
#>  ..  ..@ title      : chr(0) 
#>  ..  ..@ description: chr(0) 
#>  ..  ..@ constraints: list()
#>  .. $ wt  : <fr_field>
#>  ..  ..@ value      : num [1:32] 2.62 2.88 2.32 3.21 3.44 ...
#>  ..  ..@ name       : chr "wt"
#>  ..  ..@ type       : chr "numeric"
#>  ..  ..@ title      : chr(0) 
#>  ..  ..@ description: chr(0) 
#>  ..  ..@ constraints: list()
#>  .. $ qsec: <fr_field>
#>  ..  ..@ value      : num [1:32] 16.5 17 18.6 19.4 17 ...
#>  ..  ..@ name       : chr "qsec"
#>  ..  ..@ type       : chr "numeric"
#>  ..  ..@ title      : chr(0) 
#>  ..  ..@ description: chr(0) 
#>  ..  ..@ constraints: list()
#>  .. $ vs  : <fr_field>
#>  ..  ..@ value      : num [1:32] 0 0 1 1 0 1 0 1 1 1 ...
#>  ..  ..@ name       : chr "vs"
#>  ..  ..@ type       : chr "numeric"
#>  ..  ..@ title      : chr(0) 
#>  ..  ..@ description: chr(0) 
#>  ..  ..@ constraints: list()
#>  .. $ am  : <fr_field>
#>  ..  ..@ value      : num [1:32] 1 1 1 0 0 0 0 0 0 0 ...
#>  ..  ..@ name       : chr "am"
#>  ..  ..@ type       : chr "numeric"
#>  ..  ..@ title      : chr(0) 
#>  ..  ..@ description: chr(0) 
#>  ..  ..@ constraints: list()
#>  .. $ gear: <fr_field>
#>  ..  ..@ value      : num [1:32] 4 4 4 3 3 3 3 4 4 4 ...
#>  ..  ..@ name       : chr "gear"
#>  ..  ..@ type       : chr "numeric"
#>  ..  ..@ title      : chr(0) 
#>  ..  ..@ description: chr(0) 
#>  ..  ..@ constraints: list()
#>  .. $ carb: <fr_field>
#>  ..  ..@ value      : num [1:32] 4 4 1 1 2 1 4 2 2 4 ...
#>  ..  ..@ name       : chr "carb"
#>  ..  ..@ type       : chr "numeric"
#>  ..  ..@ title      : chr(0) 
#>  ..  ..@ description: chr(0) 
#>  ..  ..@ constraints: list()
#>  @ name       : chr "mtcars"
#>  @ path       : chr(0) 
#>  @ version    : chr(0) 
#>  @ title      : chr(0) 
#>  @ homepage   : chr(0) 
#>  @ description: chr "The mtcars dataset included with R"
```

TODO After conversion, set field-level descriptors: Make `$` accessor
work on `fr_tdr` as it does on tibble or data frame?

``` r
d_fr@value$mpg@title <- "Miles Per Gallon"
```
