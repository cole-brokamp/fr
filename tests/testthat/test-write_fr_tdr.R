test_that("write_fr_tdr works", {
  write_fr_tdr(as_fr_tdr(mtcars, name = "my_mtcars"), dir = tempdir())
  expect_snapshot_file(fs::path(tempdir(), "my_mtcars", "my_mtcars.csv"))
  expect_snapshot_file(fs::path(tempdir(), "my_mtcars", "tabular-data-resource.yaml"))
  read_fr_tdr(fs::path(tempdir(), "my_mtcars")) |>
    expect_s3_class("fr_tdr")
})
