#' write a fr_tdr object to disk
#'
#' The `name` property of the `fr_tdr` object is used to write a frictionless tabular-data-resource to disk.  For example, if `name = "my_data"`, then the created folder and two files would look like:  
#' ```
#'my_data
#'├── my_data.csv
#'└── tabular-data-resource.yaml
#' ```
#' @param x a [fr_tdr][fr::fr-package] object to write to disk
#' @param dir path to directory where tabular-data-resource folder will be created
#' @return x (invisibly)
#' @export
write_fr_tdr <- function(x, dir = getwd()) {
  tdr_name <- x@name
  tdr_dir <- fs::path(dir, tdr_name)
  fs::dir_create(tdr_dir)
  tdr_csv <- fs::path(tdr_dir, tdr_name, ext = "csv")
  vroom::vroom_write(tibble::as_tibble(x), tdr_csv, delim = ",")
  x@path <- fs::path_rel(tdr_csv, start = tdr_dir)
  tdr_md <- as.list(x)
  tdr_md <- append(tdr_md, values = list(profile = "tabular-data-resource"), after = 0)
  cat(yaml::as.yaml(tdr_md),
      file = fs::path(tdr_dir, "tabular-data-resource.yaml"))
  return(invisible(x))
}
