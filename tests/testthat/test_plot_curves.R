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
													 limit = TRUE, 
													 printout = FALSE)

g18 <- podlove_plot_curves(dldata = t_exmpl, 
													 hourly = TRUE, 
													 relative = FALSE, 
													 cumulative = TRUE, 
													 plot_type = "line", 
													 limit = TRUE, 
													 printout = FALSE)

g19 <- podlove_plot_curves(dldata = t_exmpl, 
													 hourly = FALSE, 
													 relative = TRUE, 
													 cumulative = TRUE, 
													 plot_type = "line", 
													 limit = TRUE, 
													 printout = FALSE)

g20 <- podlove_plot_curves(dldata = t_exmpl, 
													 hourly = FALSE, 
													 relative = FALSE, 
													 cumulative = TRUE, 
													 plot_type = "line", 
													 limit = TRUE, 
													 printout = FALSE)

g21 <- podlove_plot_curves(dldata = t_exmpl, 
													 hourly = TRUE, 
													 relative = TRUE, 
													 cumulative = FALSE, 
													 plot_type = "line", 
													 limit = TRUE, 
													 printout = FALSE)

g22 <- podlove_plot_curves(dldata = t_exmpl, 
													 hourly = TRUE, 
													 relative = FALSE, 
													 cumulative = FALSE, 
													 plot_type = "line", 
													 limit = TRUE, 
													 printout = FALSE)

g23 <- podlove_plot_curves(dldata = t_exmpl, 
													 hourly = FALSE, 
													 relative = TRUE, 
													 cumulative = FALSE, 
													 plot_type = "line", 
													 limit = TRUE, 
													 printout = FALSE)

g24 <- podlove_plot_curves(dldata = t_exmpl, 
													 hourly = FALSE, 
													 relative = FALSE, 
													 cumulative = FALSE, 
													 plot_type = "line", 
													 limit = TRUE, 
													 printout = FALSE)

g25 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = TRUE, 
													 relative = TRUE, 
													 cumulative = TRUE, 
													 plot_type = "line", 
													 limit = TRUE, 
													 printout = FALSE)

g26 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = TRUE, 
													 relative = FALSE, 
													 cumulative = TRUE, 
													 plot_type = "line", 
													 limit = TRUE, 
													 printout = FALSE)

g27 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = FALSE, 
													 relative = TRUE, 
													 cumulative = TRUE, 
													 plot_type = "line", 
													 limit = TRUE,
													 printout = FALSE)

g28 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = FALSE, 
													 relative = FALSE, 
													 cumulative = TRUE, 
													 plot_type = "line", 
													 limit = TRUE, 
													 printout = FALSE)

g29 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = TRUE, 
													 relative = TRUE, 
													 cumulative = FALSE, 
													 plot_type = "line", 
													 limit = TRUE, 
													 printout = FALSE)

g30 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = TRUE, 
													 relative = FALSE, 
													 cumulative = FALSE, 
													 plot_type = "line", 
													 limit = TRUE, 
													 printout = FALSE)

g31 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = FALSE, 
													 relative = TRUE, 
													 cumulative = FALSE, 
													 plot_type = "line", 
													 limit = TRUE, 
													 printout = FALSE)

g32 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = FALSE, 
													 relative = FALSE, 
													 cumulative = FALSE, 
													 plot_type = "line", 
													 limit = TRUE, 
													 printout = FALSE)

g33 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = TRUE, 
													 relative = TRUE, 
													 cumulative = TRUE, 
													 plot_type = "line",
													 sum_fun = mean, 
													 limit = TRUE, 
													 printout = FALSE)

g34 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = TRUE, 
													 relative = FALSE, 
													 cumulative = TRUE, 
													 plot_type = "line",
													 sum_fun = mean, 
													 limit = TRUE, 
													 printout = FALSE)

g35 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = FALSE, 
													 relative = TRUE, 
													 cumulative = TRUE, 
													 plot_type = "line",
													 sum_fun = mean, 
													 limit = TRUE, 
													 printout = FALSE)

