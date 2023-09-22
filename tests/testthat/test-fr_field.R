test_that("as_fr_field works", {
  fr_field(name = "example_factor", type = "string",
           constraints = list(enum = c("ab", "cd", "ef"))) |>
    expect_s3_class("fr_field")
})

test_that("is_fr_field works", {
  expect_true(is_fr_field(fr_field(name = "letters", type = "string")))
  expect_false(is_fr_field(letters))
})

## test_that("printing fr_field", {
##   as_fr_field(letters, name = "letters") |>
##     expect_snapshot()
##   as_fr_field(letters, name = "letters", title = "Letters") |>
##     expect_snapshot()
##   as_fr_field(letters, name = "letters", description = "Those things in the alphabet.") |>
##     expect_snapshot()
##   as_fr_field(letters,
##     name = "letters",
##     title = "Letters",
##     description = "Those things in the alphabet."
##     ) |>
##     expect_snapshot()
##   as_fr_field(factor(letters),
##     name = "letters",
##     title = "Letters",
##     description = "Those things in the alphabet."
##     ) |>
##     expect_snapshot()
## })
