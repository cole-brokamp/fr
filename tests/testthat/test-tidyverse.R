test_that("fr_mutate works", {
  d <- read_fr_tdr(test_path("hamilton_poverty_2020"))

  d_new <-
    fr_mutate(d,
      noise = rnorm(226),
      more_noise = noise + fraction_poverty
    )
  expect_s3_class(d_new, "fr_tdr")
  expect_identical(
    names(d_new),
    c("census_tract_id_2020", "year", "fraction_poverty", "noise", "more_noise")
  )
  expect_identical(d_new@schema@fields$noise@name, "noise")
  expect_identical(d_new@schema@fields$more_noise@name, "more_noise")
})

test_that("fr_select works", {
  d <- read_fr_tdr(test_path("hamilton_poverty_2020"))

  d_new <-
    fr_select(d, -year)
  expect_s3_class(d_new, "fr_tdr")
  expect_identical(
    names(d_new),
    c("census_tract_id_2020", "fraction_poverty")
  )
  expect_identical(d_new@schema@fields$year, NULL)
})

test_that("fr_rename works", {
  d <- read_fr_tdr(test_path("hamilton_poverty_2020"))

  d_new <-
    fr_rename(d,
      the_year = year
    )
  expect_s3_class(d_new, "fr_tdr")
  expect_identical(
    names(d_new),
    c("census_tract_id_2020", "the_year", "fraction_poverty")
  )
  expect_identical(d_new@schema@fields$the_year@name, "the_year")
})

test_that("fr_filter works", {
  d <- read_fr_tdr(test_path("hamilton_poverty_2020"))
  d_new <- fr_filter(d, fraction_poverty > median(fraction_poverty))
  expect_s3_class(d_new, "fr_tdr")
  expect_equal(nrow(d_new), 113)
})

test_that("fr_summarize works", {
  d <- read_fr_tdr(test_path("hamilton_poverty_2020"))
  d_new <- fr_summarize(d, median_poverty_fraction = median(fraction_poverty))
  expect_s3_class(d_new, "fr_tdr")
  expect_equal(nrow(d_new), 1)
  expect_identical(names(d_new), "median_poverty_fraction")
  expect_identical(d_new@schema@fields$median_poverty_fraction@name,
                   "median_poverty_fraction")
})

test_that("fr_arrange works", {
  d <- read_fr_tdr(test_path("hamilton_poverty_2020"))
  d_new <- fr_arrange(d, desc(fraction_poverty))
  expect_s3_class(d_new, "fr_tdr")
  expect_equal(d_new$census_tract_id_2020[[1]], "39061008502")
})
