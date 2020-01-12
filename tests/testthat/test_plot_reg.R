context("Plot Regression")

library(podlover)

# prepare for tests
t_exmpl <- t_exmpl


### no gvar ###

data1 <- podlove_downloads_until(t_exmpl, 30)

g1 <- podlove_graph_regression(df_regression_data = data1, 
															 predictor = post_datehour, 
															 plot_type = "line", 
															 regline = TRUE, 
															 ribbon = TRUE, 
															 stylize = TRUE, 
															 printout = FALSE)

g2 <- podlove_graph_regression(df_regression_data = data1, 
															 predictor = post_datehour, 
															 plot_type = "point", 
															 regline = TRUE, 
															 ribbon = TRUE, 
															 stylize = TRUE, 
															 printout = FALSE)

g3 <- podlove_graph_regression(df_regression_data = data1, 
															 predictor = post_datehour, 
															 plot_type = "area", 
															 regline = TRUE, 
															 ribbon = TRUE, 
															 stylize = TRUE, 
															 printout = FALSE)

g4 <- podlove_graph_regression(df_regression_data = data1, 
															 predictor = post_datehour, 
															 plot_type = "line", 
															 regline = FALSE, 
															 ribbon = TRUE, 
															 stylize = TRUE, 
															 printout = FALSE)

g5 <- podlove_graph_regression(df_regression_data = data1, 
															 predictor = post_datehour, 
															 plot_type = "line", 
															 regline = TRUE, 
															 ribbon = FALSE, 
															 stylize = TRUE, 
															 printout = FALSE)

g6 <- podlove_graph_regression(df_regression_data = data1, 
															 predictor = post_datehour, 
															 plot_type = "line", 
															 regline = TRUE, 
															 ribbon = TRUE, 
															 stylize = FALSE, 
															 printout = FALSE)
																		
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
	
	vdiffr::expect_doppelganger("Regression Line",  g1)
	vdiffr::expect_doppelganger("Regression Point",  g2)
	vdiffr::expect_doppelganger("Regression Area",  g3)
	vdiffr::expect_doppelganger("Regression no regline",  g4)
	vdiffr::expect_doppelganger("Regression no ribbon",  g5)
	vdiffr::expect_doppelganger("Regression no styling",  g6)
	
})

# cleanup
rm(t_exmpl, data1)
rm(list = ls(pat = "g1?[0-9]"))