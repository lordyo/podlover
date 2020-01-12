context("Regression data")

library(podlover)

# prepare for tests

t_exmpl <- t_exmpl

t_du <- podlove_downloads_until(df_tidy_data = t_exmpl, 
																points_in_time = 30,
																time_unit = "days")

t_du_downloads <- c(360L, 446L, 518L, 500L, 393L, 243L, 197L, 171L, 103L, 73L)

t_reg <- podlove_episode_regression(df_regression_data = t_du, 
																		terms = "post_datehour", 
																		printout = FALSE)

t_reg_coef <- c(`(Intercept)` = 19627.1733794963, post_datehour = -1.23672138299875e-05)

# tests
test_that("downloads_until data has the right dimensions", {
	
	expect_equal(ncol(t_du), 12)
	expect_equal(nrow(t_du), 10)
	
})

test_that("downloads_until data has the right colnames", {
	
	cnam <- function(df, i) {
		nams <- colnames(df)
		
		nams[i]
	}
	
	expect_equal(cnam(t_du, 1), "ep_number")
	expect_equal(cnam(t_du, 2), "title")
	expect_equal(cnam(t_du, 3), "ep_num_title")
	expect_equal(cnam(t_du, 4), "duration")
	expect_equal(cnam(t_du, 5), "post_date")
	expect_equal(cnam(t_du, 6), "post_datehour")
	expect_equal(cnam(t_du, 7), "ep_age_hours")
	expect_equal(cnam(t_du, 8), "ep_age_days")
	expect_equal(cnam(t_du, 9), "ep_rank")
	expect_equal(cnam(t_du, 10), "measure_day")
	expect_equal(cnam(t_du, 11), "measure_hour")
	expect_equal(cnam(t_du, 12), "downloads")
	
})

test_that("downloads_until data has the right col classes", {
	
	expect_is(t_du$ep_number, "character")
	expect_is(t_du$title, "character")
	expect_is(t_du$ep_num_title, "character")
	expect_is(t_du$duration, "numeric")
	expect_is(t_du$post_date, "Date")
	expect_is(t_du$post_datehour, "POSIXct")
	expect_is(t_du$ep_age_hours, "numeric")
	expect_is(t_du$ep_age_days, "numeric")
	expect_is(t_du$ep_rank, "integer")
	expect_is(t_du$measure_day, "numeric")
	expect_is(t_du$measure_hour, "numeric")
	expect_is(t_du$downloads, "integer")
	
})

test_that("downloads_until data has the right values", {
	
	expect_equal(t_du$downloads, t_du_downloads)
	
})

test_that("regression model is lm", {
	
	expect_is(t_reg, "lm")
	
})

test_that("regression model coefficients are correct", {
	
	expect_equal(t_reg$coefficients, t_reg_coef)
	
})

# cleanup
rm(t_exmpl, t_du, t_du_downloads, t_reg_coef, t_reg)
