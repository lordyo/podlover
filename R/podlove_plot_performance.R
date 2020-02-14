#' Plot Performance Diagram from Download Data
#' 
#' Wrapper function to prepare and generate a performance plot with all episodes
#'     on an X/Y grid, X showing long-term average downloads, Y showing average
#'     downloads during launch. Horizontal and vertcal lines show median values. 
#'     This allows for categorization of epsisodes into performance clusters.
#'     Note that you won't see episodes which are younger than your \code{post_launch}
#'     limit. If you want to generate and tweak the data behind this plot, 
#'     use \code{podlove_performance_stats}.
#' 
#' @param dldata A tidy data frame with download data, as constructed
#'     by \code{podlove_clean_stats()} or \code{podlove_get_and_clean}.
#' @param launch definition of a episode launch period in days after launch
#' @param post_launch definition of begin of long-term performance in days after launch
#' @param limit_unit time unit for limits. Can be "days" (default) or "hours".
#'     Used to fine-tune launch performance cutoffs.  
#' @param label Unquoted, episode-related variable to use for labelling. By default,
#'     \code{podlove_performance_stats} creates the options \code{title}, 
#'     \code{ep_number} and \code{ep_num_title}. Leave the argument away to
#'     display no label 
#' @param legend Unquoted, episode-related variable to use in a explanatory legend 
#'     next to the performance graph. Leave the option away to display no legend.
#'     \code{label} argument must be defined to show the legend.
#' @param printout Switcher to automatically print out the plot (default TRUE)
#' 
#' @return A ggplot object
#' 
#' @examples
#' # create example data
#' dls <- podlove_create_example(clean = TRUE)
#' 
#' podlove_plot_performance(dls, launch = 2, post_launch = 5)	
#' 
#' @importFrom magrittr %>% 
#' 
#' @seealso podlove_performance_stats(), podlove_graph_performance()
#' 
#' @export

podlove_plot_performance <- function(dldata, 
																		 launch = 3, 
																		 post_launch = 7, 
																		 limit_unit = "days", 
																		 label,
																		 legend,
																		 printout = TRUE) {
	
	g_data <- podlove_performance_stats(df_tidy_data = dldata, 
																			launch = launch, 
																			post_launch = post_launch, 
																			limit_unit = limit_unit)
	
	if (missing(label)) {
		
		g <- podlove_graph_performance(df_perfstats = g_data, 
																	 printout = printout)
		
	} else if (missing(legend)) {
		
		g <- podlove_graph_performance(df_perfstats = g_data, 
																	 label = {{label}}, 
																	 printout = printout)
	} else {
		
		g <- podlove_graph_performance(df_perfstats = g_data, 
																	 label = {{label}}, 
																	 legend = {{legend}},
																	 printout = printout)
	}
		
	g
}