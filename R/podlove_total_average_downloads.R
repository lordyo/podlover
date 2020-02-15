#' Calculate total downloads and average downloads over time
#'
#' Calculates the total of downloads and the average of downloads over a time 
#'     unit for a podcast or its episodes. The measurement period can be defined
#'     with an upper and lower limit. Use this function for fine-tuned performance
#'     measurement.
#'     
#' @param  df_tidy_data A tidy data frame with download data, as constructed
#'     by \code{podlove_clean_stats()} or \code{podlove_get_and_clean}.
#' @param lower_limit lower cutoff for time since episode launch (used to eliminate
#'     launch peaks). Defaults to 0, i.e. no filtering.
#' @param upper_limit upper cutoff for time since episode launch (used to eliminate
#'     long term download data and just focus on launch performance)
#' @param limit_unit time unit for limits. Can be "days" (default) or "hours".
#'     Used to fine-tune launch performance cutoffs.
#' @param ... used for depreciated arguments 
#' 
#' @return a dataframe containing performance data per episode (total downloads,
#'     during time period, average downloads during time period). 
#' 
#' @examples 
#' \dontrun{
#' # total and average downloads by episode, no timeframe filter (complete period)
#' podlove_total_average_downloads(podcast_example_data, gvar = "title")
#' 
#' # total and average downloads by episode number after 7 days of release 
#' podlove_total_average_downloads(podcast_example_data, gvar = "ep_number",
#'                                lower_limit = 7)
#'
#'# total and average downloads by episode number during first 12 hours of release 
#'podlove_total_average_downloads(podcast_example_data, gvar = "ep_number",
#'                                upper_limit = 12, limit_unit = "hours")
#'                                }
#' 
#' @importFrom magrittr %>%
#' 
#' @export
#' 
#' @seealso \code{podlove_performance_stats} for a more general performance function

podlove_total_average_downloads <- function(df_tidy_data,  
                                            lower_limit = 0, 
                                            upper_limit = Inf,
                                            limit_unit = "days",
                                            ...) {
  
  # deal with depreciated arguments
  args <- list(...)
  if ("gvar" %in% names(args)) {
    warning("option 'gvar' is depreciated and no longer necessary")
  }
  
  
  # switch units if necessary
  
  if (limit_unit == "days") {
    lower_limit <- lower_limit * 24
    upper_limit <- upper_limit * 24
    }
  
  
  tad <- df_tidy_data %>%
    
    # NSE grouping for gvar
    dplyr::group_by(ep_number, title, ep_num_title) %>%
    # additional grouping for time since launch
    dplyr::group_by(hours_since_release, add = TRUE) %>%
    dplyr::summarize(dls_total = n()) %>% 
    dplyr::ungroup()  %>% 
    # set limits
    dplyr::filter(hours_since_release <= upper_limit,
            hours_since_release >= lower_limit) %>% 
    # calculate sum and averages
    dplyr::group_by(ep_number, title, ep_num_title) %>% 
    dplyr::summarize(dls_total = sum(dls_total),
              maxtime = max(hours_since_release)) %>% 
    dplyr::mutate(dls_per_day = dls_total / maxtime) %>% 
    dplyr::select(ep_number, title, ep_num_title, dls_total, dls_per_day) %>% 
    dplyr::ungroup()
  
  
  # set average unit
  if (limit_unit == "days") {
    tad <- dplyr::mutate(tad, dls_per_day = dls_per_day * 24)
  } else {
    tad <- dplyr::rename(tad, dls_per_hour = dls_per_day)
  }

  tad
  
}