g36 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = FALSE, 
													 relative = FALSE, 
													 cumulative = TRUE, 
													 plot_type = "line",
													 sum_fun = mean, 
													 limit = TRUE, 
													 printout = FALSE)

g37 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = TRUE, 
													 relative = TRUE, 
													 cumulative = FALSE, 
													 plot_type = "line",
													 sum_fun = mean, 
													 limit = TRUE, 
													 printout = FALSE)

g38 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = TRUE, 
													 relative = FALSE, 
													 cumulative = FALSE, 
													 plot_type = "line",
													 sum_fun = mean, 
													 limit = TRUE, 
													 printout = FALSE)

g39 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = FALSE, 
													 relative = TRUE, 
													 cumulative = FALSE, 
													 plot_type = "line",
													 sum_fun = mean, 
													 limit = TRUE, 
													 printout = FALSE)

g40 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = FALSE, 
													 relative = FALSE, 
													 cumulative = FALSE, 
													 plot_type = "line",
													 sum_fun = mean, 
													 limit = TRUE, 
													 printout = FALSE)

g41 <- podlove_plot_curves(dldata = t_exmpl, 
													 hourly = TRUE, 
													 relative = TRUE, 
													 cumulative = TRUE, 
													 plot_type = "line", 
													 limit = FALSE, last_n = -4, 
													 printout = FALSE)

g42 <- podlove_plot_curves(dldata = t_exmpl, 
													 hourly = TRUE, 
													 relative = FALSE, 
													 cumulative = TRUE, 
													 plot_type = "line", 
													 limit = FALSE, last_n = -4, 
													 printout = FALSE)

g43 <- podlove_plot_curves(dldata = t_exmpl, 
													 hourly = FALSE, 
													 relative = TRUE, 
													 cumulative = TRUE, 
													 plot_type = "line", 
													 limit = FALSE, last_n = -4, 
													 printout = FALSE)

g44 <- podlove_plot_curves(dldata = t_exmpl, 
													 hourly = FALSE, 
													 relative = FALSE, 
													 cumulative = TRUE, 
													 plot_type = "line", 
													 limit = FALSE, last_n = -4, 
													 printout = FALSE)

g45 <- podlove_plot_curves(dldata = t_exmpl, 
													 hourly = TRUE, 
													 relative = TRUE, 
													 cumulative = FALSE, 
													 plot_type = "line", 
													 limit = FALSE, last_n = -4, 
													 printout = FALSE)

g46 <- podlove_plot_curves(dldata = t_exmpl, 
													 hourly = TRUE, 
													 relative = FALSE, 
													 cumulative = FALSE, 
													 plot_type = "line", 
													 limit = FALSE, last_n = -4, 
													 printout = FALSE)

g47<- podlove_plot_curves(dldata = t_exmpl, 
													 hourly = FALSE, 
													 relative = TRUE, 
													 cumulative = FALSE, 
													 plot_type = "line", 
													 limit = FALSE, last_n = -4, 
													 printout = FALSE)

g48 <- podlove_plot_curves(dldata = t_exmpl, 
													 hourly = FALSE, 
													 relative = FALSE, 
													 cumulative = FALSE, 
													 plot_type = "line", 
													 limit = FALSE, last_n = -4, 
													 printout = FALSE)

g49 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = TRUE, 
													 relative = TRUE, 
													 cumulative = TRUE, 
													 plot_type = "line", 
													 limit = FALSE, last_n = -4, 
													 printout = FALSE)

g50 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = TRUE, 
													 relative = FALSE, 
													 cumulative = TRUE, 
													 plot_type = "line", 
													 limit = FALSE, last_n = -4, 
													 printout = FALSE)

g51 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = FALSE, 
													 relative = TRUE, 
													 cumulative = TRUE, 
													 plot_type = "line", 
													 limit = FALSE, last_n = -4,
													 printout = FALSE)

