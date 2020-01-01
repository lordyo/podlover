#' Create a sample Wordpress "podlove_mediafile" table
#'
#' This function generates a tibble with sample data corresponding to the Wordpress
#'     MySQL database table \code{wp_podlove_mediafile}. Since this table is only
#'     used to connect episodes to download intents, the number of mediafiles is the
#'     same as the number of episodes (in reality, there are more mediafiles than
#'     episodes, as changes to the mediafiles can be made after release). 
#'
#' @param df_episodes data frame with corresponding episodes
#' @param seed parameter to fix randomization via \code{set.seed()}
#'
#' @return a tibble with mediafile entries and corresponding columns
#'
#' @examples
#' # preparation: create posts & episodes 
#' example_posts <- podlove_create_example_posts(n_posts = 50,
#'                              start_date = "2018-10-25",
#'                              end_date = "2019-12-24")
#' 
#' example_eps <- podlove_create_example_episodes(n_episodes = 30, 
#'                                                df_posts = example_posts)
#'                                 
#' # create mediafiles
#' podlove_create_example_mediafiles(df_episodes = example_eps)
#' 
#' @export 

podlove_create_example_mediafiles <-
  function(df_episodes, seed = NULL) {
     
    if (!is.null(seed)) set.seed(seed)
    
    mediafiles <-
      tibble::tibble(
        id = seq(min(df_episodes$id), max(df_episodes$id)),
        episode_id = id,
        episode_asset_id = sample(1:3, nrow(df_episodes), prob = c(0.8, 0.15, 0.05), replace = TRUE),
        size = rnorm(nrow(df_episodes), mean = 30e6, sd = 10e6),
        etag = NA)
    
    mediafiles
  }
