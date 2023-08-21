# fr

<!-- badges: start -->
[![CRAN status](https://www.r-pkg.org/badges/version/fr)](https://CRAN.R-project.org/package=fr)
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/cole-brokamp/fr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/cole-brokamp/fr/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

`fr` is a package for implementing [frictionless](https://specs.frictionlessdata.io) [table schema](https://specs.frictionlessdata.io/table-schema) standards in R

## Installation

You can install the development version of codec from [GitHub](https://github.com/) with:

    # install.packages("pak")
    pak::pak("geomarker-io/codec")
	
## Usage

Use `fr_field()` to create a frictionless field object in R by automatically selecting the appropriate Frictionless [`type`, `format`](https://specs.frictionlessdata.io/table-schema/#types-and-formats), and [`constraint`](https://specs.frictionlessdata.io/table-schema/#constraints) metadata descriptors for a specific class of R objects:

| `R` class   | `fr` type   |
|:--------------|:----------------|
| `character()`, `factor()` | `string`* |
| `numeric()`, `integer()` | `number` |
| `logical()` | `boolean` |
| `Date` | `date` |

*If a `factor()`, the `enum` `constraint` is set to the levels of the factor in R.

{{{ insert example here using `fr` to "curate" a dataset in R }}}

Automatically defining these metadata descriptors based on the `class()` and `attributes()` of an object in R is powerful, but it is *strict* because it only supports these common R classes. Using R to curate data to disk as a frictionless tabular data resource utilizes Frictionless defaults wherever possible, minimizing the need for manual curation of metadata already captured using R.

In contrast, `fr_field_string()`, `fr_field_number()`, `fr_field_boolean()`, and `fr_field_date()` are *lenient* in that they accept infinitely more classes of vectors (through coercion), but they require more fine grained specification of frictionless `type`, `format`, and `constraints`.  These each also come with parsing of the input character strings for the specific type; e.g., parsing `$11,000` as a frictionless number (`11000`) or `jun-2016` as a frictionless date (`2016-01-06`). This allows for flexibility in reading messy, real-world Frictionless tabular data resources using R.

{{{ insert example here using `fr` to read a messy frictionless dataset in R }}}

### Alternatives

R6 object-oriented alternative package: https://github.com/frictionlessdata/tableschema-r; this is much simpler approach using {vctrs}
