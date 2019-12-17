podlove_prepare_stats_for_graph <- function(df_stats, gvar, hourly = FALSE, relative = TRUE) {
  
  # PURPOSE
  ### Prepares the data for graphical output
  
  # INPUT
  ### df_stats: Podcast data as prepared by podlove_clean_stats()
  ### gvar: grouping variable (e.g. title)
  ### hourly: hourly (finer) x-Axis if TRUE, daily (coarser) x axis if FALSE
  ### relative: measurement relative to launch date if TRUE, absolute dates if FALSE
  
  # OUTPUT
  ### prep_stats: a tidy dataframe for graphical analysis
  # prints out a graph as well
  
  library(dplyr)
  library(tidyr)
  
  # prepare for tidy evaluation
  gvar <- enquo(gvar)
  
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
    rename(time = 1) # call first column "time"
  
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