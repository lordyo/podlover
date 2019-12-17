podlove_graph_download_curves_multi <- function(df_tidy_data, gvar, cumulative = TRUE, labelmethod = "last.points") {
  
  # creates a line graph plotting out cumulative listeners against time, grouped
  # by arbitrary variable. For overall curves (single line, use graph_download_curves_single)
  
  # INPUT
  ## df_tidy_data: a data frame containing tidy podlove data
  ## gvar: grouping variable (e.g. title)
  ## cumulative: use cumulative data or not
  ## labelmethod: where should the labels be attached ("last.points" or "first.points")
  
  # OUTPUT
  # g_dl_curves = a multiline plot
  # prints out a graph as well
  
  ########################################################################
  
  # switcher for cumulative data (use listeners or listeners-total)
  
  if (cumulative == TRUE) {
    
    g_dl_curves <- ggplot(df_tidy_data, 
                          aes(x = time, y = listeners_total, color = {{gvar}}))
  } else {
    
    g_dl_curves <- ggplot(df_tidy_data, 
                          aes(x = time, y = listeners, color = {{gvar}}))
  }
  
  # construct graph
  
  g_dl_curves <-  g_dl_curves +
    geom_line(alpha = 0.5) +
    guides(color = FALSE) +
    geom_dl(aes(label = {{gvar}}), method = list(labelmethod, cex = 0.8))
  
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