g52 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = FALSE, 
													 relative = FALSE, 
													 cumulative = TRUE, 
													 plot_type = "line", 
													 limit = FALSE, last_n = -4, 
													 printout = FALSE)

g53 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = TRUE, 
													 relative = TRUE, 
													 cumulative = FALSE, 
													 plot_type = "line", 
													 limit = FALSE, last_n = -4, 
													 printout = FALSE)

g54 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = TRUE, 
													 relative = FALSE, 
													 cumulative = FALSE, 
													 plot_type = "line", 
													 limit = FALSE, last_n = -4, 
													 printout = FALSE)

g55 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = FALSE, 
													 relative = TRUE, 
													 cumulative = FALSE, 
													 plot_type = "line", 
													 limit = FALSE, last_n = -4, 
													 printout = FALSE)

g56 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = FALSE, 
													 relative = FALSE, 
													 cumulative = FALSE, 
													 plot_type = "line", 
													 limit = FALSE, last_n = -4, 
													 printout = FALSE)

g57 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = TRUE, 
													 relative = TRUE, 
													 cumulative = TRUE, 
													 plot_type = "line",
													 sum_fun = mean, 
													 limit = FALSE, last_n = -4, 
													 printout = FALSE)

g58 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = TRUE, 
													 relative = FALSE, 
													 cumulative = TRUE, 
													 plot_type = "line",
													 sum_fun = mean, 
													 limit = FALSE, last_n = -4, 
													 printout = FALSE)

g59 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = FALSE, 
													 relative = TRUE, 
													 cumulative = TRUE, 
													 plot_type = "line",
													 sum_fun = mean, 
													 limit = FALSE, last_n = -4, 
													 printout = FALSE)

g60 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = FALSE, 
													 relative = FALSE, 
													 cumulative = TRUE, 
													 plot_type = "line",
													 sum_fun = mean, 
													 limit = FALSE, last_n = -4, 
													 printout = FALSE)

g61 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = TRUE, 
													 relative = TRUE, 
													 cumulative = FALSE, 
													 plot_type = "line",
													 sum_fun = mean, 
													 limit = FALSE, last_n = -4, 
													 printout = FALSE)

g62 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = TRUE, 
													 relative = FALSE, 
													 cumulative = FALSE, 
													 plot_type = "line",
													 sum_fun = mean, 
													 limit = FALSE, last_n = -4, 
													 printout = FALSE)

g63 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = FALSE, 
													 relative = TRUE, 
													 cumulative = FALSE, 
													 plot_type = "line",
													 sum_fun = mean, 
													 limit = FALSE, last_n = -4, 
													 printout = FALSE)

g64 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = FALSE, 
													 relative = FALSE, 
													 cumulative = FALSE, 
													 plot_type = "line",
													 sum_fun = mean, 
													 limit = FALSE, last_n = -4, 
													 printout = FALSE)

# labelsi

g65 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = FALSE, 
													 relative = TRUE, 
													 cumulative = TRUE, 
													 plot_type = "line",
													 sum_fun = mean, 
													 limit = TRUE, 
													 labelmethod = "last.points",
													 printout = FALSE)

g66 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = FALSE, 
													 relative = TRUE, 
													 cumulative = TRUE, 
													 plot_type = "line",
													 sum_fun = mean, 
													 limit = TRUE, 
													 labelmethod = "first.points",
													 printout = FALSE)

g67 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = FALSE, 
													 relative = TRUE, 
													 cumulative = TRUE, 
													 plot_type = "line",
													 sum_fun = mean, 
													 limit = TRUE, 
													 labelmethod = "angled.boxes",
													 printout = FALSE)

