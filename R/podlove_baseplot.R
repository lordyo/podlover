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
#' @param limit Boolean switch to fix axis limtis (relevant when adding smoothers)
#' @param legend Boolean switch to add a legend
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
                             gvar = "Total",
                             cumulative = TRUE,
                             limit = TRUE,
                             legend = FALSE,
                             ...) {
  # switcher for cumulative data (use listeners or listeners-total)
  if (cumulative == TRUE) {
    
    g_dl_curves <- ggplot(df_tidy_data,
                          ggplot2::aes(x = time,
                                       y = listeners_total,
                                       color = {{gvar}}))
    
    # set possible axis limit (not applied yet)
    lim_terms_y <- c(0, max(df_tidy_data$listeners_total))
    
  } else {    # non cumulative
    
    g_dl_curves <- ggplot2::ggplot(df_tidy_data,
                                   ggplot2::aes(x = time,
                                                y = listeners,
                                                color = {{gvar}}))
    # set possible axis limit
    lim_terms_y <- c(0, max(df_tidy_data$listeners))
  } 
  
  # apply axis limitis, if necessary
  if (limit) {
    lim_terms_x <- c(min(df_tidy_data$time), max(df_tidy_data$time))
    
    g_dl_curves <- g_dl_curves + 
      ggplot2::scale_y_continuous(limits = lim_terms_y)
      
      # class switcher for type of x axis (Date or Continuous)
      if ("Date" %in% class(df_tidy_data$time)) {
        
        g_dl_curves <- g_dl_curves + 
          ggplot2::scale_x_date(limits = lim_terms_x) 
        
      } else if ("POSIXct" %in% class(df_tidy_data$time)) {
        
        g_dl_curves <- g_dl_curves + 
          ggplot2::scale_x_datetime(limits = lim_terms_x) 
        
        } else {
        
        g_dl_curves <- g_dl_curves + 
          ggplot2::scale_x_continuous(limits = lim_terms_x) 
      }
        
  }
  
  # turn off legend if not used
  if (!legend) {
    
    g_dl_curves <- g_dl_curves + 
      ggplot2::guides(color = FALSE) 
  }
  
  # add dotdots
  g_dl_curves <-  g_dl_curves +
    ggplot2::geom_line(...)
  
  
  g_dl_curves
  
}