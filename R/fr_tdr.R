new_fr_tdr <- function(x,
                       name = character(),
                       version = character(),
                       title = character(),
                       description = character(),
                       homepage = character()) {
  ## if(!all(sapply(x, is_fr_field))) {
  ##   rlang::abort("not all variables in `x` are `tdr_field` objects")
  ## }
  rlang::check_required(x)
  x <- as.list(x)
  if (!rlang::is_character(name)) {
    rlang::abort("`name` must be a character vector.")
  }
  vctrs::vec_check_size(name, size = 1L)
  if (!rlang::is_character(title)) {
    rlang::abort("`name` must be a character vector.")
  }
  if (!rlang::is_character(description)) {
    rlang::abort("`description` must be a character vector.")
  }
  if (!rlang::is_character(version)) {
    rlang::abort("`version` must be a character vector.")
  }
  if (!rlang::is_character(homepage)) {
    rlang::abort("`homepage` must be a character vector.")
  }
  vctrs::new_list_of(
    x,
    ptype = fr_field(character(), name = "hey"),
    name = name,
    version = version[1],
    title = title[1],
    description = description[1],
    homepage = homepage[1],
    class = "fr_tdr")
}


# function that takes list of fr_field objects and creates a
# tibble of them based on their names

# function that takes tibble and adds name and type metadata automatically?
## fr_as_tdr() ??????
# leaves all optional metadata empty


#' tabular-data-resource
#' @return a [tibble][tibble::tibble-package]
#' @export
tdr <- function() {
  return(tibble::tibble())
}

## TODO do this when we get to tdr and tibbles
## https://vctrs.r-lib.org/articles/pillar.html
## pillar_shaft.fr_field <- function(x, ...) {
##   fmt <- vec_data(x)
##   }
