is_url <- function(x) grepl("^((http|ftp)s?|sftp)://", x)
has_tdr_yaml <- function(x) grepl("tabular-data-resource.yaml", x)

#' read a tabular-data-resource into R
#'
#' @inheritParams vroom::vroom
#' @return a [fr_tdr][fr::fr-package] object
#' @details A file path (or url) representing a folder
#' that contains a "tabular-data-resource.yaml" can
#' be used in `file`.
#' @export
#' @examples
#' read_fr_tdr(fs::path_package("fr", "hamilton_poverty_2020"))
read_fr_tdr <- function(file) {
  if (has_tdr_yaml(file)) {
    tdr_path <- file
  } else {
    if (is_url(file)) {
      tdr_path <- paste0(file, "/tabular-data-resource.yaml")
    } else {
      tdr_path <- fs::path(file, "tabular-data-resource.yaml")
    }
  }

  fr_descs <- yaml::read_yaml(tdr_path)
  profile <- purrr::pluck(fr_descs, "profile", .default = NA)
  if (is.na(profile) || {
    profile != "tabular-data-resource"
  }) {
    stop("profile must be 'tabular-data-resource' but is ", profile, call. = FALSE)
  }

  if (has_tdr_yaml(file)) {
    if (is_url(file)) {
      fr_csv_path <- sub("tabular-data-resource.yaml", fr_descs$path, file, fixed = TRUE)
    } else {
      fr_csv_path <- fs::path(fs::path_dir(file), fr_descs$path)
    }
  } else {
    if (is_url(file)) {
      fr_csv_path <- paste0(file, "/", fr_descs$path)
    } else {
      fr_csv_path <- fs::path(file, fr_descs$path)
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
    vroom::vroom(
      file = fr_csv_path,
      delim = ",",
      col_select = tidyselect::all_of({{ col_names }}),
      col_types = paste(col_classes, collapse = ""),
      locale = vroom::locale(
        encoding = "UTF-8",
        decimal_mark = ".",
        grouping_mark = ""
      ),
      .name_repair = "check_unique",
      na = c("", "NA")
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
      the_data,
      name = pluck_char(fr_descs, "name"),
      path = pluck_char(fr_descs, "path"),
      version = pluck_char(fr_descs, "version"),
      title = pluck_char(fr_descs, "title"),
      homepage = pluck_char(fr_descs, "homepage"),
      description = pluck_char(fr_descs, "description"),
      schema = fr_schema(fields = lapply(fr_descs$schema$fields, as_fr_field))
    )

  return(out)
}
