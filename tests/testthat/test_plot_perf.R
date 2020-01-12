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
																		
# tests
test_that("plots are ggplot objects", {
	
	expect_is(g1, "ggplot")
	
})

test_that("plots look as expected", {
	
	vdiffr::expect_doppelganger("Performance Plot",  g1)
	
})

# cleanup
rm(t_exmpl, data1)
rm(list = ls(pat = "g1?[0-9]"))