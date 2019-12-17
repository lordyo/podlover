podlove_graph_download_curves_single <- function(df_tidy_data, cumulative = TRUE) {
  
  # creates a line graph plotting out cumulative listeners against time (totals only)
  # For multiline curves, use graph_download_curves_multi
  
  # INPUT
  ## df_tidy_data: a data frame containing tidy podlove data
  ## gvar: grouping variable (e.g. title)
  ## cumulative: use cumulative data or not
  
  # OUTPUT
  # g_dl_curves = a line plot with smoother

  
  ########################################################################
  
  # switcher for cumulative data (use listeners or listeners-total)
  
  if (cumulative == TRUE) {
    
    g_dl_curves <- ggplot(df_tidy_data, 
                          aes(x = time, y = listeners_total))
  } else {
    
    g_dl_curves <- ggplot(df_tidy_data, 
                          aes(x = time, y = listeners))
  }
  
  # construct graph
  
  g_dl_curves <-  g_dl_curves +
    geom_line(weight = 1, color = "gray27") +
    guides(color = FALSE) +
    geom_smooth(alpha = 0.5, linetype = 0)
  
  # switcher for limits of y-axis 
  
  if (cumulative == TRUE) {
    
    g_dl_curves <- g_dl_curves + coord_cartesian(ylim = c(0, max(df_tidy_data$listeners_total)))
    
  } else {
    
    g_dl_curves <- g_dl_curves + coord_cartesian(ylim = c(0, max(df_tidy_data$listeners)))
    
  }
  
  # print 
  
  print(g_dl_curves)  
  
  g_dl_curves
  
}