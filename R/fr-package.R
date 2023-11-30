#' About the fr package
#'
#' @description
#' `fr` provides functions and objects to reproducibly create and track changes to metadata alongside code that creates
#' the data. This prevents a disconnect between data and metadata, but also allows for computing on the metadata
#' to create richer documentation.
#' The `fr` package provides `fr_tdr`, `fr_schema`, and `fr_field` objects to provide a representation of the
#' [Frictionless](https://frictionlessdata.io/)
#' [Tabular Data Resource](https://specs.frictionlessdata.io/tabular-data-resource/) standards in R.
#' 
#' A `fr_tdr`, or frictionless tabular data resource, object encapsulates data and metadata by building on top
#' of the data.frame and has a list of data resource-specific metadata properties (e.g., `name`, `description`).
#' one of which is a `fr_schema` (Frictionless Schema) object. One of these is a `fr_schema` object, which is a list of table-specific metadata properties. One of these is a list of `fr_field` objects, which is a list #' field- (or column-) specific metadata properties (e.g., `name`, `type`, `constraints`)
#'
#' Normal usage will only require using `as_fr_tdr()` to create a `fr_tdr` object based on a data.frame or tibble. 
#' @keywords internal
"_PACKAGE"

#' @import cli
NULL

.onLoad <- function(...) {
  S7::methods_register()
}

# enable usage of <S7_object>@name in package code
#' @rawNamespace if (getRversion() < "4.3.0") importFrom("S7", "@")
NULL

utils::globalVariables(c("name", "path", "enum", "schema", "fields"))

