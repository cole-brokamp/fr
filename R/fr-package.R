#' @keywords internal
"_PACKAGE"

# TODO add documentation here about the two classes and their methods

NULL

.onLoad <- function(...) {
  S7::methods_register()
}
