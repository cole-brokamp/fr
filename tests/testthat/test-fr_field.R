test_that("fr_field works", {

  # print methods
  fr_field(x = 1, name = "x") |>
    expect_snapshot()

  fr_field(factor(letters), name = "letters") |>
    expect_snapshot()

  fr_field(factor(c("a", "b", "c")), name = "example_factor") |>
    expect_s3_class("fr_field") |>
    vctrs::vec_data() |>
    expect_type("character") |>
    factor(levels = c("a", "b", "c")) |>
    expect_s3_class("factor")

  fr_field(LETTERS, name = "example_string") |>
    expect_s3_class("fr_field") |>
    vctrs::vec_data() |>
    expect_type("character")

  fr_field(1:26, name = "example_numbers") |>
    expect_s3_class("fr_field") |>
    vctrs::vec_data() |>
    expect_type("integer")

  fr_field(c(1.23, 1.44, 4.55), name = "example_numbers") |>
    expect_s3_class("fr_field") |>
    vctrs::vec_data() |>
    expect_type("double")

  fr_field(c(TRUE, FALSE, TRUE), name = "example_logical") |>
    expect_s3_class("fr_field") |>
    vctrs::vec_data() |>
    expect_type("logical")

  fr_field(as.Date(c("2013-08-15", "1986-04-29", "1986-06-10")), name = "example_date") |>
    expect_s3_class("fr_field") |>
    vctrs::vec_data() |>
    as.Date() |>
    expect_s3_class("Date")

  fr_field(Sys.time()) |>
  expect_error("supported class for automatic frictionless typing")
})

test_that("fr_field_string works", {
  letters |>
    fr_field_string(name = "letters",
              title = "Letters of the Alphabet",
              description = "Including from A to Z") |>
    vctrs::vec_data() |>
    expect_equal(letters)
})

test_that("fr_field_number works", {
  nums <- c(1.233, NA, 2.444, 2, 1000)
  expect_equal(vctrs::vec_data(fr_field_number(nums, name = "score")), nums)
})

test_that("fr_field_number parsing works", {
  c("21%", NA, "44.45%", "85%") |>
    fr_field_number(name = "score", parse = TRUE) |>
    vctrs::vec_data() |>
    expect_equal(c(21, NA, 44.45, 85))
})

test_that("fr_field_date works", {
  date_strings <- c("2023-01-01", "2023-03-01", "2022-11-24")
  fr_field_date(date_strings, name = "event_date") |>
    vctrs::vec_data() |>
    as.Date() |>
    expect_equal(as.Date(date_strings))
  expect_equal(
    fr_field_date(c("2023-01-01", "2023-03-01", "2022-11-24"), name = "event_date"),
    fr_field_date(c("2023/01/01", "2023/03/01", "2022/11/24"), name = "event_date", format = "%Y/%m/%d")
  )
})

test_that("fr_field_date parsing works", {
  c("2/5/23", "2/5/21", "2/5/18") |>
    fr_field_date(name = "event_date", parse = TRUE) |>
    vctrs::vec_data() |>
    as.Date() |>
    expect_equal(as.Date(c("2023-02-05", "2021-02-05", "2018-02-05")))
})

test_that("fr_field_boolean works", {
  c(TRUE, FALSE, TRUE) |>
    fr_field_boolean(name = "case") |>
    vctrs::vec_data() |>
    expect_equal(c(TRUE, FALSE, TRUE))
})

test_that("fr_field_boolean parsing works", {
  c("true", "False", "TRUE", " ") |>
    fr_field_boolean(name = "case", parse = TRUE) |>
    vctrs::vec_data() |>
    expect_equal(c(TRUE, FALSE, TRUE, NA))
})
