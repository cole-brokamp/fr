# fr

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/fr)](https://CRAN.R-project.org/package=fr)
[![R-CMD-check](https://github.com/cole-brokamp/fr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/cole-brokamp/fr/actions/workflows/R-CMD-check.yaml)
[![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
<!-- badges: end -->

`fr` provides `fr_tdr`, `fr_schema`, and `fr_field` objects for implementing
[frictionless](https://specs.frictionlessdata.io/)
[tabular-data-resource](https://specs.frictionlessdata.io/tabular-data-resource/)
standards in R.

## Installation

Install {fr} from CRAN:

```r
install.packages("fr")
```

You can install the development version of {fr} from
[GitHub](https://github.com/) with:

```r
# install.packages("pak")
pak::pak("cole-brokamp/fr")
```

## Usage

- See `vignette("read_fr_tdr")` to read a Frictionless Tabular Data Resource from disk or the web, access metadata, and manipulate it as a data.frame
- See `vignette("creating_a_tabular-data-resource")` to create a Frictionless Tabular Data Resource by converting a data.frame or tibble, adding metadata, and writing to disk

## Frictionless Standards

Developed by the [Open Knowledge Foundation](https://okfn.org/), the [frictionless](https://frictionlessdata.io/) [standards](https://specs.frictionlessdata.io/) are a set of patterns for describing data, including datasets (Data Package), files (Data Resource), and tables (Table Schema). A Data Package is a simple container format used to describe and package a collection of data and metadata, including schemas. These metadata are contained in a specific file (separate from the data file), usually written in JSON or YAML, that describes something specific to each Frictionless Standard:

- [Table Schema](https://specs.frictionlessdata.io/table-schema/): describes a tabular file by providing its dimension, field data types, relations, and constraints
- [Data Resource](https://specs.frictionlessdata.io/data-resource/): describes an *exact* tabular file providing a path to the file and details like title, description, and others
- [Tabular Data Resource](https://specs.frictionlessdata.io/tabular-data-resource/) = Data Resource + Table Schema
- [CSV dialect](https://specs.frictionlessdata.io/csv-dialect/): describes the formatting specific to the various dialects of CSV files
- [Data Package](https://specs.frictionlessdata.io/data-package/) & [Tabular Data Package](https://specs.frictionlessdata.io/tabular-data-package/): describes a *collection* of tabular files providing data resource information from above along with general information about the package itself, a license, authors, and other metadata
