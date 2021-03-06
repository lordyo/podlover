#' Calculate podcast episode performance indicators
#'
#' Calculates totals and average downloads of podcast episodes with flexible
#'     defitions of "launch" and "evergreen" (long-term) periods.
#'     
#' Podcast performance between episodes is difficult to measure and compare,
#'     because podcasts a) have in most cases successive release dates, 
#'     b) follow non-linear, usually exponential performance patterns. Comparisons
#'     therefore need to be based on indicators reflecting those peculiarities. 
#'     
#'     One possible approach is to look at average downloads per time unit (e.g.
#'     days), and split performance in an initial "launch" period and a long-
#'     term "evergreen" period. The function \code{podlove_performance_stats} 
#'     and its helper function \code{podlove_total_average_downloads} allow this. 
#' 
#' @param  df_tidy_data A tidy data frame with download data, as constructed
#'     by \code{podlove_clean_stats()} or \code{podlove_get_and_clean}.
#' @param launch definition of a episode launch period in days after launch
#' @param post_launch definition of begin of long-term performance in days after launch
#' @param limit_unit time unit for limits. Can be "days" (default) or "hours".
#'     Used to fine-tune launch performance cutoffs. 
#'     
#' @return a dataframe containing performance data per episode title (total
#'     total downloads, average downloads during launch, average downloads 
#'     after launch)
#' 
#' @examples 
#' \dontrun{
#' # performance stats with a launch period of 2 days and a post-launch period
#' # of 5 days
#' podlove_performance_stats(podcast_example_data, launch = 2, post_launch = 5)
#'
#' # performance stats with a launch period of 12 hours and a post-launch period
#' # of 120 hours (= 5 days)
#' podlove_performance_stats(podcast_example_data,
#'                           launch = 2, post_launch = 5*24, limit_unit = "hours")
#' }
#' 
#' @importFrom magrittr %>%
#' 
#' @export
#' 
#' @seealso \code{podlove_total_average_downloads} for a more the helper function
#'    behind this function, which allows more fine tuned data.


podlove_performance_stats <- function(df_tidy_data,
                                      launch = 3, 
                                      post_launch = 7,
                                      limit_unit = "days") {
  
  
  totals <- podlove_total_average_downloads(df_tidy_data, 
                                            upper_limit = Inf, 
                                            lower_limit = 0,
                                            limit_unit = limit_unit)
  
  launches <- podlove_total_average_downloads(df_tidy_data, 
                                              upper_limit = {{launch}},
                                              limit_unit = limit_unit) %>% 
    select(-title, -ep_number)
  
  evergreens <- podlove_total_average_downloads(df_tidy_data, 
                                                lower_limit = {{post_launch}},
                                                limit_unit = limit_unit) %>% 
    select(-title, -ep_number)
  
  pl_stats <- totals %>%
    dplyr::left_join(launches, by = "ep_num_title") %>%
    dplyr::left_join(evergreens, by = "ep_num_title")
  
  if (limit_unit == "days") {

    pl_stats <- pl_stats %>%
      dplyr::select(ep_number, title, ep_num_title,
                    dls = dls_total.x,
                    dls_per_day = dls_per_day.x,
                    dls_per_day_at_launch = dls_per_day.y,
                    dls_per_day_after_launch = dls_per_day)

  } else if (limit_unit == "hours") {

    pl_stats <- pl_stats %>%
      dplyr::select(ep_number, title, ep_num_title,
                    dls = dls_total.x,
                    dls_per_hour = dls_per_hour.x,
                    dls_per_hour_at_launch = dls_per_hour.y,
                    dls_per_hour_after_launch = dls_per_hour)

  }

  pl_stats
  
}