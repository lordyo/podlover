#' Construct a basic podcast download line plot
#'
#' Creates the basic line plot to display Podlove download data over time, using
#'     \code{ggplot2()}. Includes  an optional grouping variable and a switcher between
#'     cumulative/non-cumulative data. 
#'
#' @param  df_tidy_data A tidy data frame with download data, as constructed
#'     by \code{podlove_prepare_stats_for_graph()}
#' @param gvar Optional grouping parameter string (e.g. "title"), handed over
#'     to \code{ggplot2::aes_string(color)}. Must correspond to the data structure
#'     in \code{df_tidy_data}.
#' @param cumulative Boolean switch to show either cumulative data (TRUE, default),
#'     or non-comulative data (FALSE) 
#' @param ... Additional parameters to be handed over to \code{ggplot2::geom_line()} 
#' 
#' @return A ggplot2 plot 
#' 
#' @examples
#' \dontrun{ 
#' #prepare data
#' gdata <- podlove_prepare_stats_for_graph(podcast_example_data, gvar = title)
#' 
#' # line graph with cumulative data (grouped by title)
#' podlove_baseplot(plot_data, gvar = "title", cumulative = TRUE)
#' 
#' # line graph with non-cumulative data
#' podlove_baseplot(plot_data, gvar = "title", cumulative = FALSE)
#' 
#' # line graph with non-cumulative data and additional display parameters
#' podlove_baseplot(plot_data, gvar = "title", cumulative = FALSE,
#'                  alpha = 0.3, size = 5)
#' 
#' # line graph with ungrouped cumulative data
#' gdata <- podlove_prepare_stats_for_graph(podcast_example_data)
#' podlove_baseplot(plot_data, cumulative = TRUE)
#' }
#' 
#' @importFrom ggplot2 ggplot 

podlove_baseplot <- function(df_tidy_data,
                             gvar = NULL,
                             cumulative = TRUE,
                             ...) {
  # switcher for cumulative data (use listeners or listeners-total)
  
 
  if (cumulative == TRUE) {

    g_dl_curves <- ggplot(df_tidy_data,
                                   ggplot2::aes_string(x = "time",
                                                       y = "listeners_total",
                                                       color = gvar)) +

      ggplot2::coord_cartesian(ylim = c(0, max(df_tidy_data$listeners_total)))
    
  } else {

    g_dl_curves <- ggplot2::ggplot(df_tidy_data,
                                   ggplot2::aes_string(x = "time",
                                                       y = "listeners",
                                                       color = gvar)) +

      ggplot2::coord_cartesian(ylim = c(0, max(df_tidy_data$listeners)))
  } 
  
  g_dl_curves <-  g_dl_curves +
    ggplot2::geom_line(...) +
    ggplot2::guides(color = FALSE) 

  g_dl_curves
  
}