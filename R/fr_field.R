#' frictionless [field](https://specs.frictionlessdata.io/table-schema/#field-descriptors)
#' 
#' Based on the class input vector `x`, the appropriate `fr_*()` function
#' will be called to create a frictionless field descriptor object (`fr_field`).
#' 
#' Only classes listed in this table (and in this order) are used to automatically
#' select the correct `fr_*()` function.
#' 
#' | **R class**        | **fr type** | **`fr_*()`**   |
#' |:------------------:|:-----------:|:--------------:|
#' | character, factor^ | string      | `fr_string()`  |
#' | numeric, integer   | number      | `fr_number()`  |
#' | logical            | boolean     | `fr_boolean()` |
#' | Date               | date        | `fr_date()`    |
#' 
#' ^*Levels of factor columns are also captured in the "enum" item of the "constraints" attribute list.*
#'
#' To convert a class not specifically listed to a frictionless type
#' or to parse character vectors for a specific frictionless type,
#' use one of the `fr_*()` functions instead.
#' @param x a character, factor, numeric, integer, logical, or Date vector
#' @param name string required name metadata descriptor as a string
#' @param ... <[`dynamic-dots`][rlang::dyn-dots]> other optional metadata descriptors (`title`, `description`, `example`)
#' @return a [fr_field][fr::fr-package] vector
#' @examples
#' fr_field(letters, name = "example_string")
#' 
#' # TODO fr_field(factor(LETTERS), name = "example_factor")
#' 
#' fr_field(1:26, name = "example_numbers")
#' 
#' fr_field(c(TRUE, FALSE, TRUE), name = "example_logical")
#' 
#' fr_field(as.Date(c("2013-08-15", "1986-04-29", "1986-06-10")), name = "example_date")
#'
#' # a more realistic field with metadata
#' uid <-
#'   fr_field(
#'     replicate(34, paste0(sample(c(letters,0:9), 8, TRUE), collapse = "")),
#'     name = "uid",
#'     title = "Unique Identifier",
#'     description = "Consists of 8 random characters from (a-z) and (0-9)"
#' )
#' 
#' # examine metadata in `fr_field` objects using base R functions:
#' 
#' # the default print method includes the name and frictionless type,
#' # but otherwise prints the same as the underlying R type (here, a character vector):
#' uid
#' 
#' str(uid)
#'
#' attributes(uid)
#' 
#' # retrieve metadata descriptors with `attr()`:
#' attr(uid, "title")
#'
#' # using glue_data makes it easy to write clear documentation and messages using metadata fields:
#' glue::glue_data(attributes(uid), "`{name}` (a.k.a. '{title}') is a {type} field. {description}.")
#' @export
fr_field <- function(x, name, ...) {
  if (inherits(x, "character")) {
    return(new_fr_field(x = x, name = name, ..., type = "string"))
  }
  ## if (inherits(x, "factor")) {
  ##   return(fr_field(x = x, name = name, ..., type = "string"))
  ## # TODO add constraints = list(enum = levels(x))
  ## }
  if (inherits(x, "numeric")) {
    return(new_fr_field(x = x, name = name, ..., type = "number"))
  }
  if (inherits(x, "integer")) {
    return(new_fr_field(x = x, name = name, ..., type = "number"))
  }
  if (inherits(x, "logical")) {
    return(new_fr_field(x = x, name = name, ..., type = "boolean"))
  }
  if (inherits(x, "Date")) {
    return(new_fr_field(x = x, name = name, ..., type = "date"))
  }
  rlang::abort(c("x is not a supported class for automatic frictionless typing",
                 paste("the supplied vector was of class", class(x)[1], collapse = ""),
                 "try coercing with type-specific `fr_*()` functions"))
}


new_fr_field <- function(x,
                         name = character(),
                         ...,
                         type = c("string", "number", "boolean", "date")
                         ) {
  if (!rlang::is_character(name)) {
    rlang::abort("`name` must be a character vector.")
  }
  vctrs::vec_check_size(name, size = 1L)
  optional_descriptors <- rlang::list2(...)
  # TODO add checks for optional descriptors (character vector and of length one)
  # TODO should restrict to just supported descriptors?
  type <- rlang::arg_match(type)
  vctrs::new_vctr(x,
                  name = name,
                  !!!optional_descriptors,
                  type = type,
                  class = "fr_field") |>
    rlang::inject()
}

#' @export
format.fr_field <- function(x, ...) {
  cat(glue::glue("{attr(x, 'name')} (fr_{attr(x, 'type')})\n\n"))
  if (attr(x, "type") == "date") return(as.Date(vctrs::vec_data(x)))
  vctrs::vec_data(x)
}


## obj_print_footer.fr_field <- function(x, ...) {
##   desc <- attr(x, "description")
##   if (!is.null(desc)){
##     cat(" (", desc, ")\n", sep = "")
##   }
## }

#' frictionless [string](https://specs.frictionlessdata.io/table-schema/#string) field
#' @rdname fr_field
#' @examples
#' fr_string(letters, name = "letters")
#' fr_string(letters, name = "letters", title = "Letters")
#' @export
fr_string <- function(x, name, ...) {
  x <- vctrs::vec_cast(x, character())
  new_fr_field(x, name = name, ..., type = "string")
}

