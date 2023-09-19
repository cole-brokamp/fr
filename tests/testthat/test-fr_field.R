test_that("as_fr_field works", {
  as_fr_field(factor(c("a", "b", "c")), name = "example_factor") |>
    expect_s3_class("fr_field") |>
    as.vector() |>
    expect_s3_class("factor")

  as_fr_field(LETTERS, name = "example_string") |>
    expect_s3_class("fr_field") |>
    as.vector() |>
    expect_type("character")

  as_fr_field(1:26, name = "example_numbers") |>
    expect_s3_class("fr_field") |>
    as.vector() |>
    expect_type("integer")

  as_fr_field(c(1.23, 1.44, 4.55), name = "example_numbers") |>
    expect_s3_class("fr_field") |>
    as.vector() |>
    expect_type("double")

  as_fr_field(c(TRUE, FALSE, TRUE), name = "example_logical") |>
    expect_s3_class("fr_field") |>
    as.vector() |>
    expect_type("logical")

  as_fr_field(as.Date(c("2013-08-15", "1986-04-29", "1986-06-10")), name = "example_date") |>
    expect_s3_class("fr_field") |>
    as.vector() |>
    as.Date() |>
    expect_s3_class("Date")

  expect_identical(
    as.vector(as_fr_field(factor(letters), "example_factor")),
    factor(letters)
  )

  as_fr_field(Sys.time(), name = "time") |>
    expect_error("Can't find method for")
})

test_that("is_fr_field works", {
  expect_true(is_fr_field(as_fr_field(letters, "letters")))
  expect_false(is_fr_field(letters))
})

test_that("printing fr_field", {
  as_fr_field(letters, name = "letters") |>
    expect_snapshot()
  as_fr_field(letters, name = "letters", title = "Letters") |>
    expect_snapshot()
  as_fr_field(letters, name = "letters", description = "Those things in the alphabet.") |>
    expect_snapshot()
  as_fr_field(letters,
    name = "letters",
    title = "Letters",
    description = "Those things in the alphabet."
    ) |>
    expect_snapshot()
  as_fr_field(factor(letters),
    name = "letters",
    title = "Letters",
    description = "Those things in the alphabet."
    ) |>
    expect_snapshot()
})
