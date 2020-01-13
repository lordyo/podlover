context("Cleaning")

library(podlover)

t_exmpl_list <- t_exmpl_list

t_clean <- podlove_clean_stats(df_stats = t_exmpl_list$downloads, 
															 df_mediafile = t_exmpl_list$mediafiles, 
															 df_user = t_exmpl_list$useragents,
															 df_episodes = t_exmpl_list$episodes,
															 df_posts = t_exmpl_list$posts) 

t_clean_ld <- podlove_clean_stats(df_stats = t_exmpl_list$downloads, 
																	df_mediafile = t_exmpl_list$mediafiles, 
																	df_user = t_exmpl_list$useragents,
																	df_episodes = t_exmpl_list$episodes,
																	df_posts = t_exmpl_list$posts,
																	launch_date = "2019-10-14") 

t_cn <- colnames(t_clean)

test_that("clean_stats returns a dataframe", {
	expect_is(t_clean, "data.frame")
})

test_that("clean_stats returns correct dimensions", {
	expect_equal(ncol(t_clean), 20)
	expect_equal(nrow(t_clean), 5140)
	expect_equal(nrow(t_clean_ld), 1188) # launchdate filter works
})

test_that("clean_stats has the correct column names", {
	expect_equal(t_cn[1], "ep_number")
	expect_equal(t_cn[2], "title")
	expect_equal(t_cn[3], "ep_num_title")
	expect_equal(t_cn[4], "duration")
	expect_equal(t_cn[5], "post_date")
	expect_equal(t_cn[6], "post_datehour")
	expect_equal(t_cn[7], "ep_age_hours")
	expect_equal(t_cn[8], "ep_age_days")
	expect_equal(t_cn[9], "hours_since_release")
	expect_equal(t_cn[10], "days_since_release")
	expect_equal(t_cn[11], "source")
	expect_equal(t_cn[12], "context")
	expect_equal(t_cn[13], "dldate")
	expect_equal(t_cn[14], "dldatehour")
	expect_equal(t_cn[15], "weekday")
	expect_equal(t_cn[16], "hour")
	expect_equal(t_cn[17], "client_name")
	expect_equal(t_cn[18], "client_type")
	expect_equal(t_cn[19], "os_name")
	expect_equal(t_cn[20], "dl_attempts")
})

test_that("clean_stats has the correct column class", {
	expect_is(t_clean$ep_number, "character")
	expect_is(t_clean$title, "character")
	expect_is(t_clean$ep_num_title, "character")
	expect_is(t_clean$duration, "Duration")
	expect_is(t_clean$post_date, "Date")
	expect_is(t_clean$post_datehour, "POSIXct")
	expect_is(t_clean$ep_age_hours, "numeric")
	expect_is(t_clean$ep_age_days, "numeric")
	expect_is(t_clean$hours_since_release, "numeric")
	expect_is(t_clean$days_since_release, "numeric")
	expect_is(t_clean$source, "character")
	expect_is(t_clean$context, "character")
	expect_is(t_clean$dldate, "Date")
	expect_is(t_clean$dldatehour, "POSIXct")
	expect_is(t_clean$weekday, "factor")
	expect_is(t_clean$hour, "integer")
	expect_is(t_clean$client_name, "character")
	expect_is(t_clean$client_type, "character")
	expect_is(t_clean$os_name, "character")
	expect_is(t_clean$dl_attempts, "integer")
})

rm(t_exmpl_list, t_clean, t_clean_ld, t_cn)