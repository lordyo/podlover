#' TITLE
#'
#' Description
#'
#' Details
#'
#' @param lorem Ipsum
#' 
#' @return Dolor
#' 
#' @examples 
#' 1
#' 
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by summarize ungroup select mutate left_join filter
#' @importFrom lubridate ymd_hms ydm_h year month day date interval
#' 
#' @export

podlove_episode_regression <- function(df_regression_data, terms = "post_datehour") {
  
  formula_string <- paste0("downloads ~ ", terms)
  
  episode_model <- lm(formula = formula_string,
                      data = df_regression_data)
  
}
