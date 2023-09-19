#' extract the frictionless descriptors for a `fr_field` or `fr_tdr` object
#' @param x a [fr_tdr][fr::fr-package] or [fr_field][fr::fr-package] object
#' @param ... ignored
#' @return list of frictionless descriptors
#' @export
fr_desc <- S7::new_generic("fr_desc", "x")
