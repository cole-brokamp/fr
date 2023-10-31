#' @keywords internal
"_PACKAGE"

# TODO add documentation here about the two classes and their methods

#' @import cli
NULL

.onLoad <- function(...) {
  S7::methods_register()
}

# enable usage of <S7_object>@name in package code
#' @rawNamespace if (getRversion() < "4.3.0") importFrom("S7", "@")
NULL

utils::globalVariables(c("path", "enum", "schema", "fields"))

