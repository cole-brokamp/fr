test_that("fr_string works", {
  nums <- c(1.233, NA, 2.444, 2, 1000)
  expect_equal(vctrs::vec_data(fr_number(nums, name = "score")), nums)
  c("21%", NA, "44.45%", "85%") |>
    fr_number(name = "score", parse = TRUE) |>
    vctrs::vec_data() |>
    expect_equal(c(21, NA, 44.45, 85))
})
