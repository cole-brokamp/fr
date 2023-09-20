#' @keywords internal
"_PACKAGE"

# TODO add documentation here about the two classes and their methods

## usethis namespace: start
#' @importFrom cli cli_warn
#' @importFrom purrr imap
#' @importFrom purrr map
#' @importFrom purrr list_rbind
#' @importFrom tibble as_tibble
#' @importFrom tidyr unnest
#' @importFrom tidyr pivot_wider
## usethis namespace: end
NULL

.onLoad <- function(...) {
  S7::methods_register()
}
