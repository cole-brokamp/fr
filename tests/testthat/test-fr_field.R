test_that("fr_field works", {
  fr_field(
    name = "example_factor", type = "string",
    constraints = list(enum = c("ab", "cd", "ef"))
  ) |>
    expect_s3_class("fr_field") |>
    S7::prop("constraints") |>
    expect_equal(list(enum = c("ab", "cd", "ef")))
})

test_that("as_fr_field works", {
  as_fr_field(factor(c("ab", "cd", "ef", "ef")), name = "example_factor") |>
    expect_s3_class("fr_field") |>
    S7::prop("constraints") |>
    expect_equal(list(enum = c("ab", "cd", "ef")))

  as_fr_field(1:10, name = "example_integer") |>
    expect_s3_class("fr_field") |>
    S7::prop("type") |>
    expect_equal("number")

  as_fr_field(0.1 * (1:10), name = "example_numeric") |>
    expect_s3_class("fr_field") |>
    S7::prop("type") |>
    expect_equal("number")

  as_fr_field(letters, name = "example_character") |>
    expect_s3_class("fr_field") |>
    S7::prop("type") |>
    expect_equal("string")

  as_fr_field(c(TRUE, FALSE, TRUE), name = "example_logical") |>
    expect_s3_class("fr_field") |>
    S7::prop("type") |>
    expect_equal("boolean")

  as_fr_field(as.Date(c("2023-09-23", "2011-11-19")), name = "example_date") |>
    expect_s3_class("fr_field") |>
    S7::prop("type") |>
    expect_equal("date")
})

test_that("fr_field from a list works", {
  as_fr_field(list(
    name = "example_factor", type = "string",
    constraints = list(enum = c("ab", "cd", "ef"))
  )) |>
    expect_s3_class("fr_field") |>
    S7::prop("constraints") |>
    expect_equal(list(enum = c("ab", "cd", "ef")))
})

test_that("is_fr_field works", {
  expect_true(is_fr_field(fr_field(name = "letters", type = "string")))
  expect_false(is_fr_field(letters))
})


test_that("fr_field printing", {
  skip_on_ci()
  withr::with_options(list(width = 80), {
    as_fr_field(factor(letters[1:5]),
      name = "letters_five",
      title = "Five Letters",
      description = "The first five letters from `letters` in R."
    ) |>
      expect_snapshot()
    as_fr_field(1:10, name = "example_integer") |>
      expect_snapshot()
  })
})
