new_fr_tdr <- function(...) {
  x <- rlang::list2(...)

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
