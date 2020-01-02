#' Calculate download sums at point in time
#'
#' This function takes a tidy table of downloads and creates a table containing
#' the number of downloads at a specified \code{point_in_time} in hours.
#' Episodes with an episode age younger than \code{point_in_time} will be excluded.
#' Helper function to \code{podlove_prep_regtables()}. 
#'
#' @param df_tidy_data a tidy table of downloads created by \code{podlov_clean_stats()}
#'     or \code{podlove_get_and_clean()} 
#' @param point_in_time Measurement point in time relative to episode release
#'     in hours. To specify days, use \code{point_in_time = days * 24}
#' 
#' @return A tidy table of episode downloads at the specified point in time, 
#'     along with episode-related fields 
#' 
#' @examples 
#' \dontrun{
#' # downloads after 12 hours
#' podlove_prep_regtable(podcast_example_data, 12)
#' 
#' # downloads after 10 days
#' podlove_prep_regtable(podcast_example_data, 10*24)
#' }
#' 
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by summarize mutate filter arrange

podlove_prep_regtable <- function(df_tidy_data,
                                  point_in_time) {
 
  
  if (point_in_time > max(df_tidy_data$hours_since_release)) {
    warning(paste0("point_in_time (", point_in_time, " hours) is greater than podcast age: No data generated"))
  }
  
  reg_prep <- df_tidy_data %>% 
    
    filter(ep_age_hours >= point_in_time,
           hours_since_release <= point_in_time) %>%
 
    dplyr::group_by(ep_number,
                    title,
                    ep_num_title,
                    duration,
                    post_date,
                    post_datehour,
                    ep_age_hours,
                    ep_age_days) %>%
    summarize(downloads = n()) %>%
    ungroup() %>%

    arrange(post_datehour) %>%
    mutate(measure_day = point_in_time / 24,
           measure_hour = point_in_time,
           ep_rank = dplyr::row_number()) %>%
    select(ep_number,
            title,
            ep_num_title,
            duration,
            post_date,
            post_datehour,
            ep_age_hours,
            ep_age_days,
            ep_rank,
            measure_day,
            measure_hour,
            downloads)

  reg_prep
}
