fr_tdr <- S7::new_class(
  "fr_tdr",
  properties = list(
    value = S7::class_list,
    name = S7::class_character,
    path = S7::class_character,
    version = S7::class_character,
    title = S7::class_character,
    homepage = S7::class_character,
    description = S7::class_character
  ),
  # TODO automatically create the schema and fields property for fr_tdr based on value
  # no, this really only needs to be done when casting from fr_tdr to list of schema
  validator = function(self) {
    x <- self@value
    if (!all(sapply(x, is_fr_field))) {
      "all items in @value should be fr_field objects"
    } else if (length(self@name) != 1) {
      "@name must be length 1"
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
  if (tibble::has_rownames(x)) {
    cli::cli_warn(c(
      "!" = "row.names will be dropped",
      "i" = "convert row.names to a new column with {.code tibble::rowid_to_column}",
      "i" = "remove row.names with {.code tibble::remove_rownames}"
    ))
  }
  fr_tdr(
    value = purrr::imap(x, as_fr_field),
    name = name,
    ...
  )
}

S7::method(as.data.frame, fr_tdr) <- function(x, ...) {
  as.data.frame(sapply(x@value, as.vector))
}

#' Coerce a [`fr_tdr`][fr::fr-package] object into a data frame
#'
#' - equivalent to `as.data.frame()`
#' - `tibble::as_tibble()` also works because its input is first
#' coerced with `as.data.frame()`
#' @param x a [`fr_tdr`][fr::fr-package] object
#' @param ... ignored
#' @return a data frame
#' @export
as_data_frame <- S7::new_generic("as_data_frame", "x")

S7::method(as_data_frame, fr_tdr) <- function(x, ...) {
  as.data.frame(x)
}

S7::method(print, fr_tdr) <- function(x, ...) {
  c(
    ## "type" = "{.obj_type_friendly {x}}",
    "name" = "{.pkg {x@name}}",
    "path" = "{.path {x@path}}",
    "version" = "{.field {x@version}}",
    "title" = "{.field {x@title}}",
    "homepage" = "{.url {x@homepage}}",
    "description" = "{.field {x@description}}"
  ) |>
    cli::cli_dl()
  print(tibble::as_tibble(x), ...)
}

S7::method(fr_desc, fr_tdr) <- function(x, ...) {
  fr_tdr_desc <- S7::props(x)
  fr_tdr_desc$value <- NULL
  return(fr_tdr_desc)
}

S7::method(`$`, fr_tdr) <- function(x, name, ...) {
  x@value[[name]]
}

S7::method(`[[`, fr_tdr) <- function(x, name, ...) {
  x@value[[name]]
}

S7::method(`[`, fr_tdr) <- function(x, name, ...) {
  x@value <- list(x@value[[name]])
  return(x)
}

S7::method(fr_schema, fr_tdr) <- function(x, ...) {
  lapply(x@value, fr_desc)
}
