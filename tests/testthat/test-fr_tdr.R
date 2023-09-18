test_that("fr_tdr works", {

  fr_tdr(value = list(), name = "empty_tdr") |>
    expect_silent()
  
  list_of_fr_fields <-
    list(
      id = as_fr_field(letters, name = "id"),
      score = as_fr_field(rnorm(26), name = "score"),
      case = as_fr_field(sample(c(TRUE ,FALSE), 26, replace = TRUE),
                      name = "case",
                      description = "true if this person was a case")
    )

  fr_tdr(list_of_fr_fields, name = "my_dataset", homepage = "https://example.com") |>
    expect_s3_class("fr::fr_tdr")

  as_fr_tdr(x = mtcars, name = "mtcars", description = "the cars thing") |>
    expect_s3_class("fr::fr_tdr")

  expect_identical(as_tbl_df(as_fr_tdr(mtcars, "mtcars")),
                   tibble::as_tibble(mtcars))
})
