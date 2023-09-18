fr_tdr <- S7::new_class(
  "fr_tdr",
  package = "fr",
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
  fr_tdr(
    value = purrr::imap(x, as_fr_field),
    name = name,
    ...
  )
}

#' Coerce a [`fr_tdr`][fr::fr-package] object into a data frame
#' @param x a [`fr_tdr`][fr::fr-package]
#' @param ... ignored
#' @return a tibble
#' @export
as_tbl_df <- S7::new_generic("as_tbl_df", "x")

S7::method(as_tbl_df, fr_tdr) <- function(x) tibble::as_tibble(sapply(x@value, as_vector))
