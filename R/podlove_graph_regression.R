#' Create a regression plot of episode downloads against an episode variable  
#'
#' This function takes data from a \code{podlove_downloads_until()} and creates
#'     a regression plot with several graphical options.
#'
#' @param df_regression_data a tidy data table created by \code{podlove_downloads_until()}.
#'     Note that this function can't be fed data including more than one \code{point_in_time}
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
#' @param printout boolean switcher if the plot should print a graph
#' 
#' @return a ggplot2 object 
#' 
#' @examples 
#' \dontrun{
#' # prepare linear regression data for downloads on day 3 by episode release date
#' dl <- podlove_downloads_until(podcast_example_data, points_in_time = 3)
#' 
#' # create dot plot 
#' podlove_graph_regression(dl, predictor = post_datehour, plot_type = "point")
#' 
#' # create line plot with labels 
#' podlove_graph_regression(dl, predictor = post_datehour, plot_type = "point",
#'                          label = TRUE)
#' 
#' # create area plot without regression line and ribbon 
#' podlove_graph_regression(dl, predictor = post_datehour, plot_type = "point",
#'                          regline = FALSE, ribbon = FALSE)
#'
#' # create dot plot, add another theme 
#' podlove_graph_regression(dl, predictor = post_datehour, plot_type = "point",
#'                          stylize = FALSE) +
#'     ggthemes::theme_economist()
#' }
#' 
#' @importFrom magrittr %>%
#' 
#' @export

podlove_graph_regression <- function(df_regression_data,
                                     predictor = post_datehour,
                                     plot_type = "line",
                                     label = FALSE,
                                     regline = TRUE,
                                     ribbon = TRUE,
                                     stylize = TRUE,
                                     printout = TRUE) {
  
  # error handling for data sets with more than one point_in_time
  
  check_pits <- regression_data %>% 
    group_by(measure_hour) %>% 
    group_size() %>% 
    length()
  
  if (check_pits != 1) stop("Data set must consist of one point_in_time.")
  
  # predictor to string
  pred_string <- deparse(substitute(predictor))
  
  # calculate regression model
  model <- podlove_episode_regression(df_regression_data = df_regression_data,
                                      terms = pred_string,
                                      printout = FALSE)
  
  # get confidence interval data from regression model
  conf_df <- as.data.frame(stats::predict(model, interval = 'confidence'))
  
  # attach regression data to original data
  df_data_with_model <- dplyr::bind_cols(df_regression_data, conf_df)
  
  # base plot
  g_model <- ggplot2::ggplot(df_data_with_model,
                             ggplot2::aes(x = {{predictor}},
                                          y = downloads, 
                                          label = ep_num_title))
  
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
  if (printout) print(g_model)
  
  g_model
  
}
