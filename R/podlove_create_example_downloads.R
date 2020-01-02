#' Create Random Podcast Download Data for a Set of Episodes
#'
#' Lorem
#'
#' @param df_posts data frame with example posts
#'     (created by \code{podlove_create_example_posts()})
#' @param df_episodes data frame with example episodes
#'     (created by \code{podlove_create_example_episodes()})
#' @param df_mediafiles data frame with example mediafiles
#'     (created by \code{podlove_create_example_mediafiles()})
#' @param df_useragents edata frame with example mediafiles
#'     (created by \code{podlove_create_example_useragents()})
#' @param runtime minimum runtime of an episode in days. This parameter defines 
#'     the time difference between the release of the last episode and the last
#'     download to be generated.
#' @param dl_per_ep_day Downloads per episode and day throughout its runtime. 
#'     Be careful, this is a powerful parameter which will strongly increase the 
#'     size of your dataset. Use the following formula to estimate this parameter:
#'     dl_per_ep_day = (episodes \* total podcast runtime) / (2 \* total downloads)
#'     e.g. to create a set of 5000 downloads for 10 episodes over one year, use
#'     (10 eps \* 365 days) / (2 \* 5000 downloads) = 0.365 downloads per ep/day.
#' @param seed parameter to fix randomization via \code{set.seed()}
#'
#' @return a tibble with downloads per episode
#'
#' @examples
#' \dontrun{
#' test_posts <- podlove_create_example_posts(50, "2019-01-01", "2019-12-31")
#' test_episodes <- podlove_create_example_episodes(40, test_posts)
#' test_mediafiles <- podlove_create_example_mediafiles(test_episodes)
#' test_useragents <- podlove_create_example_useragents(100)
#'  
#' test_downloads <- podlove_create_example_downloads(test_posts,
#'                                                   test_episodes,
#'                                                   test_mediafiles,
#'                                                   test_useragents,
#'                                                   runtime = 100, 
#'                                                   dl_per_ep_day = 0.93)
#' }
#' 
#' @export 

podlove_create_example_downloads <- function(df_posts,
                                             df_episodes,
                                             df_mediafiles,
                                             df_useragents,
                                             runtime,
                                             dl_per_ep_day,
                                             seed) {
  
  # get episode numbers and relesase dates
  episodes <- df_mediafiles %>% 
    dplyr::left_join(df_episodes, by = c("episode_id" = "id")) %>% 
    dplyr::left_join(df_posts, by = c("post_id" = "ID")) %>% 
    dplyr::select(mediafile_id = id, start_date = post_date)
  
  # get earliest and latest release date, calculate latest download date,
  # calculate difference between those dates in seconds
  podcast_start <- min(episodes$start_date)
  podcast_end <- max(episodes$start_date) + lubridate::days(runtime)
  podcast_runtime <- as.numeric(lubridate::interval(podcast_start, podcast_end))
  
  # fill parameter lists
  mf_ids <-   episodes$mediafile_id
  ep_startdates <- episodes$start_date
  ep_enddates <- rep(podcast_end, nrow(episodes))
  # ep_enddates <- episodes$start_date + podcast_runtime
  ep_runtime <- 
    as.numeric(lubridate::interval(ep_startdates, ep_enddates)) / as.numeric(lubridate::duration(1, "days"))
  ep_dls <- round(ep_runtime * dl_per_ep_day, 0)
  
  param_list <- list(media_file_id = mf_ids,
                     dl_startdate = ep_startdates,
                     dl_enddate = ep_enddates,
                     n_dls = ep_dls)
  
  # map parameter list onto create_example_dl_ep to get a dataframe with 
  # download times for all episodes
  downloads <- purrr::pmap_df(.l = param_list,
                              .f = podlove_create_example_dl_ep)
  
  #### some preparation before continuing ###################################
  
  # get number of all downloads
  n_total_dls <- nrow(downloads)
  
  # helper function to create random hex strings (for request_id)
  randhex <- function(n_chars) {
    paste(sample(c(0:9, letters[1:6]), n_chars, TRUE), collapse = "")
  }
  
  # helper df for source-context combinations (for source and context)
  contexts <- tibble::tibble(
    context_id = 1:5,
    source = c(rep("feed", 3), "opengraph", "webplayer"),
    context = c("mp3", "m4a", "ogg", rep("episode", 2))
  )
  
  #### end preparation ######################################################
  
  downloads <- downloads %>%
    
    # sample from available useragents
    dplyr::mutate(user_agent_id = sample(df_useragents$id,
                                         n_total_dls, 
                                         replace = TRUE,
                                         prob = wakefield::probs(nrow(df_useragents)))) %>% 
    # generate random request_ids
    dplyr::rowwise() %>% 
      dplyr::mutate(request_id = randhex(32)) %>% 
    dplyr::ungroup() %>%
    
    # join the release dates from the mediafile df and calculate download times
    dplyr::left_join(episodes, by = c("media_file_id" = "mediafile_id")) %>% 
    dplyr::mutate(accessed_at = start_date + access_time,
                  source_context = sample(contexts$context_id,
                                          n_total_dls,
                                          replace = TRUE,
                                          prob = wakefield::probs(nrow(contexts)))) %>%
    
    # sort by download date (for correct id generation)
    dplyr::arrange(accessed_at) %>% 
    
    # join the helper sources / contexts df
    dplyr::left_join(contexts, by = c("source_context" = "context_id")) %>% 
    
    # generate remaining variables (no geo data in this version)
    dplyr::mutate(id = dplyr::row_number(),
                  geo_area_id = NA,
                  lat = NA, 
                  lng = NA,
                  httprange = NA,
                  hours_since_release = 
                    floor(lubridate::interval(start_date, accessed_at) / lubridate::hours(1))) %>% 
    # cleanup variables
    dplyr::select(id, 
                  user_agent_id,
                  media_file_id, 
                  request_id, 
                  accessed_at, 
                  source, 
                  context, 
                  geo_area_id, 
                  lat, 
                  lng, 
                  httprange, 
                  hours_since_release)
  
  downloads
}

