context("Podcast summary")

library(podlover)

# prepare for tests
t_exmpl <- t_exmpl

t_sum_param <- podlove_podcast_summary(t_exmpl, verbose = FALSE, return_params = TRUE)

t_sum_p_correct <-
	list(
		n_episodes = 10,
		ep_first_date = structure(
			1546297200,
			class = c("POSIXct",
								"POSIXt"),
			tzone = "UTC"
		),
		ep_last_date = structure(
			1577836800,
			class = c("POSIXct",
								"POSIXt"),
			tzone = "UTC"
		),
		runtime = new(
			"Period",
			.Data = 0,
			year = 1L,
			month = 0L,
			day = 0,
			hour = 1L,
			minute = 0L
		),
		ep_interval = new("Duration", .Data = 3153960),
		n_downloads = 4310L,
		dl_first_date = structure(
			1546297200,
			class = c("POSIXct",
								"POSIXt"),
			tzone = "UTC"
		),
		dl_last_date = structure(
			1580428800,
			class = c("POSIXct",
								"POSIXt"),
			tzone = "UTC"
		),
		downloads_per_episode_mean = 431,
		downloads_per_episode_5num = c(73, 200, 432.5, 674, 763),
		downloads_per_day_mean = 10.910241535703,
		downloads_per_day_5num = c(1,
															 2, 5, 9, 356)
	)

# tests
test_that("summary returns correct number of parameters", {
	
	expect_equal(length(t_sum_param), 12)
	
})

test_that("summary returns correct classes", {
	
	expect_is(t_sum_param$n_episodes, "numeric")
	expect_is(t_sum_param$ep_first_date, "POSIXct")
	expect_is(t_sum_param$ep_last_date, "POSIXct")
	expect_is(t_sum_param$runtime, "Period")
	expect_is(t_sum_param$ep_interval, "Duration")
	expect_is(t_sum_param$n_downloads, "integer")
	expect_is(t_sum_param$dl_first_date, "POSIXct")
	expect_is(t_sum_param$dl_last_date, "POSIXct")
	expect_is(t_sum_param$downloads_per_episode_mean, "numeric")
	expect_is(t_sum_param$downloads_per_episode_5num, "numeric")
	expect_is(t_sum_param$downloads_per_day_mean, "numeric")
	expect_is(t_sum_param$downloads_per_day_5num, "numeric")
	
})

test_that("summary returns correct values", {
	
	expect_equal(t_sum_param, t_sum_p_correct)
	
})

# cleanup
rm(t_exmpl, t_sum_param, t_sum_p_correct)
