test_that("write_fr_tdr works", {
  withr::with_dir(tempdir(), {
    write_fr_tdr(as_fr_tdr(mtcars, "my_mtcars"))
    expect_snapshot_file(fs::path("my_mtcars", "my_mtcars.csv"))
    expect_snapshot_file(fs::path("my_mtcars", "tabular-data-resource.yaml"))
  })
})
