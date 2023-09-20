#' extract the schema from a `fr_tdr` as a list 
#' @param x a [fr_tdr][fr::fr-package] object
#' @param ... ignored
#' @return a list with one item per field, where each
#' item is a list of field-specific metadata descriptors
#' @export
fr_schema <- S7::new_generic("fr_schema", "x")
