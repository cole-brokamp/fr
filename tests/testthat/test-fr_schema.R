test_that("fr_schema works", {

  withr::with_seed(1, {
    example_fr_tdr <<-
      list(
        id = as_fr_field(letters, name = "id"),
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

  withr::with_options(list(width = 80), {
    example_fr_tdr |>
      fr_schema() |>
      expect_snapshot()
  })

})