g68 <- podlove_plot_curves(dldata = t_exmpl, 
													 gvar = title, 
													 hourly = FALSE, 
													 relative = TRUE, 
													 cumulative = TRUE, 
													 plot_type = "line",
													 sum_fun = mean, 
													 limit = TRUE, 
													 labelmethod = "",
													 legend = TRUE,
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
	expect_is(g33, "ggplot")
	expect_is(g34, "ggplot")
	expect_is(g35, "ggplot")
	expect_is(g36, "ggplot")
	expect_is(g37, "ggplot")
	expect_is(g38, "ggplot")
	expect_is(g39, "ggplot")
	expect_is(g40, "ggplot")
	expect_is(g41, "ggplot")
	expect_is(g42, "ggplot")
	expect_is(g43, "ggplot")
	expect_is(g44, "ggplot")
	expect_is(g45, "ggplot")
	expect_is(g46, "ggplot")
	expect_is(g47, "ggplot")
	expect_is(g48, "ggplot")
	expect_is(g49, "ggplot")
	expect_is(g50, "ggplot")
	expect_is(g51, "ggplot")
	expect_is(g52, "ggplot")
	expect_is(g53, "ggplot")
	expect_is(g54, "ggplot")
	expect_is(g55, "ggplot")
	expect_is(g56, "ggplot")
	expect_is(g57, "ggplot")
	expect_is(g58, "ggplot")
	expect_is(g59, "ggplot")
	expect_is(g60, "ggplot")
	expect_is(g61, "ggplot")
	expect_is(g62, "ggplot")
	expect_is(g63, "ggplot")
	expect_is(g64, "ggplot")
	expect_is(g65, "ggplot")
	expect_is(g66, "ggplot")
	expect_is(g67, "ggplot")
	expect_is(g68, "ggplot")
})

