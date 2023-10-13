fr_tdr <- S7::new_class(
  "fr_tdr",
  properties = list(
    name = S7::class_character,
    path = S7::class_character,
    version = S7::class_character,
    title = S7::class_character,
    homepage = S7::class_character,
    description = S7::class_character,
    schema = fr_schema,
    data = S7::class_data.frame
  ),
  validator = function(self) {
    if (length(self@name) != 1) {
      "@name must be length 1"
    } else if (!all(names(self@schema@fields) %in% names(self@data))) {
      "not all fields in the schema are columns in the data frame"
    } else if (!all(names(self@data) %in% names(self@schema@fields))) {
      "not all columns in the data frame are fields in the schema"
    }
  }
)

#' Coerce a data frame into a [`fr_tdr`][fr::fr-package] object
#' @param x a data.frame
#' @param name the `name` property
#' @param ... optional [tabular-data-resource properties](https://specs.frictionlessdata.io/data-resource/#descriptor) (e.g., `path`, `version`, `title`, `homepage`, `description`
#' @return a [fr_tdr][fr::fr-package] object
#' @export
as_fr_tdr <- S7::new_generic("as_fr_tdr", "x")

S7::method(as_fr_tdr, S7::class_data.frame) <- function(x, name = NULL, ...) {
  if (is.null(name)) {
    cli::cli_warn(c(
      "!" = "{.arg name} was not supplied, but was guessed",
      "i" = "instead, specify the {.arg name} argument"
    ))
    name <- deparse(substitute(x))
  }
  fr_tdr(
    schema = fr_schema(fields = purrr::imap(x, as_fr_field)),
    name = name,
    data = tibble::as_tibble(x),
    ...
  )
}

S7::method(as.data.frame, fr_tdr) <- function(x, ...) {
  as.data.frame(x@data)
}

#' Coerce a [`fr_tdr`][fr::fr-package] object into a data frame
#'
#' Equivalent to `as.data.frame()`; directly using `tibble::as_tibble()`
#' also works because its input is first coerced with `as.data.frame()`
#' @param x a [`fr_tdr`][fr::fr-package] object
#' @param ... ignored
#' @return a data frame
#' @export
as_data_frame <- S7::new_generic("as_data_frame", "x")

S7::method(as_data_frame, fr_tdr) <- function(x, ...) {
  as.data.frame(x)
}

S7::method(as.list, fr_tdr) <- function(x, ...) {
  out <- S7::props(x)
  out$data <- NULL
  out$schema <- purrr::compact(S7::props(out$schema))
  out$schema$fields <- lapply(out$schema$fields, \(x) purrr::compact(S7::props(x)))
  return(out)
}

#' Coerce a [`fr_tdr`][fr::fr-package] object into a list
#'
#' equivalent to `as.list()`
#' @param x a [`fr_tdr`][fr::fr-package] object
#' @param ... ignored
#' @return a list representing the frictionless metadata descriptor
#' @export
as_list <- S7::new_generic("as_list", "x")

S7::method(as_list, fr_tdr) <- function(x, ...) {
  as.list(x)
}

S7::method(print, fr_tdr) <- function(x, ...) {
  cli::cli_div(theme = list(
    span.fr_desc = list(color = "lightgrey"),
    "span.fr_desc" = list(before = "• "),
    "span.fr_desc" = list(after = "")))
  cli::cli_text(c(" " = "── {.pkg {x@name}} ──"))
  if (length(x@version) > 0) cli::cli_text("{.fr_desc version: {x@version}}")
  if (length(x@title) > 0) cli::cli_text("{.fr_desc title: {x@title}}")
  if (length(x@homepage) > 0) cli::cli_text("{.fr_desc homepage: {.url {x@homepage}}}")
  if (length(x@description) > 0) cli::cli_text("{.fr_desc description: {x@description}}")
  cli::cli_end()
  print(tibble::as_tibble(x), ...)
}

S7::method(`$`, fr_tdr) <- function(x, name, ...) {
  x@data[[name]]
}

S7::method(`[[`, fr_tdr) <- function(x, name, ...) {
  x@data[[name]]
}

S7::method(`[`, fr_tdr) <- function(x, name, ...) {
  x@data[[name]]
}
