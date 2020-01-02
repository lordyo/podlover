#' Create a sample Wordpress "podlove_useragent" table
#'
#' This function generates a tibble with sample data corresponding to the Wordpress
#'     MySQL database table \code{wp_podlove_useragent}. 
#'
#' @param n_useragents number of posts (rows) to generate. can't be higher than
#'                     the number of entries in \code{df_ua_list}.  
#' @param df_ua_list data frame with possible user agent combinations. defaults to
#'                   the in-built data set \code{podcast_example_useragents}
#' @param seed parameter to fix randomization via \code{set.seed()}
#'
#' @return a tibble with n_useragents rows
#'
#' @examples
#' \dontrun{
#' # random useragent list 
#' example_useragents <- podlove_create_example_useragents(n_useragents = 100)
#' }
#' 
#' @export 

podlove_create_example_useragents <-
  function(n_useragents, df_ua_list = podcast_example_useragents, seed = NULL) {
    
    # set seed if given
    if (!is.null(seed)) set.seed(seed)
    
    #error handling n_useragents
    if (n_useragents > nrow(df_ua_list)) {
      stop(paste0("n_useragents can't be higher than ", nrow(df_ua_list), "."))
    }
    
    # construct table
    useragents <-
      tibble::tibble(
        # sample some ids from the user agent reference list      
        id = sample(df_ua_list$id, n_useragents, replace = FALSE),
      ) %>%
      # attach the reference list
      dplyr::left_join(df_ua_list, by = "id") %>% 
      # renumber
      dplyr::mutate(id = dplyr::row_number())
    
    useragents
  }