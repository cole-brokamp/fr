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

You can install the development version of {fr} from
[GitHub](https://github.com/) with:

```r
# install.packages("pak")
pak::pak("cole-brokamp/fr")
```

## Usage

```r
library(fr)
```

Using these functions to set attributes in R means we can do so reproducibly and changes to the metadata are tracked alongside the R script that creates the data. This prevents a disconnect between data and metadata, but also allows for computing on the metadata to use it to create richer documentation.
