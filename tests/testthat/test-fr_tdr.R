test_that("fr_tdr works", {
  x <-
    tibble::tibble(
      id = fr_field(letters, name = "id"),
      score = fr_field(rnorm(26), name = "score"),
      case = fr_field(sample(c(TRUE ,FALSE), 26, replace = TRUE),
                      name = "case",
                      description = "true if this person was a case")
    )
  new_fr_tdr(x, name = "my_dataset") |>
    attributes()
    expect_s3_class("list")
})



## the_md <- yaml::read_yaml("https://github.com/geomarker-io/hamilton_property_code_enforcement/releases/download/0.1.2/tabular-data-resource.yaml")


## field_md_2 <- the_md$schema$fields[[2]]

## fr_field(x = 1:10, !!!field_md_2, type = "number")
