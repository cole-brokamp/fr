test_that("update_field works", {

  d <- fr_tdr(
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
  )

  d |>
    as_list() |>
    purrr::pluck("schema", "fields", "case", "title") |>
    expect_identical(NULL)

  update_field(d, "case", title = "Case") |>
    as_list() |>
    purrr::pluck("schema", "fields", "case", "title") |>
    expect_identical("Case")

  update_field(d, "case", title = "Case", description = "My new description.") |>
    as_list() |>
    purrr::pluck("schema", "fields", "case", "description") |>
    expect_identical("My new description.")

  update_field(d, "case", !!!list(title = "Case", description = "My new description.")) |>
    as_list() |>
    purrr::pluck("schema", "fields", "case", "description") |>
    expect_identical("My new description.")
})
