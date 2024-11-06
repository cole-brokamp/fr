fr_field <- S7::new_class(
  "fr_field",
  package = NULL,
  properties = list(
    name = S7::class_character,
    type = S7::class_character,
    title = S7::class_character,
    description = S7::class_character,
    constraints = S7::class_list
  ),
  validator = function(self) {
    if (length(self@name) != 1) {
      "@name must be length 1"
    } else if (length(self@type) != 1) {
      "@type must be length 1"
    } else if (!(self@type) %in% c("number", "string", "boolean", "date", "integer")) {
      "@type must be one of 'number', 'string', 'boolean', 'date', or 'integer'"
    }
  }
)

#' Coerce `character`, `factor`, `numeric`, `logical`, and `Date`
#' vectors into [`fr_field`][fr::fr-package] objects
#'
#' The supported classes of `R` objects are converted to the corresponding frictionless `type`:
#' | **`R` class**   | **`fr` type**   |
#' |:-----------------|:-------------|
#' | `character()`| `string` |
#' | `factor()` | `string` (with `enum(constraints = levels(x))`) |
#' | `numeric()`, `integer()` | `number` |
#' | `logical()` | `boolean` |
#' | `Date` | `date` |
#' @param x a character, factor, numeric, integer, logical, or Date vector
#' @param ... <[`dynamic-dots`][rlang::dyn-dots]> required (`name`) and optional (`title`, `description`) [field descriptors](https://specs.frictionlessdata.io/table-schema/#field-descriptors))
#' @return a [fr_field][fr::fr-package] object
#' @examples
#' as_fr_field(1:10, "example_integer") # -> frictionless number
#' as_fr_field((1:10) * 0.1, "example_double") # -> frictionless number
#' as_fr_field(letters, "example_character") # -> frictionless string
#' as_fr_field(factor(letters), "example_factor") # -> frictionless string with enum constraints
#' as_fr_field(c(TRUE, FALSE, TRUE), "example_logical") # -> frictionless boolean
#' as_fr_field(as.Date(c("2023-04-23", "2004-12-31")), "example_date") # -> frictionless date
#' @export
as_fr_field <- S7::new_generic("as_fr_field", "x")

S7::method(as_fr_field, S7::class_list) <- function(x) {
  do.call("fr_field", x)
}

S7::method(as_fr_field, S7::class_numeric) <- function(x, name, ...) {
  fr_field(name = name, type = "number", ...)
}

S7::method(as_fr_field, S7::class_character) <- function(x, name, ...) {
  fr_field(name = name, type = "string", ...)
}

S7::method(as_fr_field, S7::class_factor) <- function(x, name, ...) {
  fr_field(name = name, type = "string", ..., constraints = list(enum = levels(x)))
}

S7::method(as_fr_field, S7::class_logical) <- function(x, name, ...) {
  fr_field(name = name, type = "boolean", ...)
}

S7::method(as_fr_field, S7::class_Date) <- function(x, name, ...) {
  fr_field(name = name, type = "date", ...)
}

#' Test if an object is a [`fr_field`][fr::fr-package] object
#' @param x an object to test
#' @return `TRUE` if object is a [fr_field][fr::fr-package] object, `FALSE` otherwise
#' @examples
#' is_fr_field(letters)
#' is_fr_field(as_fr_field(letters, "letters"))
#' @export
is_fr_field <- function(x) {
  S7::S7_inherits(x, fr_field)
}


S7::method(print, fr_field) <- function(x, ...) {
  cli::cli_div(theme = list(
    span.fr_desc = list(color = "darkgrey"),
    "span.fr_desc" = list(before = "- "),
    "span.fr_desc" = list(after = "")))
  cli::cli_text("{.field {x@name}}")
  cli::cli_text("{.fr_desc type: {x@type}}")
  if (length(x@title) > 0) cli::cli_text("{.fr_desc title: {x@title}}")
  if (length(x@description) > 0) cli::cli_text("{.fr_desc description: {x@description}}")
  if (length(x@constraints) > 0) cli::cli_text("{.fr_desc constraints: enum = {x@constraints$enum}}")
}
