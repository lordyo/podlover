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
                                          printout = TRUE,
                                          ...) {
  
  # construct graph (switcher for line vs ridge)
  
  if (plot_type == "line") {
    g_dl_curves <- podlove_baseplot(df_tidy_data, 
                                    gvar = {{gvar}}, 
                                    cumulative = cumulative,
                                    ...)
    g_dl_curves <-  g_dl_curves +
      directlabels::geom_dl(aes(label = {{gvar}}), method = list(labelmethod, cex = 0.8))
    
  } else if (plot_type == "ridge") {
    g_dl_curves <- podlove_baseplot_multi(df_tidy_data,
                                          gvar = {{gvar}},
                                          cumulative = cumulative,
                                          ...)
    
  } else stop("plot_type must be 'line' or 'ridge'.")
  
  
  if (printout) print(g_dl_curves)
  
  g_dl_curves
  
}

