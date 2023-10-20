#' dplyr methods for fr_tdr objects
#'
#' Some basic dplyr functions are re-implemented here for for `fr_tdr` objects.
#' The input is converted with `as.data.frame()` before being
#' passed to the dplyr function. The resulting tibble object is converted back
#' into a `fr_tdr` object, matching table- and field-specific metadata where
#' possible by using `as_fr_tdr()` and specifying the `.template` argument.
#' &nbsp;
#' | **dplyr** | **fr** |
#' |:----------------:|:-------------:|
#' | `mutate()` | `fr_mutate()` |
#' | `rename()` | `fr_rename()` |
#' | `select()` | `fr_select()` |
#' | `filter()` | `fr_filter()` |
#' | `summarise()` | `fr_summarise()` |
#' | `arrange()` | `fr_arrange()` |
#'
#' @name dplyr_methods
#' @param x a [`fr_tdr`][fr::fr-package] object
#' @param ... passed to the underlying dplyr function
#' @return a [`fr_tdr`][fr::fr-package] object
NULL

#' fr_mutate
#' @rdname dplyr_methods
#' @export
fr_mutate <- function(x, ...) {
  x_d <- S7::convert(x, S7::class_data.frame)
  x_d_mod <- dplyr::mutate(x_d, ...)
  as_fr_tdr(x_d_mod, .template = x)
}

#' fr_rename
#' @rdname dplyr_methods
#' @export
fr_rename <- function(x, ...) {
  x_d <- S7::convert(x, S7::class_data.frame)
  x_d_mod <- dplyr::rename(x_d, ...)
  as_fr_tdr(x_d_mod, .template = x)
}

#' fr_select
#' @rdname dplyr_methods
#' @export
fr_select <- function(x, ...) {
  x_d <- S7::convert(x, S7::class_data.frame)
  x_d_mod <- dplyr::select(x_d, ...)
  as_fr_tdr(x_d_mod, .template = x)
}

#' fr_filter
#' @rdname dplyr_methods
#' @export
fr_filter <- function(x, ...) {
  x_d <- S7::convert(x, S7::class_data.frame)
  x_d_mod <- dplyr::filter(x_d, ...)
  as_fr_tdr(x_d_mod, .template = x)
}

#' fr_summarise
#' @rdname dplyr_methods
#' @export
fr_summarise <- function(x, ...) {
  x_d <- S7::convert(x, S7::class_data.frame)
  x_d_mod <- dplyr::summarise(x_d, ...)
  as_fr_tdr(x_d_mod, .template = x)
}

#' fr_arrange
#' @rdname dplyr_methods
#' @export
fr_arrange <- function(x, ...) {
  x_d <- S7::convert(x, S7::class_data.frame)
  x_d_mod <- dplyr::arrange(x_d, ...)
  as_fr_tdr(x_d_mod, .template = x)
}
