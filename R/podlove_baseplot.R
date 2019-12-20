#' Construct a basic Podlove plot 2
#'
#' Creates the basic plot to display Podlove download data over time, using
#'     \code{ggplot2()}. Does not add any geoms except axis limits. Includes 
#'     an optional grouping variable and a switcher between
#'     cumulative/non-cumulative data. 
#'
#' @param  df_tidy_data A tidy data frame with download data, as constructed
#'     by \code{podlove_prepare_stats_for_graph()}
#' @param gvar Optional grouping parameter (e.g. episode title), handed over
#'     to \code{ggplot2::aes(color)}. 
#' @param cumulative Boolean switch to show either cumulative data (TRUE, default),
#'     or non-comulative data (FALSE) 
#' @param ... Additional parameters to be handed over to \code{ggplot2::aes()} 
#' 
#' @return A ggplot2 plot 
#' 
#' @examples 
#' \dontrun{
#' print(1)
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
                                                       color = gvar,
                                                       ...)) +

      ggplot2::coord_cartesian(ylim = c(0, max(df_tidy_data$listeners_total)))

  } else {

    g_dl_curves <- ggplot2::ggplot(df_tidy_data,
                                   ggplot2::aes_string(x = "time",
                                                       y = "listeners",
                                                       color = gvar,
                                                       ...)) +

      ggplot2::coord_cartesian(ylim = c(0, max(df_tidy_data$listeners)))
  }

  g_dl_curves
  
}