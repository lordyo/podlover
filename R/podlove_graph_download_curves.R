#' Create download curve plot
#'
#' Based on a prepared dataset, this function creates a line curve diagram
#'     of downloads over time. It takes an optional grouping variable (e.g.
#'     title) as well as options for cumulative display, labeling and 
#'     print output. For more finetuning options, use the \code{podlove_baseplot()}
#'     function and add geoms to your liking.
#'
#' @param  df_tidy_data A tidy data frame with download data, as constructed
#'     by \code{podlove_prepare_stats_for_graph()}
#' @param gvar Optional grouping parameter (e.g. episode title), handed over
#'     to \code{ggplot2::aes(color)}.
#' @param cumulative Boolean switch to show either cumulative data (TRUE, default),
#'     or non-comulative data (FALSE)
#' @param plot_type Sets the plot type to either line plot (\code{"line"}) or
#'     ridgeline plot (\code{"ridge"}). 
#' @param labelmethod Defines where should the labels be attached 
#'     (at the beinning of the curves: \code{"last.points"}, default, or at
#'     the end of the curves \code{"first.points"}) 
#' @param printout Switcher to automatically print out the plot (default TRUE)
#' @param limit Boolean switch to fix axis limtis (relevant when adding smoothers)
#' @param legend Boolean switch to add a legend' 
#' @param ... additional formating parameters for \code{ggplot2::geom_line()}
#'     or \code{ggridges::geom_density_ridges}.
#' 
#' @return A ggplot object
#' 
#' @examples 
#' \dontrun{
#' # relative, daily plot by episode title, cumulative
#' data("podcast_example_data")
#' gdata <- podlove_prepare_stats_for_graph(podcast_example_data, gvar = title) 
#' podlove_graph_download_curves(gdata, gvar = title, cumulative = TRUE)
#' 
#' # relative, hourly plot by episode number, cumulative
#' gdata <- podlove_prepare_stats_for_graph(podcast_example_data, 
#'                                          gvar = ep_number, hourly = TRUE) 
#' podlove_graph_download_curves(gdata, gvar = ep_number, cumulative = TRUE)
#' 
#' # absolute, daily plot by episode title, noncumulative, with labels at the beginning
#' gdata <- podlove_prepare_stats_for_graph(podcast_example_data, 
#'                                          gvar = title, relative = FALSE) 
#' podlove_graph_download_curves(gdata, gvar = title, cumulative = FALSE, 
#'                               labelmethod = "first.points")
#'                               
#' # abolute, hourly plot by podcast client name, cumulative
#' gdata <- podlove_prepare_stats_for_graph(podcast_example_data, 
#'                                          gvar = client_name, relative = FALSE) 
#' podlove_graph_download_curves(gdata, gvar = client_name, cumulative = TRUE)
#' }
#'
#' @importFrom ggplot2 ggplot aes
#' @importFrom graphics title
#'
#' @seealso podlove_prepare_stats_for_graph()
#' 
#' @export

podlove_graph_download_curves <- function(df_tidy_data,
                                          gvar = "Total",
                                          cumulative = TRUE,
                                          plot_type = "line", 
                                          labelmethod = "last.points",
                                          limit = TRUE,
                                          legend = FALSE,
                                          printout = TRUE,
                                          ...) {
  
  # construct graph (switcher for line vs ridge)
  
  if (plot_type == "line") {
    g_dl_curves <- podlove_baseplot(df_tidy_data, 
                                    gvar = {{gvar}}, 
                                    cumulative = cumulative,
                                    limit = limit,
                                    legend = legend,
                                    ...)
    
    # check if labelmethod exists, add it and expand the x axis
    labelmethods <- c("angled.boxes","first.bumpup","first.points","first.polygons","first.qp",
                      "lasso.labels","last.bumpup","last.points","last.polygons","last.qp",
                      "lines2","maxvar.points","maxvar.qp")
    
    if (labelmethod %in% labelmethods) {
      
      g_dl_curves <-  g_dl_curves +
        directlabels::geom_dl(aes(label = {{gvar}}), method = list(labelmethod, cex = 0.8))
      
      # select amount to expand x axis depending on direct label method
      exp_val = c(0,0)
      if (stringr::str_detect(labelmethod, "first")) exp_val <- c(0.3, 0.05)
      if (stringr::str_detect(labelmethod, "last")) exp_val <- c(0.05, 0.3)
      if (stringr::str_detect(labelmethod, "maxvar")) exp_val <- c(0.2, 0.2)
      
      # class switcher for type of x axis (Date or Continuous)
      # messages suppressed due to double scaling
      suppressMessages(
        if ("Date" %in% class(df_tidy_data$time)) {
          
          g_dl_curves <-  g_dl_curves +
            ggplot2::scale_x_date(expand = ggplot2::expand_scale(exp_val))
          
        } else if ("POSIXct" %in% class(df_tidy_data$time)) {
          
          g_dl_curves <-  g_dl_curves +
            ggplot2::scale_x_datetime(expand = ggplot2::expand_scale(exp_val))
          
        } else {
          
          g_dl_curves <-  g_dl_curves +
            ggplot2::scale_x_continuous(expand = ggplot2::expand_scale(exp_val))
        }
      )
      
    }
    
  } else if (plot_type == "ridge") {
    g_dl_curves <- podlove_baseplot_multi(df_tidy_data,
                                          gvar = {{gvar}},
                                          cumulative = cumulative,
                                          ...)
    
  } else stop("plot_type must be 'line' or 'ridge'.")
  
  
  if (printout) print(g_dl_curves)
  
  g_dl_curves
  
}

