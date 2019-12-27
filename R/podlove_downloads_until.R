#' Calculate download sums at point(s) in time
#'
#' This function takes a tidy table of downloads and creates a table containing
#' the number of downloads at specified \code{points_in_time} in hours or days.
#' Episodes with an episode age younger than \code{point_in_time} will be excluded.
#' Can be used to generate data for regression models. 
#'
#' @param df_tidy_data a tidy table of downloads created by \code{podlov_clean_stats()}
#'     or \code{podlove_get_and_clean()} 
#' @param points_in_time Measurement points in time relative to episode release
#'     in hours or days. Can be a single value or a vector of integers. 
#' @param time_unit Time unit of \code{points_in_time}, either \code{"days"} (default)
#'     or \code{"hours"}.
#' 
#' @return A tidy table of episode downloads at the specified points in time, 
#'     along with episode-related fields 
#' 
#' @examples
#' \dontrun{ 
#' # downloads after 3 days
#' podlove_downloads_until(podcast_example_data, points_in_time = 3)
#' 
#' # downloads after 12 hours
#' podlove_downloads_until(podcast_example_data, points_in_time = 12,
#'                       time_unit = "hours")
#' 
#' # downloads after 1, 3, and 10 days
#' podlove_downloads_until(podcast_example_data, points_in_time = c(1, 3, 10))
#' }
#' 
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by summarize mutate filter
#' 
#' @export

podlove_downloads_until <- function(df_tidy_data,
                                   points_in_time,
                                   time_unit = "days") {
  
  # error handling: time unit input
  if (time_unit == "hour") {
    warning("time_unit must be either 'days' or 'hours', using 'hours'")
    time_unit = "hours"
  } else if (time_unit == "day") {
    warning("time_unit must be either 'days' or 'hours', using 'days'")
    time_unit = "days"
  } else if (!(time_unit %in% c("days", "hours"))) {
    stop("time_unit must be either 'days' or 'hours'.")
  }
  
  if (time_unit == "days") {
    points_in_time <- points_in_time * 24
  } 
 
  iter <- length(points_in_time)
   
  regtables <- purrr::map_df(.x = points_in_time, 
                             .f = podlove_prep_regtable, 
                             df_tidy_data = df_tidy_data)

  regtables
}