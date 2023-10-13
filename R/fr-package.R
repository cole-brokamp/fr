#' @keywords internal
"_PACKAGE"

# TODO add documentation here about the two classes and their methods

#' @import cli
NULL

.onLoad <- function(...) {
  S7::methods_register()
}

utils::globalVariables(c("path", "enum", "schema", "fields"))

