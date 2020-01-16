#' Plot Download Curves from Download Data
#' 
#' Wrapper function to prepare and generate a line curve diagram
#'     of downloads over time. It takes an optional grouping variable (e.g.
#'     title) as well as options for the time axis of downloads for cumulative display, 
#'     labeling and print output. If you want to generate and tweak the data
#'     behind this plot, use \code{podlove_prepare_stats_for_graph}.
#' 
#' @param  dldata A tidy data frame with download data, as constructed
#'     by \code{podlove_prepare_stats_for_graph()}
#' @param gvar Optional grouping parameter (e.g. episode title), handed over
#'     to \code{ggplot2::aes(color)}.
#' @param hourly Boolean switching parameter for rendering of hourly vs.
#'     daily data. Defaults to \code{FALSE} (daily data), \code{TRUE} creates
#'     hourly data.  
#' @param relative Boolean switching parameter to define if the data is 
#'     rendered relative to the respective episode release date (\code{TRUE}) or
#'     in absolute dates (\code{TRUE}). Defaults to \code{TRUE}.
#' @param cumulative Boolean switch to show either cumulative data (TRUE, default),
#'     or non-comulative data (FALSE)
#' @param plot_type Sets the plot type to either line plot (\code{"line"}) or
#'     ridgeline plot (\code{"ridge"}). 
#' @param labelmethod Defines where should the labels be attached 
#'     (at the beinning of the curves: \code{"last.points"}, default, or at
#'     the end of the curves \code{"first.points"}) 
#' @param printout Switcher to automatically print out the plot (default TRUE)
#' @param ... additional formating parameters for \code{ggplot2::geom_line()}
#'     or \code{ggridges::geom_density_ridges}.
#' 
#' @return A ggplot object
#' 
#' @examples
#' # create example data
#' dls <- podlove_create_example(clean = TRUE)
#' 
#' podlove_plot_curves(dls, gvar = title, relative = TRUE, cumulative = TRUE)
#' 
#' # see podlove_graph_download_curves() for more information.
#' 
#' @importFrom magrittr %>% 
#' 
#' @seealso podlove_graph_download_curves(), 
#'    podlove_prepare_stats_for_graph()
#' 
#' @export

podlove_plot_curves <- function(dldata, 
																gvar = "Total", 
																hourly = FALSE, 
																relative = TRUE, 
																cumulative = TRUE,
																plot_type = "line", 
																labelmethod = "last.points",
																printout = TRUE,
																...) {
  
	g_data <- podlove_prepare_stats_for_graph(df_stats = dldata,
																						gvar = {{gvar}},
																						hourly = hourly,
																						relative = relative)
	
	g <- podlove_graph_download_curves(df_tidy_data = g_data,
																		 gvar = {{gvar}},
																		 cumulative = cumulative,
																		 plot_type = plot_type,
																		 labelmethod = labelmethod,
																		 printout = printout,
																		 ...)
	
	g
}