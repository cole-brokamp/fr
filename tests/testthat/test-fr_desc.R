test_that("fr_desc works for fr_field", {

  foofy <-
    as_fr_field(factor(letters[1:3]),
      name = "foofy",
      title = "Foofy",
      description = "This is just a placeholder for a description."
    )

  fr_desc(foofy) |>
    expect_identical(
      list(
        name = "foofy",
        type = "string",
        title = "Foofy",
        description = "This is just a placeholder for a description.",
        constraints = list(enum = c("a", "b", "c"))
      )
    )

  no_foofy <-
    as_fr_field(letters[1:3],
      name = "foofy",
      title = "Foofy",
      description = "This is just a placeholder for a description."
    )

  fr_desc(no_foofy) |>
    expect_identical(
      list(
        name = "foofy",
        type = "string",
        title = "Foofy",
        description = "This is just a placeholder for a description."
      )
    )

})