#' create a frictionless [number](https://specs.frictionlessdata.io/table-schema/#number) field
#' @details
#' - the frictionless special values: `Nan` (not a number),
#' `INF` (positive infinity), `-INF` (negative infinity) are represented in R as `NaN`, `Inf`, and -`Inf`
#' - use `readr::locale()` to change the frictionless `decimalChar` or `groupChar`
#' - a frictionless `bareNumber` property of false, is equivalent to `parse = TRUE` (and vice versa)
#' @param x vector coerceable to a numeric vector; or a character vector if `parse` is TRUE
#' @param name character string for name of the field; when read from a tdr_csv, *this* (i.e., not
#' `names(x)`) becomes the column name when in a data.frame or tibble
#' @param ... other metadata descriptors (see `fr_field()` for all possibilities)
#' @param parse parse x with `readr::parse_number` instead of coercion? requires that x is a character vector
#' @return a [fr_field][fr::fr-package] vector
#' @examples
#' fr_number(1:10, name = "score")
#' 
#' fr_number(c(10, 9, -Inf, NA, Inf, NaN), name = "score")
#' 
#' # setting parse = TRUE is useful when x contains non-numeric characters:
#' fr_number(c("$95,000", "$100,000", "78000"), name = "cost", parse = TRUE)
#' 
#' # parsing replaces non-numeric character values with missing values
#' fr_number(c("12%", "44%", "xx%"), name = "fraction_elevated", parse = TRUE)
#' 
#' # caution: combining numerics and characters into one character vector
#' # is unadvised and can lead to problems
#' c("$100", "$120", NaN, Inf)
#' fr_number(c("$100", "$120", NaN, Inf), name = "fraction_elevated", parse = TRUE)
#' @export
fr_number <- function(x, name, ..., parse = FALSE) {
  if (parse) x <- readr::parse_number(vctrs::vec_cast(x, character()))
  x <- vctrs::vec_cast(x, numeric())
  new_fr_field(x, name = name, ..., type = "number")
}

#' create a frictionless [date](https://specs.frictionlessdata.io/table-schema/#date) field
#' @param x vector coercable to a Date vector based on `format` (ideally as `YYYY-MM-DD`)
#' @param name character string for name of the field; when read from a tdr_csv, *this* (i.e., not
#' `names(x)`) becomes the column name when in a data.frame or tibble
#' @param ... other metadata descriptors (see `fr_field()` for all possibilities)
#' @param format see `format` argument in `strptime()`; defaults to [ISO8601](https://en.wikipedia.org/wiki/ISO_8601)
#' @param parse parse x with `datefixR::fix_date_char` instead of coercion? requires that x is a character vector and assumes that the month value comes before the day; e.g., `2/29/2023`
#' @return a [fr_field][fr::fr-package] vector
#' @examples
#' # normal usage
#' fr_date(c("2023-01-01", "2023-03-01", "2022-11-24"), name = "event_date")
#' 
#' # also takes Dates if already converted
#' fr_date(as.Date(c("2023-01-01", "2023-03-01", "2022-11-24")), name = "event_date")
#' 
#' # can specify format for non-ISO8601 dates
#' fr_date(c("2023/01/01", "2023/03/01", "2022/11/24"), name = "event_date", format = "%Y/%m/%d")
#' 
#' # can parse dates in other formats with optionally installed {datefixR} package
#' fr_date(c("02/05/23", "02/05/21", "02/05/18"), name = "event_date", parse = TRUE)
#' 
#' # parsing is useful for year-month combinations too,
#' # as day is always imputed as the first of the month
#' fr_date(c("jan 2020", "feb 2020", "mar 2020"), name = "event_date", parse = TRUE)
#' fr_date(c("2020-01", "2020-02", "2020-03"), name = "event_date", parse = TRUE)
#' 
#' # parsing with a missing day and month (i.e., just year) will cause an error;
#' # consider using fr_numeric in this case instead
#' @export
fr_date <- function(x, name, ..., parse = FALSE, format = "%Y-%m-%d") {
  if (parse) {
    rlang::check_installed("datefixR", reason = "to parse dates")
    x <- vctrs::vec_cast(x, character())
    x <- datefixR::fix_date_char(x, day.impute = 1, month.impute = NULL, format = "mdy")
    return(new_fr_field(x, name = name, ..., type = "date"))
  }
  x <- vctrs::vec_cast(as.Date(x, format = format), Sys.Date())
  return(new_fr_field(x, name = name, ..., type = "date"))
}

#' create a frictionless [boolean](https://specs.frictionlessdata.io/table-schema/#boolean) field
#' @param x vector coercable to a logical vector
#' @param name character string for name of the field; when read from a tdr_csv, *this* (i.e., not
#' `names(x)`) becomes the column name when in a data.frame or tibble
#' @param ... other metadata descriptors (`title`, `description`)
#' @param parse parse x with `as.logical` instead of coercion? requires that x is a character vector
#' @return a [fr_field][fr::fr-package] vector
#' @examples
#' fr_boolean(c(TRUE, FALSE, TRUE), name = "case")
#' 
#' # use parse = TRUE to use `as.logical()` to parse character strings for booleans
#' fr_boolean(c("true", "False", "TRUE", " "), name = "case", parse = TRUE)
#' 
#' # without parse = TRUE, abbreviations will cause an error
#' @export
fr_boolean <- function(x, name, ..., parse = FALSE) {
  if (parse) {
    x <- vctrs::vec_cast(x, character())
    x <- as.logical(x)
    return(new_fr_field(x, name = name, ..., type = "boolean"))
  }
  x <- vctrs::vec_cast(x, logical())
  new_fr_field(x, name = name, ..., type = "boolean")
}
