#' Prepare Podlove data for graphical rendering
#'
#' Takes clean Podlove data and prepares it to be rendered with \code{ggplot2}. 
#' The function accepts one or more grouping variables (e.g. episode title) and
#' accepts parameters for the time axis of downloads.
#'
#' @param df_stats A data frame of clean Podlove data, as rendered by 
#'     \code{podlove_get_and_clean()} or \code{podlove_clean_stats}.
#' @param gvar Optional grouping variable(s), unquoted. If multiple variables 
#'     are given, they need to be in the form \code{c(var1, var2)}. 
#' @param hourly Boolean switching parameter for rendering of hourly vs.
#'     daily data. Defaults to \code{FALSE} (daily data), \code{TRUE} creates
#'     hourly data.  
#' @param relative Boolean switching parameter to define if the data is 
#'     rendered relative to the respective episode release date (\code{TRUE}) or
#'     in absolute dates (\code{TRUE}). Defaults to \code{TRUE}. 
#'     
#' @examples 
#' \dontrun{
#' print(1)
#' }
#' 
#' @importFrom magrittr %>% 
#' @importFrom dplyr group_by summarize ungroup mutate

podlove_prepare_stats_for_graph <- function(df_stats, gvar, hourly = FALSE, relative = TRUE) {
  
  # prepare for tidy evaluation
  gvar <- dplyr::enquo(gvar)
  
  prep_stats <- df_stats

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