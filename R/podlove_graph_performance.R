#' Create performance grid for podcast episodes
#'
#' Based on data created by \code{podlove_performance_stats}, plot all episodes
#'     on an X/Y grid, X showing long-term average downloads, Y showing average
#'     downloads during launch. Horizontal and vertcal lines show median values. 
#'     This allows for categorization of epsisodes into performance clusters.
#'     Note that you won't see episodes which are younger than your \code{post_launch}
#'     limit. 
#'
#' @param df_perfstats a tidy data frame created by \code{performance_stats()}
#' @param label Switcher to attach labels to points (defaults to TRUE)
#' @param printout Switcher to automatically print out the plot (default TRUE)
#'     
#' @return A ggplot object
#' 
#' @examples 
#' \dontrun{
#' # plot episode performance stats with a launch period of 2 days and a
#' # post-launch period of 5 days
#' 
#' perf <- podlove_performance_stats(podcast_example_data, launch = 2, post_launch = 5)
#' podlove_graph_performance(perf)
#' }
#' 
#' @importFrom ggplot2 ggplot aes
#' 
#' @export



podlove_graph_performance <- function(df_perfstats, 
                                      label = ep_number,
                                      legend = "",
                                      printout = TRUE) {
  
  df_perfstats <- dplyr::filter(df_perfstats, !is.na(dls_per_day_after_launch),
                                !is.na(dls_per_day_at_launch))
  
  median_x <- stats::median(df_perfstats$dls_per_day_after_launch)
  median_y <- stats::median(df_perfstats$dls_per_day_at_launch)
  
  g <- ggplot(df_perfstats,
              aes(x = dls_per_day_after_launch,
                  y = dls_per_day_at_launch, label = {{label}})) +
    ggplot2::geom_point() +
    ggplot2::scale_x_continuous(name = "dls per Day after Launch",
                       limits = c(0,max(df_perfstats$dls_per_day_after_launch))) +
    ggplot2::scale_y_continuous(name = "dls per Day during Launch",
                       limits = c(0,max(df_perfstats$dls_per_day_at_launch))) +
    ggplot2::geom_hline(yintercept = median_y, alpha = 0.3) +
    ggplot2::geom_vline(xintercept = median_x, alpha = 0.3)
  
  g <- g + ggrepel::geom_text_repel()
  
  if (!missing(legend)) {

    leg_table <- gridExtra::tableGrob(
      select(df_perfstats, {{label}}, {{legend}}), theme = ttheme_minimal())

    g <- grid.arrange(g, leg_table, nrow = 1)
  }
  
  g
  
}