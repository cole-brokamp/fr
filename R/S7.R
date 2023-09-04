library(S7)

fr_field <- new_class("fr_field", properties = list(
  value = class_vector,
  name = class_character,
  type = class_character,
  title = class_character,
  description = class_character,
  constraints = class_list
))

as_fr_field <- new_generic("as_fr_field", "x")

method(as_fr_field, class_numeric) <- function(x, name, ...) {
  fr_field(value = x, name = name, type = "numeric", ...)
}

method(as_fr_field, class_character) <- function(x, name, ...) {
  fr_field(value = x, name = name, type = "string", ...)
}

method(as_fr_field, class_factor) <- function(x, name, ...) {
  fr_field(value = x, name = name, type = "string", ..., constraints = list(enum = levels(x)))
}

method(as_fr_field, class_logical) <- function(x, name, ...) {
  fr_field(value = x, name = name, type = "boolean", ...)
}

method(as_fr_field, class_Date) <- function(x, name, ...) {
  fr_field(value = x, name = name, type = "date", ...)
}

## method(print, fr_field) <- function(x, ...) {
##   cat(glue::glue("{x@name} (frictionless {x@type}"))
##   cat(ifelse(is.null(x@constraints$enum), ")\n", " w/ enum)\n"))
##   cat(ifelse(is.null(x@title), character(), glue::glue("{x@title}\n")))
##   cat(ifelse(is.null(x@description), character(), "x@description\n"))
##   print(x@value)
## }

method(print, fr_field) <- function(x, ...) {
  glue::glue("\n",
    " name: {x@name}",
    " type: {x@type}",
    "title: {x@title}",
    ## "description: {x@description}",
    .sep = "\n"
  ) |>
    print()
  print(x@value)
}

as_fr_field(1:10, "example_integer", title = "Example Integer")


## examples
as_fr_field(1:10, "example_integer") # -> frictionless numeric
as_fr_field((1:10) * 0.1, "example_double") # -> frictionless numeric
as_fr_field(letters, "example_character") # -> frictionless string
as_fr_field(factor(letters), "example_factor") # -> frictionless string with enum constraints
as_fr_field(c(TRUE, FALSE, TRUE), "example_logical") # -> frictionless boolean
as_fr_field(as.Date(c("2023-04-23", "2004-12-31")), "test_score") # -> frictionless date

xx <- as_fr_field(1:10, "example_integer")

uid <-
  replicate(34, paste0(sample(c(letters, 0:9), 8, TRUE), collapse = "")) |>
  as_fr_field(
    name = "uid",
    title = "Unique Identifier",
  )

prop(uid, "description")
uid@description <- "Consists of 8 random characters from (a-z) and (0-9)"

str(uid)

describe <- new_generic("describe", "x")

method(describe, fr_field) <- function(x) {
  glue::glue(
    "name: {x@name}",
    ## "title: {x@title}",
    "frictionless type: {x@type}",
    ## "description: {x@description}",
    .sep = "\n",
    .null = "",
    .na = "",
  )
}

describe(uid)

str(xx)
pillar::glimpse(uid)

describe(xx)
