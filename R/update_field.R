#' update field-specific metadata in a fr_tdr object
#' @param x a [`fr_tdr`][fr::fr-package] object
#' @param field character name of field in x to update
#' @param ... [table schema field descriptors](https://specs.frictionlessdata.io/table-schema/#field-descriptors) (e.g., `title`, `description`)
#' @return an [`fr_tdr`][fr::fr-package] object containing the updated field
#' @export
#' @examples
#' my_mtcars <-
#'   mtcars |>
#'   as_fr_tdr(name = "mtcars") |>
#'   update_field("mpg", title = "Miles Per Gallon")
#' 
#' str(my_mtcars@schema@fields$mpg)
update_field <- function(x, field, ...) {

  x_fields <-
    S7::prop(x, "schema") |>
    S7::prop("fields") |>
    names()

  if (!field %in% x_fields) {
    stop("Can't find field ", field, " in x", call. = FALSE)
  }

  x@schema@fields[[field]] <- as_fr_field(S7::prop(S7::prop(x, "schema"), "fields")[[field]], ...)

  return(x)
  }
