#' read a tabular-data-resource into R
#'
#' @param x path to a `tabular-data-resource.yaml` file
#' @param ... additional options passed onto `readr::read_csv()`
#' @return a [fr_tdr][fr::fr-package] object
#' @export
read_fr_tdr <- function(x, ...) {
  fr_descs <- yaml::read_yaml(x)
  fr_csv_path <- fs::path(fs::path_dir(x), fr_descs$path)

  flds <- purrr::pluck(fr_descs, "schema", "fields")

  type_class_cw <- c(
    "string" = "c",
    "number" = "n",
    "boolean" = "l",
    "integer" = "n",
    "date" = "D"
  )

  col_names <- names(flds)
  col_classes <- type_class_cw[purrr::map_chr(flds, "type")]

  the_data <-
    readr::read_csv(
      file = fr_csv_path,
      col_names = TRUE,
      col_types = paste(col_classes, collapse = ""),
      col_select = all_of({{ col_names }}),
      locale = readr::locale(
        encoding = "UTF-8",
        decimal_mark = ".",
        grouping_mark = ""
      ),
      name_repair = "check_unique",
      na = c("NA", ""),
      ...,
    )

  lvls <-
    purrr::map(flds, "constraints", "enum") |>
    purrr::compact()

  if (length(lvls) > 0) {
    for (lvl in names(lvls)) {
      the_data[[lvl]] <- factor(the_data[[lvl]], levels = lvls[[lvl]]$enum)
    }
  }

  pluck_char <- function(x, y) purrr::pluck(x, y, .default = character())

  out <-
    fr_tdr(name = pluck_char(fr_descs, "name"),
           path = pluck_char(fr_descs, "path"),
           version = pluck_char(fr_descs, "version"),
           title = pluck_char(fr_descs, "title"),
           homepage = pluck_char(fr_descs, "homepage"),
           description = pluck_char(fr_descs, "description"),
           schema = fr_schema(fields = lapply(fr_descs$schema$fields, as_fr_field)),
           data = the_data)

  return(out)
}
