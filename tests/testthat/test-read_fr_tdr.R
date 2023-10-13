test_that("read_fr_tdr works", {
  read_fr_tdr(test_path("hamilton_poverty_2020")) |>
    expect_s3_class("fr_tdr")

  d_tdr <- read_fr_tdr(file = test_path("example_data_with_types", "tabular-data-resource.yaml"))
  expect_identical(levels(d_tdr$rating), c("good", "better", "best"))
  expect_identical(attr(d_tdr, "name"), "example_data_with_types")
  expect_identical(attr(d_tdr, "path"), "example_data_with_types.csv")
})

test_that("read_fr_tdr works with url", {
  skip_on_ci()
  skip_if_offline()
  read_fr_tdr("https://raw.githubusercontent.com/cole-brokamp/fr/main/inst/hamilton_poverty_2020/tabular-data-resource.yaml") |>
    expect_s3_class("fr_tdr")

  read_fr_tdr("https://raw.githubusercontent.com/cole-brokamp/fr/main/inst/hamilton_poverty_2020") |>
    expect_s3_class("fr_tdr")
})
