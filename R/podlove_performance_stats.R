podlove_performance_stats <- function(df_tidy_data, launch = 3, post_launch = 7) {

  # PURPOSE
  ### Gathers overall, launch and long-term stats for all episodes. 
  
  # INPUT
  ### df_tidy_data: A tidy data frame created by podlove_clean_stats()
  ### launch: definition of a episode launch period in days after launch
  ### post_launch: definition of begin of long-term performance in days after launch
  
  # OUTPUT
  ### Var: a data frame with performance statistics
  
  totals <- total_average_downloads(df_tidy_data)
  launches <- total_average_downloads(df_tidy_data, upper_limit = {{launch}})
  evergreens <- total_average_downloads(df_tidy_data, lower_limit = {{post_launch}})
  
  pl_stats <- totals %>% 
    left_join(launches, by = "title") %>% 
    left_join(evergreens, by = "title") %>% 
    select(title, listeners = listeners_total.x,
           listeners_per_day_at_launch = listeners_per_day.y,
           listeners_per_day_after_launch = listeners_per_day)
  
  pl_stats
  
  
}