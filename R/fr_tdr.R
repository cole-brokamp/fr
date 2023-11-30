fr_tdr <- S7::new_class(
  "fr_tdr",
  parent = S7::class_data.frame,
  properties = list(
    name = S7::class_character,
    path = S7::class_character,
    version = S7::class_character,
    title = S7::class_character,
    homepage = S7::class_character,
    description = S7::class_character,
    schema = fr_schema
  ),
  validator = function(self) {
    if (length(self@name) != 1) {
      "@name must be length 1"
    } else if (!all(names(self@schema@fields) %in% names(S7::S7_data(self)))) {
      "not all fields in the schema are columns in the data frame"
    } else if (!all(names(S7::S7_data(self)) %in% names(self@schema@fields))) {
      "not all columns in the data frame are fields in the schema"
    }
  }
)

#' Coerce a data frame into a [`fr_tdr`][fr::fr-package] object
#' @param x a data.frame
#' @param ... <[`dynamic-dots`][rlang::dyn-dots]> required (`name`) and optional [tabular-data-resource properties](https://specs.frictionlessdata.io/data-resource/#descriptor) (e.g., `path`, `version`, `title`, `homepage`, `description`)
#' @details
#' Use the `.template` argument to provide a template [`fr_tdr`][fr::fr-package] object from which
#' table-specific (i.e. "name", "version", "title", "homepage", "description")
#' and field-specific metadata will be copied; note that all metadata provided
#' in `...` will be ignored if this argument is provided
#' @return a [fr_tdr][fr::fr-package] object
#' @export
#' @examples
#' as_fr_tdr(mtcars, name = "mtcars")
#' S7::prop(as_fr_tdr(mtcars, name = "mtcars"), "schema")
as_fr_tdr <- S7::new_generic("as_fr_tdr", "x")

S7::method(as_fr_tdr, S7::class_data.frame) <- function(x, ..., .template = NULL) {
  dots <- rlang::list2(...)
  if (!is.null(.template)) dots$name <- "foofy"
  if (is.null(dots$name)) {
    dots$name <- deparse(substitute(x))
    cli::cli_warn(c(
      "!" = "{.arg name} was not supplied, but was guessed",
      "i" = "specify with {.code as_fr_tdr({dots$name}, name = \"my_name\")}"
    ))
  }
  dots$schema <- fr_schema(fields = purrr::imap(x, as_fr_field))
  dots <- c(list(tibble::as_tibble(x)), dots)
  d_tdr <- do.call(fr_tdr, dots)
  ## d_tdr <- fr_tdr(tibble::as_tibble(x), !!! dots)
  out <- d_tdr

  if (!is.null(.template)) {
    field_intersect <- names(x)[names(x) %in% names(S7::S7_data(.template))]
    out <-
      purrr::reduce2(
        field_intersect,
        as.list(.template)$schema$fields[field_intersect],
        \(accum, xx, yy) fr::update_field(x = accum, field = xx, !!!yy),
        .init = d_tdr)
    S7::props(out) <- S7::props(.template)[c("name", "version", "title", "homepage", "description")]
  }
  
  return(out)
}

S7::method(as.data.frame, fr_tdr) <- function(x, ...) {
  S7::convert(x, S7::class_data.frame)
}

#' Coerce a [`fr_tdr`][fr::fr-package] object into a data frame
#'
#' Equivalent to `as.data.frame()`; directly using `tibble::as_tibble()`
#' also works because its input is first coerced with `as.data.frame()`
#' @param x a [`fr_tdr`][fr::fr-package] object
#' @param ... ignored
#' @return a data frame
#' @export
#' @examples
#' as_fr_tdr(mtcars, name = "mtcars") |>
#'   as_data_frame()
as_data_frame <- S7::new_generic("as_data_frame", "x")

S7::method(as_data_frame, fr_tdr) <- function(x, ...) {
  as.data.frame(x)
}

as_tibble <- S7::new_generic("as_tibble", "x")

S7::method(as_tibble, fr_tdr) <- function(x, ...) {
  tibble::as_tibble(as.data.frame(x), ...)
}

S7::method(as.list, fr_tdr) <- function(x, ...) {
  out <- purrr::compact(S7::props(x))
  out$schema <- as.list(out$schema)
  return(out)
}

#' Coerce a [`fr_tdr`][fr::fr-package] object into a list
#'
#' equivalent to `as.list()`
#' @param x a [`fr_tdr`][fr::fr-package] object
#' @param ... ignored
#' @return a list representing the frictionless metadata descriptor
#' @export
#' @examples
#' as_fr_tdr(mtcars, name = "mtcars") |>
#'   as_list()
as_list <- S7::new_generic("as_list", "x")

S7::method(as_list, fr_tdr) <- function(x, ...) {
  as.list(x)
}

S7::method(summary, fr_tdr) <- function(x, ...) {
  summary(S7::convert(d, S7::class_data.frame))
}

S7::method(print, fr_tdr) <- function(x, ...) {
  cli::cli_div(theme = list(
    span.fr_desc = list(color = "darkgrey"),
    "span.fr_desc" = list(before = "- "),
    "span.fr_desc" = list(after = "")))
  cli::cli_text("{.pkg {x@name}}")
  if (length(x@version) > 0) cli::cli_text("{.fr_desc version: {x@version}}")
  if (length(x@title) > 0) cli::cli_text("{.fr_desc title: {x@title}}")
  if (length(x@homepage) > 0) cli::cli_text("{.fr_desc homepage: {.url {x@homepage}}}")
  if (length(x@description) > 0) cli::cli_text("{.fr_desc description: {x@description}}")
  cli::cli_end()
  print(tibble::as_tibble(x), ...)
}

S7::method(`$`, fr_tdr) <- function(x, name, ...) {
  S7::S7_data(x)[[name]]
}

S7::method(`[[`, fr_tdr) <- function(x, name, ...) {
  S7::S7_data(x)[[name]]
}

S7::method(`[`, fr_tdr) <- function(x, name, ...) {
  S7::S7_data(x)[[name]]
}

