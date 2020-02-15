context("Plot Regression")

library(podlover)

# prepare for tests
t_exmpl <- t_exmpl

# create plots
g1 <- podlove_plot_regression(df_tidy_data = t_exmpl, 
															 point_in_time = 30, predictor = post_datehour, 
															 plot_type = "line", 
															 regline = TRUE, 
															 ribbon = TRUE, 
															 stylize = TRUE, 
															 print_model = FALSE, print_plot = FALSE)

g2 <- podlove_plot_regression(df_tidy_data = t_exmpl, 
															 point_in_time = 30, predictor = post_datehour, 
															 plot_type = "point", 
															 regline = TRUE, 
															 ribbon = TRUE, 
															 stylize = TRUE, 
															 print_model = FALSE, print_plot = FALSE)

g3 <- podlove_plot_regression(df_tidy_data = t_exmpl, 
															 point_in_time = 30, predictor = post_datehour, 
															 plot_type = "area", 
															 regline = TRUE, 
															 ribbon = TRUE, 
															 stylize = TRUE, 
															 print_model = FALSE, print_plot = FALSE)

g4 <- podlove_plot_regression(df_tidy_data = t_exmpl, 
															 point_in_time = 30, predictor = post_datehour, 
															 plot_type = "line", 
															 regline = FALSE, 
															 ribbon = TRUE, 
															 stylize = TRUE, 
															 print_model = FALSE, print_plot = FALSE)

g5 <- podlove_plot_regression(df_tidy_data = t_exmpl, 
															 point_in_time = 30, predictor = post_datehour, 
															 plot_type = "line", 
															 regline = TRUE, 
															 ribbon = FALSE, 
															 stylize = TRUE, 
															 print_model = FALSE, print_plot = FALSE)

g6 <- podlove_plot_regression(df_tidy_data = t_exmpl, 
															 point_in_time = 30, predictor = post_datehour, 
															 plot_type = "line", 
															 regline = TRUE, 
															 ribbon = TRUE, 
															 stylize = FALSE, 
															 print_model = FALSE, print_plot = FALSE)

# labels can't be tested due to jittering label positions
																		
# tests
test_that("plots are ggplot objects", {
	
	expect_is(g1, "ggplot")
	expect_is(g2, "ggplot")
	expect_is(g3, "ggplot")
	expect_is(g4, "ggplot")
	expect_is(g5, "ggplot")
	expect_is(g6, "ggplot")
	
})

test_that("plots look as expected", {

	os <- Sys.info()["sysname"]
	
	if (os == "Windows") {
		
		vdiffr::expect_doppelganger("Win Regression Line",  g1)
		vdiffr::expect_doppelganger("Win Regression Point",  g2)
		vdiffr::expect_doppelganger("Win Regression Area",  g3)
		vdiffr::expect_doppelganger("Win Regression no regline",  g4)
		vdiffr::expect_doppelganger("Win Regression no ribbon",  g5)
		vdiffr::expect_doppelganger("Win Regression no styling",  g6)
	
	} else if (os == "Linux") {
		
		vdiffr::expect_doppelganger("Linux Regression Line",  g1)
		vdiffr::expect_doppelganger("Linux Regression Point",  g2)
		vdiffr::expect_doppelganger("Linux Regression Area",  g3)
		vdiffr::expect_doppelganger("Linux Regression no regline",  g4)
		vdiffr::expect_doppelganger("Linux Regression no ribbon",  g5)
		vdiffr::expect_doppelganger("Linux Regression no styling",  g6)
		
	}
	
})

# cleanup
rm(t_exmpl)
rm(list = ls(pat = "g1?[0-9]"))