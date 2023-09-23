test_that("fr_tdr works", {

  fr_tdr(
    name = "my_example_dataset",
    version = "0.1.0",
    title = "My Example Dataset",
    homepage = "https://example.com",
    description = "This is the super fake dataset that was generated just for the purposes of illustrating the {fr} R package.",
    data = tibble::tibble(
      id = c("28f9j", "2ifne", "2foie"),
      cohort = factor(c("A", "B", "A"), levels = c("A", "B", "C")),
      score = c(1.2, 2.3, 2.1),
      case = c(TRUE, FALSE, TRUE)
    ),
    schema =
      fr_schema(
        fields = list(
          id = fr_field(name = "id", type = "string"),
          cohort = fr_field(
            name = "cohort", type = "string",
            constraints = list(enum = c("A", "B", "C"))
          ),
          score = fr_field(name = "score", type = "numeric"),
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
    tibble::as_tibble() |>
    expect_identical(tibble::as_tibble(mtcars))

  d_fr <-
    mtcars |>
    tibble::as_tibble() |>
    as_fr_tdr(name = "mtcars",
              version = "0.9.1",
              title = "Motor Trend Car Road Tests",
              homepage = "https://rdrr.io/r/datasets/mtcars.html",
              description = "The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models).")

    withr::with_options(list(width = 80), {
      d_fr |>
        expect_snapshot()

      as_fr_tdr(mtcars, name = "mtcars") |>
        expect_snapshot()
    })
            
})
