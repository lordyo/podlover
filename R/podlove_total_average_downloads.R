#' Calculate total downloads and average downloads over time
#'
#' Calculates the total of downloads and the average of downloads over a time 
#'     unit for a podcast or its episodes. The measurement period can be defined
#'     with an upper and lower limit. Use this function for fine-tuned performance
#'     measurement.
#'     
#' @param  df_tidy_data A tidy data frame with download data, as constructed
#'     by \code{podlove_clean_stats()} or \code{podlove_get_and_clean}.
#' @param gvar an optional grouping variable, which should be reflect the episode
#'     structure (e.g. ep_number, title). Other variables will lead to nonsensical
#'     results, because the calculation is based on time unit since episode release.
#' @param lower_limit lower cutoff for time since episode launch (used to eliminate
#'     launch peaks). Defaults to 0, i.e. no filtering.
#' @param upper_limit upper cutoff for time since episode launch (used to eliminate
#'     long term download data and just focus on launch performance)
#' @param limit_unit time unit for limits. Can be "days" (default) or "hours".
#'     Used to fine-tune launch performance cutoffs. 
#' 
#' @return a dataframe containing performance data per episode (total downloads,
#'     during time period, average downloads during time period). 
#' 
#' @examples 
#' \dontrun{
#' print(1)
#' }
#' 
#' @importFrom magrittr %>%
#' 
#' @seealso \code{podlove_performance_stats} for a more general performance function

podlove_total_average_downloads <- function(df_tidy_data, 
                                            gvar = "title", 
                                            lower_limit = 0, 
                                            upper_limit = Inf,
                                            limit_unit = "days") {
  
  # switch units if necessary
  
  if (limit_unit == "days") {
    lower_limit <- lower_limit * 24
    upper_limit <- upper_limit * 24
    }
  
  
  tad <- df_tidy_data %>%
    
    # NSE grouping for gvar
    dplyr::group_by_at(gvar) %>%
    # additional grouping for time since launch
    dplyr::group_by(hours_since_release, add = TRUE) %>%
    dplyr::summarize(listeners_total = n()) %>% 
    dplyr::ungroup()  %>% 
    # set limits
    dplyr::filter(hours_since_release <= upper_limit,
            hours_since_release >= lower_limit) %>% 
    # calculate sum and averages
    dplyr::group_by_at(gvar) %>% 
    dplyr::summarize(listeners_total = sum(listeners_total),
              maxtime = max(hours_since_release)) %>% 
    dplyr::mutate(listeners_per_day = listeners_total / maxtime) %>% 
    dplyr::select({{gvar}}, listeners_total, listeners_per_day)
  
  
  # set average unit
  if (limit_unit == "days") {
    tad <- dplyr::mutate(tad, listeners_per_day = listeners_per_day * 24)
  } else {
    tad <- dplyr::rename(tad, listeners_per_hour = listeners_per_day)
  }

  tad
  
}