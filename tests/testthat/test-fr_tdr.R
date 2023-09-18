test_that("fr_tdr works", {
  # empty tdr
  fr_tdr(value = list(), name = "empty_tdr") |>
    expect_s3_class("fr::fr_tdr")

  list(
    id = as_fr_field(letters, name = "id"),
    score = as_fr_field(rnorm(26), name = "score"),
    case = as_fr_field(sample(c(TRUE, FALSE), 26, replace = TRUE),
      name = "case",
      description = "true if this person was a case"
    )
  ) |>
    fr_tdr(name = "my_dataset", homepage = "https://example.com") |>
    expect_s3_class("fr::fr_tdr")

  as_fr_tdr(x = mtcars, name = "my_mtcars", description = "the cars thing") |>
    expect_s3_class("fr::fr_tdr") |>
    S7::prop("name") |>
    expect_identical("my_mtcars")

  expect_identical(
    as_tbl_df(as_fr_tdr(mtcars, "mtcars")),
    tibble::as_tibble(mtcars)
  )

  # works without supplying name
  as_fr_tdr(mtcars) |>
    expect_s3_class("fr::fr_tdr") |>
    expect_warning()

  as_fr_tdr(mtcars) |>
    S7::prop("name") |>
    expect_identical("mtcars") |>
    expect_warning()

  as_fr_tdr(tibble::as_tibble(mtcars)) |>
    S7::prop("name") |>
    expect_identical("tibble::as_tibble(mtcars)") |>
    expect_warning()
})
