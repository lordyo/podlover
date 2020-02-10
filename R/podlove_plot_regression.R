#' Create a regression plot of episode downloads against an episode variable  
#'
#' Wrapper function to take data from \code{podlove_get_and_clean()} and creates
#'     a regression plot with several graphical options.
#'
##' @param df_tidy_data a tidy table of downloads created by \code{podlov_clean_stats()}
#'     or \code{podlove_get_and_clean()} 
#' @param point_in_time Measurement point in time relative to episode release
#'     in hours or days. Can be a single value or a vector of integers. 
#' @param time_unit Time unit of \code{points_in_time}, either \code{"days"} (default)
#'     or \code{"hours"}.
#' @param predictor a single predictor variable for downloads, typically a time 
#'     or order based variable such as \code{post_date}, \code{post_datehour} (default), 
#'     \code{episode_age_hours}/\code{episode_age_days} (note: age decreases
#'     with episodes!) or \code{episode_rank}.
#' @param plot_type the type of plot that should be generated. accepts a string
#'     from the list "point" (dot plot), "line" (line plot") or "area (area plot)
#' @param label boolean switcher to label the plotted points with episode titles
#'     (default: FALSE)
#' @param regline boolean switcher if the plot should contain a regression line
#'     (default: TRUE)
#' @param ribbon boolean switcher if the plot should contain a confidence ribbon
#'     (default: TRUE)
#' @param stylize boolean switcher if the plot should be beautifed (default TRUE).
#'     if FALSE, styling can be added later with \code{+ ggthemes::theme_name}
#' @param print_model boolean switcher if the regression model should be printed
#' @param print_plot boolean switcher if the plot should print a graph
#' 
#' @return a ggplot2 object 
#' 
#' @examples 
#' \dontrun{
#' # prepare linear regression data for downloads on day 3 by episode release date
#' downloads <- podlove_create_example()
#' 
#' # create dot plot 
#' podlove_plot_regression(downloads, point_in_time = 3, plot_type = "point")
#' 
#' # create line plot with labels 
#' podlove_plot_regression(downloads, point_in_time = 3, plot_type = "point",
#'                          label = TRUE)
#' 
#' # create area plot without regression line and ribbon 
#' podlove_plot_regression(downloads, point_in_time = 3, predictor = post_datehour, 
#'                          plot_type = "point", regline = FALSE, ribbon = FALSE)
#'
#' # create dot plot, add another theme 
#' podlove_plot_regression(downloads, point_in_time = 3, predictor = post_datehour, 
#'                         plot_type = "point", stylize = FALSE) +
#'     ggthemes::theme_economist()
#' }
#' 
#' @importFrom magrittr %>%
#' 
#' @export

podlove_plot_regression <- function(df_tidy_data,
                                    point_in_time,
                                    time_unit = "days",
                                    predictor = post_datehour,
                                    plot_type = "line",
                                    label = FALSE,
                                    regline = TRUE,
                                    ribbon = TRUE,
                                    stylize = TRUE,
                                    print_model = TRUE,
                                    print_plot = TRUE) {
  
  # calculate regression data
  df_regression_data <- podlove_downloads_until(df_tidy_data = df_tidy_data,
                                                points_in_time = point_in_time,
                                                time_unit = time_unit)
  
  #stringify the predictor for handover
  predictor_str <- deparse(substitute(predictor))
  
  #calculate the regression model
  model <- podlove_episode_regression(df_regression_data = df_regression_data,
                                          terms = predictor_str,
                                          printout = FALSE)
 
  # get confidence interval data from regression model
  conf_df <- as.data.frame(stats::predict(model, interval = 'confidence'))
  
  # attach regression data to original data
  df_data_with_model <- dplyr::bind_cols(df_regression_data, conf_df)
  
  # base plot
  g_model <- ggplot2::ggplot(df_data_with_model,
                             ggplot2::aes(x = {{predictor}},
                                          y = downloads, 
                                          label = ep_number))
  
  # switcher for plot_type
  
  plot_types = c("line", "point", "area")
  
  if (plot_type == "line") {
    g_model <- g_model + ggplot2::geom_line(color = "#555555") +
      ggplot2::geom_point(color = "#000066")
    
  } else if (plot_type == "point") {
    g_model <- g_model + ggplot2::geom_point(color = "#000066")
    
  } else if (plot_type == "area") {
    g_model <- g_model + ggplot2::geom_area(fill = "#6699CC")
    
  } else  stop(paste0("plot_type is unkonwn. Use 'line', 'point' or 'area'."))
  
  # switcher for regression line
  if (regline) {
    g_model <- g_model +  
      ggplot2::geom_line(ggplot2::aes({{predictor}}, fit), color = "blue")
  }
  
  # switcher for confidence interval ribbon
  if (ribbon) {
    g_model <- g_model +  
      ggplot2::geom_ribbon(ggplot2::aes(ymin = lwr, ymax = upr), alpha = 0.15) 
  }
  
  # switcher for theme
  if (stylize) { 
    g_model <- g_model +
      ggthemes::theme_tufte()
  }
  
  # switcher for label 
  if (label) {
    g_model <- g_model + 
      ggrepel::geom_text_repel(color = "#555555",
                               family = "serif",
                               size = 10 / ggplot2::.pt)  
  }
  
  # switcher for print out
  if (print_model) print(summary(model))
  if (print_plot) print(g_model)

  g_model
  
}
