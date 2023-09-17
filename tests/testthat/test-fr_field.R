test_that("as_fr_field works", {
  as_fr_field(factor(c("a", "b", "c")), name = "example_factor") |>
    expect_s3_class("fr::fr_field") |>
    as_vector() |>
    expect_s3_class("factor")

  as_fr_field(LETTERS, name = "example_string") |>
    expect_s3_class("fr::fr_field") |>
    as_vector() |>
    expect_type("character")

  as_fr_field(1:26, name = "example_numbers") |>
    expect_s3_class("fr::fr_field") |>
    as_vector() |>
    expect_type("integer")

  as_fr_field(c(1.23, 1.44, 4.55), name = "example_numbers") |>
    expect_s3_class("fr::fr_field") |>
    as_vector() |>
    expect_type("double")

  as_fr_field(c(TRUE, FALSE, TRUE), name = "example_logical") |>
    expect_s3_class("fr::fr_field") |>
    as_vector() |>
    expect_type("logical")

  as_fr_field(as.Date(c("2013-08-15", "1986-04-29", "1986-06-10")), name = "example_date") |>
    expect_s3_class("fr::fr_field") |>
    as_vector() |>
    as.Date() |>
    expect_s3_class("Date")

  expect_identical(
    as_vector(as_fr_field(factor(letters), "example_factor")),
    factor(letters)
  )

  as_fr_field(Sys.time(), name = "time") |>
    expect_error("Can't find method for")
})

test_that("is_fr_field works", {
  expect_identical(is_fr_field(letters), FALSE)
  expect_identical(is_fr_field(as_fr_field(letters, "letters")), TRUE)
})
