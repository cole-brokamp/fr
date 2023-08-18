## table_schema <- jsonlite::read_json("https://specs.frictionlessdata.io/schemas/table-schema.json")
# R6 object-oriented alternative package: https://github.com/frictionlessdata/tableschema-r
# this is much simpler approach using vctrs

# for working with frictionless table schema: https://specs.frictionlessdata.io/table-schema/

# for all fields: x can contain missing values
# x must be (or be coerceable to) its corresponding R class for each frictionless `type`:
# |   **R class**  | **frictionless type** |
# |:--------------:|:------------:|
# |    character, factor*   |    string    |
# |     numeric, integer    |    number    |
# |     logical    |    boolean   |
# |      Date      |     date     |
#
# *Levels of factor columns are also captured in the "enum" item of the "constraints" attribute list.


new_fr_field <- function(x,
                         name = character(),
                         title = character(),
                         description = character(),
                         type = c("string", "number", "boolean", "date")) {
  if (!rlang::is_character(name)) {
    rlang::abort("`name` must be a character vector.")
  }
  vctrs::vec_check_size(name, size = 1L)
  if (!rlang::is_character(title)) {
    rlang::abort("`title` must be a character vector.")
  }
  if (!rlang::is_character(description)) {
    rlang::abort("`description` must be a character vector.")
  }
  type <- rlang::arg_match(type)
  vctrs::new_vctr(x,
                  name = name,
                  title = title,
                  description = description,
                  type = type,
                  class = "fr_field")
}

format.fr_field <- function(x, ...) {
  cat(glue::glue("{attr(x, 'name')} (fr_{attr(x, 'type')})\n\n"))
  if (attr(x, "type") == "date") return(as.Date(vctrs::vec_data(x)))
  vctrs::vec_data(x)
}


obj_print_footer.fr_field <- function(x, ...) {
  desc <- attr(x, "description")
  if (!is.null(desc)){
    cat(" (", desc, ")\n", sep = "")
  }
}

#' create a frictionless [string](https://specs.frictionlessdata.io/table-schema/#string) field
#' @param x vector coerceable to a character vector; if x is a factor, its levels will be stored
#' in ??? TODO factor things...
#' @param name character string for name of the field; when read from a tdr_csv, *this* (i.e., not
#' `names(x)`) becomes the column name when in a data.frame or tibble
#' @param ... other metadata descriptors (`title`, `description`)
#' @return "fr_field" object
#' @examples
#' fr_string(letters, name = "letters")
#' d_letters <- fr_string(letters,
#'                        name = "letters",
#'                        title = "Letters of the Alphabet",
#'                        description = "Including from A to Z")
#' d_letters
#' str(d_letters)
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
#' @param ... other metadata descriptors (`title`, `description`)
#' @param parse parse x with `readr::parse_number` instead of coercion? requires that x is a character vector
#' @return "fr_field" object
#' @examples
#' fr_number(1:10, name = "score")
#' fr_number(c(10, 9, -Inf, NA, Inf, NaN), name = "score")
#' # setting parse = TRUE is useful when x contains non-numeric characters:
#' fr_number(c("$95,000", "$100,000", "78000"), name = "cost", parse = TRUE)
#' # parsing replaces non-numeric character values with missing values
#' fr_number(c("12%", "44%", "xx%"), name = "fraction_elevated", parse = TRUE)
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
#' @param ... other metadata descriptors (`title`, `description`)
#' @param format as used in `strptime()`, defaults to [ISO8601](https://en.wikipedia.org/wiki/ISO_8601)
#' @param parse parse x with `datefixR::fix_date_char` instead of coercion? requires that x is a character vector
#' @return "fr_field" object
#' @examples
#' # normal usage
#' fr_date(c("2023-01-01", "2023-03-01", "2022-11-24"), name = "event_date")
#' # also takes Dates if already converted
#' fr_date(as.Date(c("2023-01-01", "2023-03-01", "2022-11-24")), name = "event_date")
#' # can specify format for non-ISO8601 dates
#' fr_date(c("2023/01/01", "2023/03/01", "2022/11/24"), name = "event_date", format = "%Y/%m/%d")
#' # can parse dates in other formats with optionally installed {datefixR} package
#' fr_date(c("02/05/23", "02/05/21", "02/05/18"), name = "event_date", parse = TRUE)
#' # parsing is useful for year-month combinations too,
#' # as day is always imputed as the first of the month
#' fr_date(c("jan 2020", "feb 2020", "mar 2020"), name = "event_date", parse = TRUE)
#' fr_date(c("2020-01", "2020-02", "2020-03"), name = "event_date", parse = TRUE)
#' # parsing with a missing day and month (i.e., just year) will cause an error;
#' # consider using fr_numeric in this case instead
#' @export
fr_date <- function(x, name, ..., format = "%Y-%m-%d", parse = FALSE) {
  if (parse) {
    rlang::check_installed("datefixR", reason = "to parse dates")
    x <- vctrs::vec_cast(x, character())
    x <- datefixR::fix_date_char(x, day.impute = 1, month.impute = NULL)
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
#' @return "fr_field" object
#' @examples
#' fr_boolean(c(TRUE, FALSE, TRUE), name = "case")
#' # use parse = TRUE to use `as.logical()` to parse character strings for booleans
#' fr_boolean(c("true", "False", "TRUE", " "), name = "case", parse = TRUE)
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