test_that("plots look as expected", {
	
	os <- Sys.info()["sysname"]
	
	if (os == "Windows") {
	
	vdiffr::expect_doppelganger("Win Total DL day rel cum line",  g1)
	vdiffr::expect_doppelganger("Win Total DL day rel ncum line", g2)
	vdiffr::expect_doppelganger("Win Total DL day abs cum line",  g3)
	vdiffr::expect_doppelganger("Win Total DL day abs ncum line", g4)
	vdiffr::expect_doppelganger("Win Total DL hou rel cum line",  g5)
	vdiffr::expect_doppelganger("Win Total DL hou rel ncum line", g6)
	vdiffr::expect_doppelganger("Win Total DL hou abs cum line",  g7)
	vdiffr::expect_doppelganger("Win Total DL hou abs ncum line", g8)
	
	vdiffr::expect_doppelganger("Win title DL day rel cum line",  g9)
	vdiffr::expect_doppelganger("Win title DL day rel ncum line", g10)
	vdiffr::expect_doppelganger("Win title DL day abs cum line",  g11)
	vdiffr::expect_doppelganger("Win title DL day abs ncum line", g12)
	vdiffr::expect_doppelganger("Win title DL hou rel cum line",  g13)
	vdiffr::expect_doppelganger("Win title DL hou rel ncum line", g14)
	vdiffr::expect_doppelganger("Win title DL hou abs cum line",  g15)
	vdiffr::expect_doppelganger("Win title DL hou abs ncum line", g16)
	
	vdiffr::expect_doppelganger("Win Wrap Total DL day rel cum line lim",  g17)	
	vdiffr::expect_doppelganger("Win Wrap Total DL day rel ncum line lim", g18)
	vdiffr::expect_doppelganger("Win Wrap Total DL day abs cum line lim",  g19)
	vdiffr::expect_doppelganger("Win Wrap Total DL day abs ncum line lim", g20)
	vdiffr::expect_doppelganger("Win Wrap Total DL hou rel cum line lim",  g21)
	vdiffr::expect_doppelganger("Win Wrap Total DL hou rel ncum line lim", g22)
	vdiffr::expect_doppelganger("Win Wrap Total DL hou abs cum line lim",  g23)
	vdiffr::expect_doppelganger("Win Wrap Total DL hou abs ncum line lim", g24)
	
	vdiffr::expect_doppelganger("Win Wrap title DL day rel cum line lim",  g25)
	vdiffr::expect_doppelganger("Win Wrap title DL day rel ncum line lim", g26)
	vdiffr::expect_doppelganger("Win Wrap title DL day abs cum line lim",  g27)
	vdiffr::expect_doppelganger("Win Wrap title DL day abs ncum line lim", g28)
	vdiffr::expect_doppelganger("Win Wrap title DL hou rel cum line lim",  g29)
	vdiffr::expect_doppelganger("Win Wrap title DL hou rel ncum line lim", g30)
	vdiffr::expect_doppelganger("Win Wrap title DL hou abs cum line lim",  g31)
	vdiffr::expect_doppelganger("Win Wrap title DL hou abs ncum line lim", g32)
	
	vdiffr::expect_doppelganger("Win Wrap title DL day rel cum line sumfun lim",  g33)
	vdiffr::expect_doppelganger("Win Wrap title DL day rel ncum line sumfun lim", g34)
	vdiffr::expect_doppelganger("Win Wrap title DL day abs cum line sumfun lim",  g35)
	vdiffr::expect_doppelganger("Win Wrap title DL day abs ncum line sumfun lim", g36)
	vdiffr::expect_doppelganger("Win Wrap title DL hou rel cum line sumfun lim",  g37)
	vdiffr::expect_doppelganger("Win Wrap title DL hou rel ncum line sumfun lim", g38)
	vdiffr::expect_doppelganger("Win Wrap title DL hou abs cum line sumfun lim",  g39)
	vdiffr::expect_doppelganger("Win Wrap title DL hou abs ncum line sumfun lim", g40)

	vdiffr::expect_doppelganger("Win Wrap Total DL day rel cum line nolim",  g41)	
	vdiffr::expect_doppelganger("Win Wrap Total DL day rel ncum line nolim", g42)
	vdiffr::expect_doppelganger("Win Wrap Total DL day abs cum line nolim",  g43)
	vdiffr::expect_doppelganger("Win Wrap Total DL day abs ncum line nolim", g44)
	vdiffr::expect_doppelganger("Win Wrap Total DL hou rel cum line nolim",  g45)
	vdiffr::expect_doppelganger("Win Wrap Total DL hou rel ncum line nolim", g46)
	vdiffr::expect_doppelganger("Win Wrap Total DL hou abs cum line nolim",  g47)
	vdiffr::expect_doppelganger("Win Wrap Total DL hou abs ncum line nolim", g48)
	
	vdiffr::expect_doppelganger("Win Wrap title DL day rel cum line nolim",  g49)
	vdiffr::expect_doppelganger("Win Wrap title DL day rel ncum line nolim", g50)
	vdiffr::expect_doppelganger("Win Wrap title DL day abs cum line nolim",  g51)
	vdiffr::expect_doppelganger("Win Wrap title DL day abs ncum line nolim", g52)
	vdiffr::expect_doppelganger("Win Wrap title DL hou rel cum line nolim",  g53)
	vdiffr::expect_doppelganger("Win Wrap title DL hou rel ncum line nolim", g54)
	vdiffr::expect_doppelganger("Win Wrap title DL hou abs cum line nolim",  g55)
	vdiffr::expect_doppelganger("Win Wrap title DL hou abs ncum line nolim", g56)
	
	vdiffr::expect_doppelganger("Win Wrap title DL day rel cum line sumfun nolim",  g57)
	vdiffr::expect_doppelganger("Win Wrap title DL day rel ncum line sumfun nolim", g58)
	vdiffr::expect_doppelganger("Win Wrap title DL day abs cum line sumfun nolim",  g59)
	vdiffr::expect_doppelganger("Win Wrap title DL day abs ncum line sumfun nolim", g60)
	vdiffr::expect_doppelganger("Win Wrap title DL hou rel cum line sumfun nolim",  g61)
	vdiffr::expect_doppelganger("Win Wrap title DL hou rel ncum line sumfun nolim", g62)
	vdiffr::expect_doppelganger("Win Wrap title DL hou abs cum line sumfun nolim",  g63)
	vdiffr::expect_doppelganger("Win Wrap title DL hou abs ncum line sumfun nolim", g64)
	
	vdiffr::expect_doppelganger("Win lastpoints nolegend",  g65)
	vdiffr::expect_doppelganger("Win firstpoints nolegend", g66)
	vdiffr::expect_doppelganger("Win angledboxes nolegend",  g67)
	vdiffr::expect_doppelganger("Win nodirectlabels legend", g68)	
	vdiffr::expect_doppelganger("Win lastpoints nolegend",  g65)
	vdiffr::expect_doppelganger("Win firstpoints nolegend", g66)
	vdiffr::expect_doppelganger("Win angledboxes nolegend",  g67)
	vdiffr::expect_doppelganger("Win nodirectlabels legend", g68)
	
	} else if (os == "Linux") {
		
	vdiffr::expect_doppelganger("Linux Total DL day rel cum line",  g1)
	vdiffr::expect_doppelganger("Linux Total DL day rel ncum line", g2)
	vdiffr::expect_doppelganger("Linux Total DL day abs cum line",  g3)
	vdiffr::expect_doppelganger("Linux Total DL day abs ncum line", g4)
	vdiffr::expect_doppelganger("Linux Total DL hou rel cum line",  g5)
	vdiffr::expect_doppelganger("Linux Total DL hou rel ncum line", g6)
	vdiffr::expect_doppelganger("Linux Total DL hou abs cum line",  g7)
	vdiffr::expect_doppelganger("Linux Total DL hou abs ncum line", g8)
	
	vdiffr::expect_doppelganger("Linux title DL day rel cum line",  g9)
	vdiffr::expect_doppelganger("Linux title DL day rel ncum line", g10)
	vdiffr::expect_doppelganger("Linux title DL day abs cum line",  g11)
	vdiffr::expect_doppelganger("Linux title DL day abs ncum line", g12)
	vdiffr::expect_doppelganger("Linux title DL hou rel cum line",  g13)
	vdiffr::expect_doppelganger("Linux title DL hou rel ncum line", g14)
	vdiffr::expect_doppelganger("Linux title DL hou abs cum line",  g15)
	vdiffr::expect_doppelganger("Linux title DL hou abs ncum line", g16)
	
	vdiffr::expect_doppelganger("Linux Wrap Total DL day rel cum line lim",  g17)	
	vdiffr::expect_doppelganger("Linux Wrap Total DL day rel ncum line lim", g18)
	vdiffr::expect_doppelganger("Linux Wrap Total DL day abs cum line lim",  g19)
	vdiffr::expect_doppelganger("Linux Wrap Total DL day abs ncum line lim", g20)
	vdiffr::expect_doppelganger("Linux Wrap Total DL hou rel cum line lim",  g21)
	vdiffr::expect_doppelganger("Linux Wrap Total DL hou rel ncum line lim", g22)
	vdiffr::expect_doppelganger("Linux Wrap Total DL hou abs cum line lim",  g23)
	vdiffr::expect_doppelganger("Linux Wrap Total DL hou abs ncum line lim", g24)
	
	vdiffr::expect_doppelganger("Linux Wrap title DL day rel cum line lim",  g25)
	vdiffr::expect_doppelganger("Linux Wrap title DL day rel ncum line lim", g26)
	vdiffr::expect_doppelganger("Linux Wrap title DL day abs cum line lim",  g27)
	vdiffr::expect_doppelganger("Linux Wrap title DL day abs ncum line lim", g28)
	vdiffr::expect_doppelganger("Linux Wrap title DL hou rel cum line lim",  g29)
	vdiffr::expect_doppelganger("Linux Wrap title DL hou rel ncum line lim", g30)
	vdiffr::expect_doppelganger("Linux Wrap title DL hou abs cum line lim",  g31)
	vdiffr::expect_doppelganger("Linux Wrap title DL hou abs ncum line lim", g32)
	
	vdiffr::expect_doppelganger("Linux Wrap title DL day rel cum line sumfun lim",  g33)
	vdiffr::expect_doppelganger("Linux Wrap title DL day rel ncum line sumfun lim", g34)
	vdiffr::expect_doppelganger("Linux Wrap title DL day abs cum line sumfun lim",  g35)
	vdiffr::expect_doppelganger("Linux Wrap title DL day abs ncum line sumfun lim", g36)
	vdiffr::expect_doppelganger("Linux Wrap title DL hou rel cum line sumfun lim",  g37)
	vdiffr::expect_doppelganger("Linux Wrap title DL hou rel ncum line sumfun lim", g38)
	vdiffr::expect_doppelganger("Linux Wrap title DL hou abs cum line sumfun lim",  g39)
	vdiffr::expect_doppelganger("Linux Wrap title DL hou abs ncum line sumfun lim", g40)
	
	vdiffr::expect_doppelganger("Linux Wrap Total DL day rel cum line nolim",  g41)	
	vdiffr::expect_doppelganger("Linux Wrap Total DL day rel ncum line nolim", g42)
	vdiffr::expect_doppelganger("Linux Wrap Total DL day abs cum line nolim",  g43)
	vdiffr::expect_doppelganger("Linux Wrap Total DL day abs ncum line nolim", g44)
	vdiffr::expect_doppelganger("Linux Wrap Total DL hou rel cum line nolim",  g45)
	vdiffr::expect_doppelganger("Linux Wrap Total DL hou rel ncum line nolim", g46)
	vdiffr::expect_doppelganger("Linux Wrap Total DL hou abs cum line nolim",  g47)
	vdiffr::expect_doppelganger("Linux Wrap Total DL hou abs ncum line nolim", g48)
	
	vdiffr::expect_doppelganger("Linux Wrap title DL day rel cum line nolim",  g49)
	vdiffr::expect_doppelganger("Linux Wrap title DL day rel ncum line nolim", g50)
	vdiffr::expect_doppelganger("Linux Wrap title DL day abs cum line nolim",  g51)
	vdiffr::expect_doppelganger("Linux Wrap title DL day abs ncum line nolim", g52)
	vdiffr::expect_doppelganger("Linux Wrap title DL hou rel cum line nolim",  g53)
	vdiffr::expect_doppelganger("Linux Wrap title DL hou rel ncum line nolim", g54)
	vdiffr::expect_doppelganger("Linux Wrap title DL hou abs cum line nolim",  g55)
	vdiffr::expect_doppelganger("Linux Wrap title DL hou abs ncum line nolim", g56)
	
	vdiffr::expect_doppelganger("Linux Wrap title DL day rel cum line sumfun nolim",  g57)
	vdiffr::expect_doppelganger("Linux Wrap title DL day rel ncum line sumfun nolim", g58)
	vdiffr::expect_doppelganger("Linux Wrap title DL day abs cum line sumfun nolim",  g59)
	vdiffr::expect_doppelganger("Linux Wrap title DL day abs ncum line sumfun nolim", g60)
	vdiffr::expect_doppelganger("Linux Wrap title DL hou rel cum line sumfun nolim",  g61)
	vdiffr::expect_doppelganger("Linux Wrap title DL hou rel ncum line sumfun nolim", g62)
	vdiffr::expect_doppelganger("Linux Wrap title DL hou abs cum line sumfun nolim",  g63)
	vdiffr::expect_doppelganger("Linux Wrap title DL hou abs ncum line sumfun nolim", g64)
	
	vdiffr::expect_doppelganger("Linux lastpoints nolegend",  g65)
	vdiffr::expect_doppelganger("Linux firstpoints nolegend", g66)
	vdiffr::expect_doppelganger("Linux angledboxes nolegend",  g67)
	vdiffr::expect_doppelganger("Linux nodirectlabels legend", g68)
		
	}
	
})

# cleanup
rm(t_exmpl, data1)
rm(list = ls(pat = "g1?[0-9]"))
