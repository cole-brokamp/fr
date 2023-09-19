#' extract the schema from a `fr_tdr` as a tibble 
#' @param x a [fr_tdr][fr::fr-package] object
#' @param ... ignored
#' @return a tibble where each column is a field-specific metadata
#' descriptor and each row is one field 
#' @export
fr_schema <- S7::new_generic("fr_schema", "x")
