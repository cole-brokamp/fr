test_that("fr_schema works", {
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
  ) |>
    expect_s3_class("fr_schema")

  fr_schema(
    fields = list(
      fr_field(name = "first_field", type = "number"),
      fr_field(name = "second_field", type = "string")
    ),
    missingValues = "NA",
    primaryKey = "first_field",
    foreignKeys = c("first_field", "second_field")
  ) |>
    as.list() |>
    expect_identical(
      list(
        fields = list(
          list(name = "first_field", type = "number"),
          list(name = "second_field", type = "string")
        ), missingValues = "NA",
        primaryKey = "first_field", foreignKeys = c(
          "first_field",
          "second_field"
        )
      )
    )
})

test_that("fr_schema printing", {
  skip_on_ci()
  withr::with_options(list(width = 80), {
    read_fr_tdr(fs::path_package("fr", "hamilton_poverty_2020"))@schema |>
      expect_snapshot()
  })
})
