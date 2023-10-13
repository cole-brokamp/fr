is_url <- function(x) grepl("^((http|ftp)s?|sftp)://", x)
has_tdr_yaml <- function(x) grepl("tabular-data-resource.yaml", x)

#' read a tabular-data-resource into R
#'
#' @param x path to a `tabular-data-resource.yaml` file
#' @param ... additional options passed onto `readr::read_csv()`
#' @return a [fr_tdr][fr::fr-package] object
#' @export
read_fr_tdr <- function(x, ...) {
  if (has_tdr_yaml(x)) {
    tdr_path <- x
  } else {
    if (is_url(x)) {
      tdr_path <- paste0(x, "/tabular-data-resource.yaml")
    } else {
      tdr_path <- fs::path(x, "tabular-data-resource.yaml")
    }
  }

  fr_descs <- yaml::read_yaml(tdr_path)
  profile <- purrr::pluck(fr_descs, "profile", .default = NA)
  if (is.na(profile) || {
    profile != "tabular-data-resource"
  }) {
    stop("profile must be 'tabular-data-resource' but is ", profile, call. = FALSE)
  }

  if (has_tdr_yaml(x)) {
    if (is_url(x)) {
      fr_csv_path <- sub("tabular-data-resource.yaml", fr_descs$path, x, fixed = TRUE)
    } else {
      fr_csv_path <- fs::path(fs::path_dir(x), fr_descs$path)
    }
  } else {
    if (is_url(x)) {
      fr_csv_path <- paste0(x, "/", fr_descs$path)
    } else {
      fr_csv_path <- fs::path(x, fr_descs$path)
    }
  }

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
      col_select = tidyselect::all_of({{ col_names }}),
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
    fr_tdr(
      name = pluck_char(fr_descs, "name"),
      path = pluck_char(fr_descs, "path"),
      version = pluck_char(fr_descs, "version"),
      title = pluck_char(fr_descs, "title"),
      homepage = pluck_char(fr_descs, "homepage"),
      description = pluck_char(fr_descs, "description"),
      schema = fr_schema(fields = lapply(fr_descs$schema$fields, as_fr_field)),
      data = the_data
    )

  return(out)
}
