test_that("fr_tdr works", {

  # empty tdr
  fr_tdr(fields = list(), name = "empty_tdr") |>
    expect_s3_class("fr_tdr")

  withr::with_seed(1, {
    example_fr_tdr <<-
      list(
        id = as_fr_field(letters, name = "id"),
        score = as_fr_field(round(rnorm(26), 4), name = "score"),
        case = as_fr_field(sample(c(TRUE, FALSE), 26, replace = TRUE),
          name = "case",
          description = "true if this person was a case"
        )
      ) |>
      fr_tdr(
        name = "my_example_dataset",
        version = "0.1.0",
        title = "My Example Dataset",
        homepage = "https://example.com",
        description = "This is the super fake dataset that was generated just for the purposes of illustrating the {fr} R package."
      )
  })

  expect_s3_class(example_fr_tdr, "fr_tdr")

  fr_desc(example_fr_tdr) |>
    expect_identical(list(
      name = "my_example_dataset",
      path = character(0),
      version = "0.1.0",
      title = "My Example Dataset",
      homepage = "https://example.com",
      description = "This is the super fake dataset that was generated just for the purposes of illustrating the {fr} R package."
    ))

  withr::with_options(list(width = 80), {
    example_fr_tdr |>
      expect_snapshot()
  })

  as_fr_tdr(x = mtcars, name = "my_mtcars", description = "the cars thing") |>
    expect_s3_class("fr_tdr") |>
    S7::prop("name") |>
    expect_identical("my_mtcars") |>
    expect_warning("row.names will be dropped")

  as_fr_tdr(mtcars, "mtcars") |>
    expect_warning("row.names will be dropped")

  no_row_names_mtcars <- tibble::remove_rownames(mtcars)

  as_fr_tdr(no_row_names_mtcars, "mtcars") |>
    as.data.frame() |>
    expect_identical(no_row_names_mtcars)

  as_fr_tdr(no_row_names_mtcars) |>
    expect_s3_class("fr_tdr") |>
    expect_warning("was not supplied")

  as_fr_tdr(no_row_names_mtcars) |>
    S7::prop("name") |>
    expect_identical("no_row_names_mtcars") |>
    expect_warning("was not supplied")

  # tibble removes row.names, so no concern there
  as_fr_tdr(tibble::as_tibble(mtcars), "mtcars") |>
    tibble::as_tibble() |>
    expect_identical(tibble::as_tibble(mtcars))

  as_fr_tdr(tibble::as_tibble(mtcars)) |>
    S7::prop("name") |>
    expect_identical("tibble::as_tibble(mtcars)") |>
    expect_warning()
})
