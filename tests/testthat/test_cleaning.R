context("Cleaning")

library(podlover)

t_exmpl <- podlove_create_example(seed = 1)

t_clean <- podlove_clean_stats(df_stats = t_exmpl$downloads, 
																 df_mediafile = t_exmpl$mediafiles, 
																 df_user = t_exmpl$useragents,
																 df_episodes = t_exmpl$episodes,
																 df_posts = t_exmpl$posts) 

t_cn <- colnames(t_clean)

test_that("clean_stats returns a dataframe", {
	expect_is(t_clean, "data.frame")
})

test_that("clean_stats returns correct dimensions", {
	expect_equal(ncol(t_clean), 20)
	expect_equal(nrow(t_clean), 4310)
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

rm(t_exmpl, t_clean, t_cn)