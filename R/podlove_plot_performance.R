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
#' @param label Switcher to attach labels to points (defaults to TRUE)
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
																		 label = TRUE,
																		 printout = TRUE) {
	
	g_data <- podlove_performance_stats(df_tidy_data = dldata, 
																			launch = launch, 
																			post_launch = post_launch, 
																			limit_unit = limit_unit)
	
	g <- podlove_graph_performance(df_perfstats = g_data, 
																 label = label, 
																 printout = printout)
	
	g
}