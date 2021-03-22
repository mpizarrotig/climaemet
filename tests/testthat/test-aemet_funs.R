skip_if_no_apikey <- function() {
  if (!identical(Sys.getenv("AEMET_API_KEY"), "")) {
    return(invisible(TRUE))
  }

  skip("No AEMET API Key provided")
}

apikey <- Sys.getenv("AEMET_API_KEY")

test_that("aemet_last_obs working", {
  skip_if_no_apikey()

  expect_error(aemet_last_obs(apikey = apikey))
  expect_error(aemet_last_obs("9434"))

  expect_silent(aemet_last_obs("9434", apikey))
})

test_that("aemet_stations working", {
  skip_if_no_apikey()

  expect_silent(aemet_stations(apikey))
})

test_that("aemet_normal_* working", {
  skip_if_no_apikey()

  expect_error(aemet_normal_clim(apikey = apikey))
  expect_error(aemet_normal_clim("9434"))

  expect_silent(aemet_normal_clim("9434", apikey))
})

test_that("aemet_daily_* working", {
  skip_if_no_apikey()

  expect_error(aemet_daily_clim(apikey = apikey))
  expect_error(aemet_daily_clim("9434", apikey = apikey))
  expect_error(aemet_daily_clim("9434", apikey = apikey, start = "2020-01-01"))

  expect_silent(aemet_daily_clim("9434", apikey, start = "2020-01-01", end = "2020-01-02"))
  expect_visible(aemet_daily_period("9434", apikey, start = 2020, end = 2020))
})

test_that("aemet_monthly_* working", {
  skip_if_no_apikey()

  expect_silent(aemet_monthly_clim("9434", apikey, year = 2020))
  expect_visible(aemet_monthly_period("9434", apikey, 2020, 2020))
})


test_that("aemet_extremes_clim working", {
  skip_if_no_apikey()
  expect_error(aemet_extremes_clim("9434"))
  expect_error(aemet_extremes_clim(apikey = apikey))
  expect_error(aemet_extremes_clim("9434", apikey, 1))


  expect_silent(aemet_extremes_clim("9434", apikey, "T"))
})
