test_that("read_fr_tdr works", {
  read_tdr_csv(x = test_path("hamilton_poverty_2020", "tabular-data-resource.yaml")) |>
    expect_snapshot()
  })
