#' Caluclate download regression
#'
#' This function takes data from a \code{podlove_downloads_until()} and calculates
#'     a regression model with downloads as outcome variable. This allows to find
#'     out if the podcast gains or loses listeners over successive episodes.  
#'
#' Details
#'
#' @param df_regression_data a tidy data table created by \code{podlove_downloads_until()}.
#'     Note that this function should not be fed data including more than one \code{point_in_time}
#'     unless vectorized. 
#' @param terms terms (predictors) of the linear model as string. Usually
#'     contains at least one time or order based variable such as \code{post_date},
#'     \code{post_datehour} (default), \code{episode_age_hours}/\code{episode_age_days}
#'     (note: age decreases with episodes!) or \code{episode_rank}. This parameter can
#'     also include multiple variables for more advanced models. See \code{?lm} for more
#'     information.
#' @param printout switcher to print out the model's summary after calculation.     
#' 
#' @return a linear reression model created by \code{lm()}.
#' 
#' @examples 
#' \dontrun{
#' # linear regression for downloads on day 3 by episode release date
#' dl <- podlove_downloads_until(podcast_example_data, points_in_time = 3)
#' podlove_episode_regression(dl, terms = "post_datehour")
#' }
#' 
#' @export

podlove_episode_regression <- function(df_regression_data,
                                       terms = "post_datehour",
                                       printout = TRUE) {
  
  episode_model <- stats::lm(stats::reformulate(terms, response = "downloads"), 
                            data = df_regression_data)
  
  if (printout) summary(episode_model)
  
  episode_model
}
