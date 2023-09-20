test_that("fr_schema works", {
  withr::with_seed(1, {
    example_fr_tdr <<-
      list(
        id = as_fr_field(letters, name = "id"),
        cohort = as_fr_field(as.factor(sample(c("A", "B", "C"), 26, replace = TRUE)), name = "cohort"),
        score = as_fr_field(rnorm(26), name = "score"),
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

  example_fr_tdr |>
    fr_schema() |>
    expect_identical(
      list(
        id = list(
          name = "id", type = "string", title = character(0),
          description = character(0)
        ), cohort = list(
          name = "cohort",
          type = "string", title = character(0), description = character(0),
          constraints = list(enum = c("A", "B", "C"))
        ), score = list(
          name = "score", type = "numeric", title = character(0), description = character(0)
        ),
        case = list(
          name = "case", type = "boolean", title = character(0),
          description = "true if this person was a case"
        )
      )
    )

})
