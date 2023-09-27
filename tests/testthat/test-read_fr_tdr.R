test_that("read_fr_tdr works", {
  read_fr_tdr(x = test_path("hamilton_poverty_2020", "tabular-data-resource.yaml")) |>
    expect_snapshot()

  d_tdr <- read_fr_tdr(x = test_path("example_data_with_types", "tabular-data-resource.yaml"))
  expect_identical(levels(d_tdr$rating), c("good", "better", "best"))
  expect_identical(attr(d_tdr, "name"), "example_data_with_types")
  expect_identical(attr(d_tdr, "path"), "example_data_with_types.csv")

  })
