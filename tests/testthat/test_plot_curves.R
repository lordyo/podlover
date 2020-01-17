context("Plot Curves")

library(podlover)

# prepare for tests
t_exmpl <- t_exmpl


### no gvar ###

data1 <- podlove_prepare_stats_for_graph(t_exmpl, 
																				 hourly = FALSE, 
																				 relative = TRUE)

data2 <- podlove_prepare_stats_for_graph(t_exmpl, 
																				 hourly = FALSE, 
																				 relative = FALSE)

data3 <- podlove_prepare_stats_for_graph(t_exmpl, 
																				 hourly = TRUE, 
																				 relative = TRUE)

data4 <- podlove_prepare_stats_for_graph(t_exmpl, 
																				 hourly = TRUE, 
																				 relative = FALSE)

g1 <- podlove_graph_download_curves(data1,
																		cumulative = TRUE,
																		plot_type = "line",
																		printout = FALSE)
																		
g2 <- podlove_graph_download_curves(data1,
																		cumulative = FALSE,
																		plot_type = "line",
																		printout = FALSE)

g3 <- podlove_graph_download_curves(data2,
																		cumulative = TRUE,
																		plot_type = "line",
																		printout = FALSE)
																		
g4 <- podlove_graph_download_curves(data2,
																		cumulative = FALSE,
																		plot_type = "line",
																		printout = FALSE)

g5 <- podlove_graph_download_curves(data3,
																		cumulative = TRUE,
																		plot_type = "line",
																		printout = FALSE)
																		
g6 <- podlove_graph_download_curves(data3,
																		cumulative = FALSE,
																		plot_type = "line",
																		printout = FALSE)

g7 <- podlove_graph_download_curves(data4,
																		cumulative = TRUE,
																		plot_type = "line",
																		printout = FALSE)
																		
g8 <- podlove_graph_download_curves(data4,
																		cumulative = FALSE,
																		plot_type = "line",
																		printout = FALSE)
																	
### gvar = title ###
data5 <- podlove_prepare_stats_for_graph(t_exmpl,
																				 gvar = title,
																				 hourly = FALSE, 
																				 relative = TRUE)

data6 <- podlove_prepare_stats_for_graph(t_exmpl, 
																				 gvar = title,
																				 hourly = FALSE, 
																				 relative = FALSE)

data7 <- podlove_prepare_stats_for_graph(t_exmpl, 
																				 gvar = title,
																				 hourly = TRUE, 
																				 relative = TRUE)

data8 <- podlove_prepare_stats_for_graph(t_exmpl, 
																				 gvar = title,
																				 hourly = TRUE, 
																				 relative = FALSE)

g9 <- podlove_graph_download_curves(data5,
																		gvar = title,
																		cumulative = TRUE,
																		plot_type = "line",
																		printout = FALSE)

g10 <- podlove_graph_download_curves(data5,
																		gvar = title,
																		cumulative = FALSE,
																		plot_type = "line",
																		printout = FALSE)

g11 <- podlove_graph_download_curves(data6,
																		gvar = title,
																		cumulative = TRUE,
																		plot_type = "line",
																		printout = FALSE)

g12 <- podlove_graph_download_curves(data6,
																		gvar = title,
																		cumulative = FALSE,
																		plot_type = "line",
																		printout = FALSE)

g13 <- podlove_graph_download_curves(data7,
																		gvar = title,
																		cumulative = TRUE,
																		plot_type = "line",
																		printout = FALSE)

g14 <- podlove_graph_download_curves(data7,
																		gvar = title,
																		cumulative = FALSE,
																		plot_type = "line",
																		printout = FALSE)

g15 <- podlove_graph_download_curves(data8,
																		gvar = title,
																		cumulative = TRUE,
																		plot_type = "line",
																		printout = FALSE)

g16 <- podlove_graph_download_curves(data8,
																		gvar = title,
																		cumulative = FALSE,
																		plot_type = "line",
																		printout = FALSE)

### plot wrapper 

g17 <- podlove_plot_curves(dldata = t_exmpl, 
													 hourly = TRUE, 
													 relative = TRUE, 
													 cumulative = TRUE, 
													 plot_type = "line", 
													 printout = FALSE)

g18 <- podlove_plot_curves(dldata = t_exmpl, 
													 hourly = TRUE, 
													 relative = FALSE, 
													 cumulative = TRUE, 
													 plot_type = "line", 
													 printout = FALSE)

g19 <- podlove_plot_curves(dldata = t_exmpl, 
													 hourly = FALSE, 
													 relative = TRUE, 
													 cumulative = TRUE, 
													 plot_type = "line", 
													 printout = FALSE)

g20 <- podlove_plot_curves(dldata = t_exmpl, 
													 hourly = FALSE, 
													 relative = FALSE, 
													 cumulative = TRUE, 
													 plot_type = "line", 
													 printout = FALSE)

g21 <- podlove_plot_curves(dldata = t_exmpl, 
													 hourly = TRUE, 
													 relative = TRUE, 
													 cumulative = FALSE, 
													 plot_type = "line", 
													 printout = FALSE)

g22 <- podlove_plot_curves(dldata = t_exmpl, 
													 hourly = TRUE, 
													 relative = FALSE, 
													 cumulative = FALSE, 
													 plot_type = "line", 
													 printout = FALSE)

g23 <- podlove_plot_curves(dldata = t_exmpl, 
													 hourly = FALSE, 
													 relative = TRUE, 
													 cumulative = FALSE, 
													 plot_type = "line", 
													 printout = FALSE)

