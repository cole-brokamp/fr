
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
set.seed(1)
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
#> [1] "da7wnr6u" "ujgiouy7" "yo6t8fjt" "1twfyffx" "5nbrvnaf" "wfkq9myy"
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
#> [1] "da7wnr6u-ujgiouy7-yo6t8fjt-1twfyffx-5nbrvnaf-wfkq9myy"
```

Explicitly drop the Frictionless attributes and extract just the
underlying vector that contains the data vector with `as.vector()`:

``` r
as.vector(uid)
#> [1] "da7wnr6u" "ujgiouy7" "yo6t8fjt" "1twfyffx" "5nbrvnaf" "wfkq9myy"
```

### Frictionless Tabular-Data-Resource

Convert a data frame into a frictionless tabular-data-resource (i.e.,
`fr_tdr` object) with `as_fr_tdr()`. An `fr_tdr` object is essentially a
list of `fr_field`s with table-specific metadata descriptors.

``` r
d_fr <-
  mtcars |>
  as_fr_tdr(name = "mtcars", description = "The mtcars dataset included with R")
#> Warning: ! row.names will be dropped
#> ℹ convert row.names to a new column with `tibble::rowid_to_column`
#> ℹ remove row.names with `tibble::remove_rownames`

d_fr
#> name: mtcars
#> path:
#> version:
#> title:
#> homepage: <>
#> description: The mtcars dataset included with R
#> # A tibble: 32 × 11
#>      mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
#>    <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1  21       6  160    110  3.9   2.62  16.5     0     1     4     4
#>  2  21       6  160    110  3.9   2.88  17.0     0     1     4     4
#>  3  22.8     4  108     93  3.85  2.32  18.6     1     1     4     1
#>  4  21.4     6  258    110  3.08  3.22  19.4     1     0     3     1
#>  5  18.7     8  360    175  3.15  3.44  17.0     0     0     3     2
#>  6  18.1     6  225    105  2.76  3.46  20.2     1     0     3     1
#>  7  14.3     8  360    245  3.21  3.57  15.8     0     0     3     4
#>  8  24.4     4  147.    62  3.69  3.19  20       1     0     4     2
#>  9  22.8     4  141.    95  3.92  3.15  22.9     1     0     4     2
#> 10  19.2     6  168.   123  3.92  3.44  18.3     1     0     4     4
#> # ℹ 22 more rows
```

TODO After conversion, set field-level descriptors: Make `$` accessor
work on `fr_tdr` as it does on tibble or data frame?

``` r
d_fr@value$mpg@title <- "Miles Per Gallon"
```
