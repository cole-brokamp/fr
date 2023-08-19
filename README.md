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

Use `fr_field()` to create a frictionless field object in R. The R classes below are automatically assigned the corresponding frictionless [type](https://specs.frictionlessdata.io/table-schema/#types-and-formats)

| **R class**        | **fr type** | **`fr_*()`**   |
|:------------------:|:-----------:|:--------------:|
| character, factor^ | string      | `fr_string()`  |
| numeric, integer   | number      | `fr_number()`  |
| logical            | boolean     | `fr_boolean()` |
| Date               | date        | `fr_date()`    |

Use `fr_parse_*()` to parse data or coerce vectors of classes not directly supported in `fr_field`

#### parking lot

For tabular-data-resource:

- Required: name, path, profile, schema (with a set of descriptors for each field)
- Optional: version, title, homepage, description

How to make a markdown/html button for a tabular-data-resource to list the version number and have a link for download?  *or* to display an html popup or link to the metadata and schema???

R function to do a rendered html file of metadata?? (Just use json and use browser to display the raw json?)

Implement a subset of the tabular data resource functionality. Exclude foregin and primary keys, which allows for the removal of `fields` by collapsing the structure up one level into `schema`. Schema is basically a special type of descriptor that can have many descriptors in it for each data field. This makes it less confusing with the "fields" terminology used in vctrs. Consider this as `schema`.

### Alternatives

R6 object-oriented alternative package: https://github.com/frictionlessdata/tableschema-r; this is much simpler approach using vctrs
