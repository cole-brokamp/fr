test_that("fr_schema works", {

  fr_schema(
    fields = list(
      id = fr_field(name = "id", type = "string"),
      cohort = fr_field(name = "cohort", type = "string",
                        constraints = list(enum = c("A", "B", "C"))),
      score = fr_field(name = "score", type = "number"),
      case = fr_field(name = "case", type = "boolean",
                      description = "True if this person was a case."))
  ) |>
    expect_s3_class("fr_schema")

})