g24 <- podlove_plot_curves(dldata = t_exmpl, 
													 hourly = FALSE, 
													 relative = FALSE, 
													 cumulative = FALSE, 
													 plot_type = "line", 
													 printout = FALSE)

g25 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = TRUE, 
													 relative = TRUE, 
													 cumulative = TRUE, 
													 plot_type = "line", 
													 printout = FALSE)

g26 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = TRUE, 
													 relative = FALSE, 
													 cumulative = TRUE, 
													 plot_type = "line", 
													 printout = FALSE)

g27 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = FALSE, 
													 relative = TRUE, 
													 cumulative = TRUE, 
													 plot_type = "line", 
													 printout = FALSE)

g28 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = FALSE, 
													 relative = FALSE, 
													 cumulative = TRUE, 
													 plot_type = "line", 
													 printout = FALSE)

g29 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = TRUE, 
													 relative = TRUE, 
													 cumulative = FALSE, 
													 plot_type = "line", 
													 printout = FALSE)

g30 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = TRUE, 
													 relative = FALSE, 
													 cumulative = FALSE, 
													 plot_type = "line", 
													 printout = FALSE)

g31 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = FALSE, 
													 relative = TRUE, 
													 cumulative = FALSE, 
													 plot_type = "line", 
													 printout = FALSE)

g32 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = FALSE, 
													 relative = FALSE, 
													 cumulative = FALSE, 
													 plot_type = "line", 
													 printout = FALSE)

# tests
test_that("plots are ggplot objects", {
	
	expect_is(g1, "ggplot")
	expect_is(g2, "ggplot")
	expect_is(g3, "ggplot")
	expect_is(g4, "ggplot")
	expect_is(g5, "ggplot")
	expect_is(g6, "ggplot")
	expect_is(g7, "ggplot")
	expect_is(g9, "ggplot")
	expect_is(g10, "ggplot")
	expect_is(g11, "ggplot")
	expect_is(g12, "ggplot")
	expect_is(g13, "ggplot")
	expect_is(g14, "ggplot")
	expect_is(g15, "ggplot")
	expect_is(g16, "ggplot")
	expect_is(g17, "ggplot")
	expect_is(g18, "ggplot")
	expect_is(g19, "ggplot")
	expect_is(g20, "ggplot")
	expect_is(g21, "ggplot")
	expect_is(g22, "ggplot")
	expect_is(g23, "ggplot")
	expect_is(g24, "ggplot")
	expect_is(g25, "ggplot")
	expect_is(g26, "ggplot")
	expect_is(g27, "ggplot")
	expect_is(g28, "ggplot")
	expect_is(g29, "ggplot")
	expect_is(g30, "ggplot")
	expect_is(g31, "ggplot")
	expect_is(g32, "ggplot")
	
})

test_that("plots look as expected", {
	
	vdiffr::expect_doppelganger("Total DL day rel cum line",  g1)
	vdiffr::expect_doppelganger("Total DL day rel ncum line", g2)
	vdiffr::expect_doppelganger("Total DL day abs cum line",  g3)
	vdiffr::expect_doppelganger("Total DL day abs ncum line", g4)
	vdiffr::expect_doppelganger("Total DL hou rel cum line",  g5)
	vdiffr::expect_doppelganger("Total DL hou rel ncum line", g6)
	vdiffr::expect_doppelganger("Total DL hou abs cum line",  g7)
	vdiffr::expect_doppelganger("Total DL hou abs ncum line", g8)
	
	vdiffr::expect_doppelganger("title DL day rel cum line",  g9)
	vdiffr::expect_doppelganger("title DL day rel ncum line", g10)
	vdiffr::expect_doppelganger("title DL day abs cum line",  g11)
	vdiffr::expect_doppelganger("title DL day abs ncum line", g12)
	vdiffr::expect_doppelganger("title DL hou rel cum line",  g13)
	vdiffr::expect_doppelganger("title DL hou rel ncum line", g14)
	vdiffr::expect_doppelganger("title DL hou abs cum line",  g15)
	vdiffr::expect_doppelganger("title DL hou abs ncum line", g16)
	
	vdiffr::expect_doppelganger("Wrap Total DL day rel cum line",  g17)	
	vdiffr::expect_doppelganger("Wrap Total DL day rel ncum line", g18)
	vdiffr::expect_doppelganger("Wrap Total DL day abs cum line",  g19)
	vdiffr::expect_doppelganger("Wrap Total DL day abs ncum line", g20)
	vdiffr::expect_doppelganger("Wrap Total DL hou rel cum line",  g21)
	vdiffr::expect_doppelganger("Wrap Total DL hou rel ncum line", g22)
	vdiffr::expect_doppelganger("Wrap Total DL hou abs cum line",  g23)
	vdiffr::expect_doppelganger("Wrap Total DL hou abs ncum line", g24)
	
	vdiffr::expect_doppelganger("Wrap title DL day rel cum line",  g25)
	vdiffr::expect_doppelganger("Wrap title DL day rel ncum line", g26)
	vdiffr::expect_doppelganger("Wrap title DL day abs cum line",  g27)
	vdiffr::expect_doppelganger("Wrap title DL day abs ncum line", g28)
	vdiffr::expect_doppelganger("Wrap title DL hou rel cum line",  g29)
	vdiffr::expect_doppelganger("Wrap title DL hou rel ncum line", g30)
	vdiffr::expect_doppelganger("Wrap title DL hou abs cum line",  g31)
	vdiffr::expect_doppelganger("Wrap title DL hou abs ncum line", g32)
})

# cleanup
rm(t_exmpl, data1)
rm(list = ls(pat = "g1?[0-9]"))
