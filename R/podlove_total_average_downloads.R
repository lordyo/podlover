podlove_total_average_downloads <- function(df_tidy_data, gvar = "title", lower_limit = 0, upper_limit = Inf,
                              limit_unit = "days") {
  
  # Flexible function to get average and total donwloads per episode. Can be constrained to 
  # maximum and minimum time span since episode launch, e.g. to get best launches or best evergreens
  
  # INPUT
  #   df_tidy_data: A tidy data frame created by podlove_clean_stats()
  #   gvar: a grouping variable that should be related to individual episodes (title, episode number)
  #         allows for multiple variables in the form of concatenated strings
  #   lower_limit: lower cutoff for time since launch (used to eliminate launch peaks)
  #   upper_limit: upper cutoff for time since launch (used to eliminiate long term download data)
  #   limit_unit: time unit for limits - "days" or "hours"
  
  
  # OUTPUT

  
  ########################################################################
  
  # switch units if necessary
  
  if (limit_unit == "days") {
    lower_limit <- lower_limit * 24
    upper_limit <- upper_limit * 24
    }
  
  
  tad <- df_tidy_data %>%
    
    # NSE grouping for gvar
    group_by_at(gvar) %>%
    # additional grouping for time since launch
    group_by(hours_since_release, add = TRUE) %>%
    summarize(listeners_total = n()) %>% 
    ungroup()  %>% 
    # set limits
    filter(hours_since_release <= upper_limit,
            hours_since_release >= lower_limit) %>% 
    # calculate sum and averages
    group_by_at(gvar) %>% 
    summarize(listeners_total = sum(listeners_total),
              maxtime = max(hours_since_release)) %>% 
    mutate(listeners_per_day = listeners_total / maxtime) %>% 
    select({{gvar}}, listeners_total, listeners_per_day)
  
  
  # set average unit
  if (limit_unit == "days") {
    tad <- mutate(tad, listeners_per_day = listeners_per_day * 24)
  } else {
    tad <- rename(tad, listeners_per_hour = listeners_per_day)
  }

  tad
  
}