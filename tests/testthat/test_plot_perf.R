context("Plot Performance")

library(podlover)

# prepare for tests
t_exmpl <- t_exmpl


### no gvar ###

data1 <- podlove_performance_stats(df_tidy_data = t_exmpl, 
																	 launch = 3, 
																	 post_launch = 7, 
																	 limit_unit = "days")

g1 <- podlove_graph_performance(data1, label = FALSE, printout = FALSE)

g2 <- podlove_plot_performance(t_exmpl, label = FALSE, printout = FALSE)
																		
# tests
test_that("plots are ggplot objects", {
	
	expect_is(g1, "ggplot")
	expect_is(g2, "ggplot")
	
})

test_that("plots look as expected", {
	
	os <- Sys.info()["sysname"]
	
	if (os == "Windows") {
	
		vdiffr::expect_doppelganger("Win Performance Plot",  g1)
		vdiffr::expect_doppelganger("Win Wrap Performance Plot",  g2)
		
	} else if (os == "Unix") {
		
		vdiffr::expect_doppelganger("Linux Performance Plot",  g1)
		vdiffr::expect_doppelganger("Linux Wrap Performance Plot",  g2)
	}
	
})

# cleanup
rm(t_exmpl, data1)
rm(list = ls(pat = "g[0-9]"))