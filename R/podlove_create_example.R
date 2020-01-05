#' Create Podcast Example Data
#'
#' This is a wrapper function to easily create example podcast download tables
#'     or a clean set of download data. 
#'
#' @param n_posts Number of posts to generate (defaults to 15)
#' @param n_episodes Number of episodes to generate (defaults to 12, must be 
#'     lower or equal than n_posts)
#' @param n_useragents Number of useragents to sample from (defaults to 100) 
#' @param start_date Podcast start date
#' @param end_date Podcast end date
#' @param runtime minimum runtime of an episode in days. This parameter defines 
#'     the time difference between the release of the last episode and the last
#'     download to be generated.
#' @param total_dls Total downloads to be generate. Defaults to 5000. Approximate value.
#' @param clean Switcher: if `TRUE`, cleans the data,
#'     if `FALSE`, returns a list of tables
#' @param seed parameter to fix randomization via \code{set.seed()}
#' 
#' @return A list of 5 named tables or a cleaned dataframe of downloads 
#'  
#' @examples 
#' # create tables for ~10000 downloads
#' test_list <- podlove_create_example(total_dls = 10000)
#' 
#' # create clean podcast data
#' test_df <- podlove_create_example(total_dls = 10000, clean = TRUE)
#' 
#' @export

podlove_create_example <- function(n_posts = 15,
                                   n_episodes = 10,
                                   n_useragents = 100,
                                   start_date = "2019-01-01",
                                   end_date = "2019-12-31",
                                   runtime = 30,
                                   total_dls = 5000,
                                   clean = FALSE,
                                   seed = NULL) {
  # set seed if given
  if (!is.null(seed)) set.seed(seed)
  
  total_runtime <- lubridate::interval(lubridate::ymd(start_date), lubridate::ymd(end_date)) / lubridate::days(1) + runtime
  dl_per_ep_day <- (2 * total_dls) / (n_episodes * total_runtime) 
  
  
  posts <- podlove_create_example_posts(n_posts,
                                        start_date,
                                        end_date,
                                        seed = seed)
  
  episodes <- podlove_create_example_episodes(n_episodes, 
                                              posts,
                                              seed = seed)
  
  mediafiles <- podlove_create_example_mediafiles(episodes,
                                                  seed = seed)
  
  useragents <- podlove_create_example_useragents(n_useragents,
                                                  seed = seed)
  
  downloads <- podlove_create_example_downloads(posts,
                                                episodes,
                                                mediafiles,
                                                useragents,
                                                runtime = runtime, 
                                                dl_per_ep_day = dl_per_ep_day,
                                                seed = seed)
  
  if (clean) {
    
    out <- podlove_clean_stats(df_stats = downloads,
                              df_mediafile = mediafiles,
                              df_user = useragents,
                              df_episodes = episodes,
                              df_posts = posts)
    
    
  } else {
  
    out <- list(posts = posts,
                     episodes = episodes,
                     mediafiles = mediafiles,
                     useragents = useragents,
                     downloads = downloads)
  
  }
  
  out
  
}