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

## Frictionless Standards

Developed by the [Open Knowledge Foundation](https://okfn.org/), the [frictionless](https://frictionlessdata.io/) [standards](https://specs.frictionlessdata.io/) are a set of patterns for describing data, including datasets (Data Package), files (Data Resource), and tables (Table Schema). A Data Package is a simple container format used to describe and package a collection of data and metadata, including schemas. These metadata are contained in a specific file (separate from the data file), usually written in JSON or YAML, that describes something specific to each Frictionless Standard:

- [Table Schema](https://specs.frictionlessdata.io/table-schema/): describes a tabular file by providing its dimension, field data types, relations, and constraints
- [Data Resource](https://specs.frictionlessdata.io/data-resource/): describes an *exact* tabular file providing a path to the file and details like title, description, and others
- [Tabular Data Resource](https://specs.frictionlessdata.io/tabular-data-resource/) = Data Resource + Table Schema
- [CSV dialect](https://specs.frictionlessdata.io/csv-dialect/): describes the formatting specific to the various dialects of CSV files
- [Data Package](https://specs.frictionlessdata.io/data-package/) & [Tabular Data Package](https://specs.frictionlessdata.io/tabular-data-package/): describes a *collection* of tabular files providing data resource information from above along with general information about the package itself, a license, authors, and other metadata
