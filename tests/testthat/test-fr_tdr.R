test_that("fr_tdr works", {
  fr_tdr(
    tibble::tibble(
      id = c("28f9j", "2ifne", "2foie"),
      cohort = factor(c("A", "B", "A"), levels = c("A", "B", "C")),
      score = c(1.2, 2.3, 2.1),
      case = c(TRUE, FALSE, TRUE)
    ),
    name = "my_example_dataset",
    version = "0.1.0",
    title = "My Example Dataset",
    homepage = "https://example.com",
    description = "This is the super fake dataset that was generated just for the purposes of illustrating the {fr} R package.",
    schema =
      fr_schema(
        fields = list(
          id = fr_field(name = "id", type = "string"),
          cohort = fr_field(
            name = "cohort", type = "string",
            constraints = list(enum = c("A", "B", "C"))
          ),
          score = fr_field(name = "score", type = "number"),
          case = fr_field(
            name = "case", type = "boolean",
            description = "True if this person was a case."
          )
        )
      ),
  ) |>
    expect_s3_class("fr_tdr")

  as_fr_tdr(mtcars, name = "mtcars") |>
    as.data.frame() |>
    expect_identical(tibble::remove_rownames(mtcars))

  as_fr_tdr(mtcars, name = "mtcars") |>
    as_tibble() |>
    expect_identical(tibble::as_tibble(mtcars))

  d_fr <-
    mtcars |>
    tibble::as_tibble() |>
    dplyr::mutate(cyl = as.factor(cyl)) |>
    as_fr_tdr(
      name = "mtcars",
      version = "0.9.1",
      title = "Motor Trend Car Road Tests",
      homepage = "https://rdrr.io/r/datasets/mtcars.html",
      description = "The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models)."
    )

  # extractors
  expect_identical(d_fr$cyl, as.factor(mtcars$cyl))
  expect_identical(d_fr$mpg, mtcars$mpg)
  expect_identical(d_fr[["mpg"]], mtcars$mpg)
  expect_identical(d_fr["mpg"], mtcars$mpg)

  # as_list
  d_fr |>
    as_list() |>
    expect_identical(list(
      name = "mtcars", version = "0.9.1",
      title = "Motor Trend Car Road Tests", homepage = "https://rdrr.io/r/datasets/mtcars.html",
      description = "The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models).",
      schema = list(fields = list(
        mpg = list(name = "mpg", type = "number"),
        cyl = list(name = "cyl", type = "string", constraints = list(
          enum = c("4", "6", "8")
        )), disp = list(
          name = "disp",
          type = "number"
        ), hp = list(name = "hp", type = "number"),
        drat = list(name = "drat", type = "number"), wt = list(
          name = "wt", type = "number"
        ), qsec = list(
          name = "qsec",
          type = "number"
        ), vs = list(name = "vs", type = "number"),
        am = list(name = "am", type = "number"), gear = list(
          name = "gear", type = "number"
        ), carb = list(
          name = "carb",
          type = "number"
        )
      ))
    ))

  mtcars |>
    as_fr_tdr(name = "mtcars") |>
    as_data_frame() |>
    expect_identical(tibble::remove_rownames(mtcars))

  d_fr |>
    as_tibble() |>
    expect_identical(dplyr::mutate(tibble::as_tibble(mtcars), cyl = as.factor(cyl)))
})

test_that("as_fr_tdr works with a .template supplied", {

  d_mtcars <-
    as_fr_tdr(mtcars, name = "mtcars", title = "Motor Trend Car Road Tests") |>
    update_field("mpg", title = "Miles per Gallon")

  d <-
    mtcars |>
    tibble::as_tibble() |>
    dplyr::select(mpg, cyl, disp) |>
    as_fr_tdr(name = "my_mtcars", .template = d_mtcars)

    S7::prop(d, "title") |>
      expect_identical("Motor Trend Car Road Tests")

    d |>
      as.list() |>
      purrr::pluck("schema", "fields", "mpg", "title") |>
      expect_identical("Miles per Gallon")

  dd <-
    mtcars |>
    tibble::as_tibble() |>
    dplyr::select(mpg, cyl, disp) |>
    dplyr::rename(foofy = cyl) |>
    as_fr_tdr(.template = d_mtcars)

    dd |>
      as.list() |>
      purrr::pluck("schema", "fields", "mpg", "title") |>
      expect_identical("Miles per Gallon")

    dd |>
      as.list() |>
      purrr::pluck("schema", "fields", "carb") |>
      expect_null()

})

test_that("print methods for fr_tdr", {
  skip_on_ci()
  d_fr <-
    mtcars |>
    tibble::as_tibble() |>
    dplyr::mutate(cyl = as.factor(cyl)) |>
    as_fr_tdr(
      name = "mtcars",
      version = "0.9.1",
      title = "Motor Trend Car Road Tests",
      homepage = "https://rdrr.io/r/datasets/mtcars.html",
      description = "The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models)."
    )

  withr::with_options(list(width = 80), {
    d_fr |>
      expect_snapshot()
    as_fr_tdr(mtcars, name = "mtcars") |>
      expect_snapshot()
  })
})
