#' Prepare Podlove data for graphical rendering
#'
#' Takes clean Podlove data and prepares it to be rendered with \code{ggplot2}. 
#' The function accepts one or more grouping variables (e.g. episode title) and
#' accepts parameters for the time axis of downloads.
#'
#' @param df_stats A data frame of clean Podlove data, as rendered by 
#'     \code{podlove_get_and_clean()} or \code{podlove_clean_stats}.
#' @param gvar Optional grouping variable(s), unquoted.
#' @param hourly Boolean switching parameter for rendering of hourly vs.
#'     daily data. Defaults to \code{FALSE} (daily data), \code{TRUE} creates
#'     hourly data.  
#' @param relative Boolean switching parameter to define if the data is 
#'     rendered relative to the respective episode release date (\code{TRUE}) or
#'     in absolute dates (\code{TRUE}). Defaults to \code{TRUE}.
#' @param last_n Number of most recent episodes to filter for. Defaults to 0 (no filtering),
#'     use negative numbers to filter for first n episodes. 
#'     
#' @examples 
#' \dontrun{
#' # relative, daily plot by episode title
#' podlove_prepare_stats_for_graph(podcast_example_data, gvar = title) 
#' 
#' # relative, hourly plot by episode number
#' podlove_prepare_stats_for_graph(podcast_example_data, gvar = ep_number, hourly = TRUE) 
#' 
#' # absolute, daily plot by episode title
#' podlove_prepare_stats_for_graph(podcast_example_data, gvar = title, relative = FALSE) 
#' 
#' # abolute, hourly plot by podcast client name
#' podlove_prepare_stats_for_graph(podcast_example_data, gvar = client_name, relative = FALSE) 
#' }
#' 
#' @importFrom magrittr %>% 
#' @importFrom dplyr group_by summarize ungroup mutate n
#' 
#' @export 


podlove_prepare_stats_for_graph <- function(df_stats, 
                                            gvar, 
                                            hourly = FALSE, 
                                            relative = TRUE,
                                            last_n = 0) {
  
  # prepare for tidy evaluation
  gvar <- dplyr::enquo(gvar)
  
  prep_stats <- df_stats
  
  # apply last_n settings
  if (last_n != 0) {
    
    #create reference table with ep ranks
    epnrs <- df_stats %>% 
      group_by(ep_num_title, post_datehour) %>% 
      summarize() %>%
      ungroup() %>% 
      arrange(post_datehour) %>% 
      mutate(ep_rank = row_number()) %>% 
      select(-post_datehour) %>% 
      top_n(last_n)
    
    #attach ep ranks and filter via join
    prep_stats <- right_join(prep_stats, epnrs, by = "ep_num_title") %>% 
      select(-ep_rank)
  }

  # switcher for hourly/realative combinations
  
  if (hourly == TRUE & relative == TRUE) {
    prep_stats <- group_by(prep_stats, hours_since_release)
  } else if (hourly == FALSE & relative == TRUE) {
    prep_stats <- group_by(prep_stats, days_since_release)
  } else if (hourly == TRUE & relative == FALSE) {
    prep_stats <- group_by(prep_stats, dldatehour)
  } else if (hourly == FALSE & relative == FALSE) {
    prep_stats <- group_by(prep_stats, dldate)
  }
  
  # check if gvar is empty
  
  if (!is.null(gvar)) {
    prep_stats <- prep_stats %>% group_by(!! gvar, add = TRUE)
  }
  
  # summarize

  prep_stats <- prep_stats %>%
    summarize(listeners = n()) %>%
    ungroup() %>% 
    dplyr::rename(time = 1) # call first column "time"
  
  # check again if gvar is empty
  
  if (!is.null(gvar)) {
    prep_stats <- prep_stats %>% group_by(!! gvar)
  }
  
  # add additional cumulative listeners column

  prep_stats <- prep_stats %>% 
    mutate(listeners_total = cumsum(listeners)) %>%
    ungroup()
  
  prep_stats
}