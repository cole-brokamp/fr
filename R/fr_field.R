fr_field <- S7::new_class(
  "fr_field",
  properties = list(
    value = S7::class_vector,
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
    } else if (!(self@type) %in% c("numeric", "string", "boolean", "date")) {
      "@type must be one of 'numeric', 'string', 'boolean', or 'date'"
    }
  }
)

#' Coerce `character`, `factor`, `numeric`, `logical`, and `Date`
#' vectors into [`fr_field`][fr::fr-package] objects
#'
#' The supported classes of `R` objects are converted to the corresponding frictionless `type`:
#' | **`R` class**   | **`fr` type**   |
#' |:-----------------|:-------------|
#' | `character()`, `factor()` | `string`* |
#' | `numeric()`, `integer()` | `number` |
#' | `logical()` | `boolean` |
#' | `Date` | `date` |
#'
#' *If a `factor()`, the `enum` `constraint` is set to the levels of the factor in R.
#' @param x a character, factor, numeric, integer, logical, or Date vector
#' @param ... `name`, `title`, or `description` property ([`name` is required](https://specs.frictionlessdata.io/table-schema/#name))
#' @return a [fr_field][fr::fr-package] object
#' @examples
#' as_fr_field(1:10, "example_integer") # -> frictionless numeric
#' as_fr_field((1:10) * 0.1, "example_double") # -> frictionless numeric
#' as_fr_field(letters, "example_character") # -> frictionless string
#' as_fr_field(factor(letters), "example_factor") # -> frictionless string with enum constraints
#' as_fr_field(c(TRUE, FALSE, TRUE), "example_logical") # -> frictionless boolean
#' as_fr_field(as.Date(c("2023-04-23", "2004-12-31")), "example_date") # -> frictionless date
#'
#' # an example `fr_field` object
#' uid <-
#'   replicate(34, paste0(sample(c(letters, 0:9), 8, TRUE), collapse = "")) |>
#'   as_fr_field(
#'     name = "uid",
#'     title = "Unique Identifier",
#'   )
#'
#' # set properties of the `fr_field`
#' S7::prop(uid, "description")
#' uid@description <- "Consists of 8 random characters from (a-z) and (0-9)"
#'
#' # inspect properties of the `fr_field`
#' uid
#' str(uid)
#' @export
as_fr_field <- S7::new_generic("as_fr_field", "x")

S7::method(as_fr_field, S7::class_numeric) <- function(x, name, ...) {
  fr_field(value = x, name = name, type = "numeric", ...)
}

S7::method(as_fr_field, S7::class_character) <- function(x, name, ...) {
  fr_field(value = x, name = name, type = "string", ...)
}

S7::method(as_fr_field, S7::class_factor) <- function(x, name, ...) {
  fr_field(value = x, name = name, type = "string", ..., constraints = list(enum = levels(x)))
}

S7::method(as_fr_field, S7::class_logical) <- function(x, name, ...) {
  fr_field(value = x, name = name, type = "boolean", ...)
}

S7::method(as_fr_field, S7::class_Date) <- function(x, name, ...) {
  fr_field(value = x, name = name, type = "date", ...)
}

#' Test if an object is a [`fr_field`][fr::fr-package] object
#' @param x an object to test
#' @return `TRUE` if object is a [fr_field][fr::fr-package] object, `FALSE` otherwise
#' @examples
#' is_fr_field(letters)
#' is_fr_field(as_fr_field(letters, "letters"))
#' @export
is_fr_field <- function(x) {
  inherits(x, "fr_field")
}

S7::method(as.vector, fr_field) <- function(x, ...) {
  x@value
}

#' Coerce a [`fr_field`][fr::fr-package] object into a vector
#' @details equivalent to `as.vector()`
#' @param x a [`fr_field`][fr::fr-package] object
#' @param ... ignored
#' @return depending on the `type` property of the object, a `character`, `factor`, `numeric`, `logical`, or `Date` vector
#' @export
as_vector <- S7::new_generic("as_vector", "x")

S7::method(as_vector, fr_field) <- function(x, ...) {
  as.vector(x)
}

S7::method(print, fr_field) <- function(x, ...) {
  cli::cli_dl(fr_desc(x))
  print(as_vector(x), ...)
}

S7::method(fr_desc, fr_field) <- function(x, ...) {
  fr_field_desc <- S7::props(x)
  fr_field_desc$value <- NULL
  if (length(fr_field_desc$constraints) == 0) fr_field_desc$constraints <- NULL
  return(fr_field_desc)
}