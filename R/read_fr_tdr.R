#' read a tabular-data-resource into R
#'
#' @param tdr_file path to a `tabular-data-resource.yaml` file
#' @param ... additional options passed onto `readr::read_csv()`
#' @return fr_tdr object
#' @export
read_tdr_csv <- function(x, ...) {
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

  lvls <-
    purrr::map(flds, "constraints", "enum") |>
    purrr::compact()

  if (length(lvls) > 0) col_classes[[names(lvls)]] <- "f"

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

  # TODO need rlang things here?
  if (length(lvls) > 0) {
    for (lvl in names(lvls)) {
      out <- dplyr::mutate(
        out,
        {{ lvl }} := forcats::fct_expand(
          dplyr::pull(out, {{ lvl }}),
          as.character(lvls[[lvl]])
        )
      )
    }
  }

  out <-
    fr_tdr(name = fr_descs$name,
           path = fr_descs$path,
           version = fr_descs$version,
           title = fr_descs$title,
           schema = 
             fr_schema(fields = lapply(fr_descs$schema$fields, as_fr_field)),
           data = the_data)

  return(out)
}

