test_that("read_fr_tdr works", {

  read_fr_tdr(x = test_path("hamilton_poverty_2020")) |>
    expect_s3_class("fr_tdr")

  d_tdr <- read_fr_tdr(x = test_path("example_data_with_types", "tabular-data-resource.yaml"))
  expect_identical(levels(d_tdr$rating), c("good", "better", "best"))
  expect_identical(attr(d_tdr, "name"), "example_data_with_types")
  expect_identical(attr(d_tdr, "path"), "example_data_with_types.csv")

  read_fr_tdr("https://github.com/geomarker-io/curated_violations/releases/download/0.1.2/tabular-data-resource.yaml") |>
    expect_s3_class("fr_tdr")

  read_fr_tdr("https://github.com/geomarker-io/curated_violations/releases/download/0.1.2") |>
    expect_s3_class("fr_tdr")

})
