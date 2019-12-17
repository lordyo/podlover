podlove_graph_performance <- function(df_perfstats) {
  
  # PURPOSE
  ### Graphs launch performance and long term performance in an XY chart
  
  # INPUT
  ### df_perfstats: a performance stats df created by performance_stats()
  
  # OUTPUT
  ### g: a ggplot graph (print is integrated)
  
  
  df_perfstats <- filter(df_perfstats, !is.na(listeners_per_day_after_launch),
                         !is.na(listeners_per_day_at_launch))
  
  median_x <- median(df_perfstats$listeners_per_day_after_launch)
  median_y <- median(df_perfstats$listeners_per_day_at_launch)
  
  g <- ggplot(df_perfstats,
              aes(x = listeners_per_day_after_launch,
                  y = listeners_per_day_at_launch ,label = title)) +
    geom_point() +
    scale_x_continuous(name = "Listeners per Day after Launch", limits = c(0,max(df_perfstats$listeners_per_day_after_launch))) +
    scale_y_continuous(name = "Listeners per Day during Launch", limits = c(0,max(df_perfstats$listeners_per_day_at_launch))) +
    geom_hline(yintercept = median_y, alpha = 0.3) +
    geom_vline(xintercept = median_x, alpha = 0.3) +
    geom_label_repel()
    
  
  print(g)
  
  g
  
}