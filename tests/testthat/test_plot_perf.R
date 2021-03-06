context("Plot Performance")

library(podlover)

# prepare for tests
t_exmpl <- t_exmpl

### no gvar ###

data1 <- podlove_performance_stats(df_tidy_data = t_exmpl, 
																	 launch = 3, 
																	 post_launch = 7, 
																	 limit_unit = "days")

g1 <- podlove_graph_performance(data1, printout = FALSE)

g2 <- podlove_plot_performance(t_exmpl, printout = FALSE)

# test labels and legends
g3 <- podlove_graph_performance(data1, label = title, printout = FALSE)

g4 <- podlove_graph_performance(data1, 
																label = ep_number, legend = title,
																printout = FALSE)

g5 <- podlove_plot_performance(t_exmpl, label = title, printout = FALSE)

g6 <- podlove_plot_performance(t_exmpl, label = ep_number, legend = title,
															 printout = FALSE)
																		
test_that("plots are ggplot objects", {
	
	expect_is(g1, "ggplot")
	expect_is(g2, "ggplot")
	expect_is(g3, "ggplot")
	expect_is(g4, "gtable")
	expect_is(g5, "ggplot")
	expect_is(g6, "gtable")
	
})

test_that("plots look as expected", {
	
	os <- Sys.info()["sysname"]
	
	if (os == "Windows") {
	
		vdiffr::expect_doppelganger("Win Performance Plot",  g1)
		vdiffr::expect_doppelganger("Win Wrap Performance Plot",  g2)
		
	} else if (os == "Linux") {
		
		vdiffr::expect_doppelganger("Linux Performance Plot",  g1)
		vdiffr::expect_doppelganger("Linux Wrap Performance Plot",  g2)
	}
	
})

# cleanup
rm(t_exmpl, data1)
rm(list = ls(pat = "g[0-9]"))