#' Connect and clean podcast and reference data
#' 
#' \code{podlove_clean_stats} takes podcast download and various reference
#' data to create a tidy set of download attempts. The reference data consists 
#' of the tables for podlove episodes (\code{df_episodes}), blog posts 
#' (\code{df_posts}), user agents (\code{df_user}) and media files
#' (\code{df_mediafile}).
#' 
#' @param df_stats contents of the MySQL table \code{wp_podlove_downloadintentclean}
#' @param df_mediafile contents of the MySQL table \code{wp_podlove_downloadintentclean}
#' @param df_user contents of the MySQL table \code{wp_podlove_useragent} 
#' @param df_episodes contents of the MySQL table \code{wp_podlove_episode}
#' @param df_posts contents of the MySQL table \code{wp_posts}
#' @param launch_date date of the first official podcast episode release,
#' defaults to date of first download attempt (which may be before the first
#' episode was released)
#' 
#' @return a dataframe containing all episode download attempts
#' 
#' @examples
#' \dontrun{
#' podlove_clean <- podlove_clean_stats(df_stats = table_stats,
#'                                      df_mediafile = table_mediafile,
#'                                      df_user = table_useragent,
#'                                      df_episodes = table_episodes,
#'                                      df_posts = table_posts,
#'                                      launch_date = "2017-12-04")
#'                                      }
    
podlove_clean_stats <- function(df_stats,
                                df_mediafile,
                                df_user,
                                df_episodes,
                                df_posts,
                                launch_date) {
    
  if (is.null(launch_date)) {
    launch_date <- min(lubridate::ymd_hms(post_date))
  }
  
  # clean reference data
  df_user <-
    dplyr::select(df_user, id, client_name, client_type, os_name)
  df_episodes <-
    dplyr::select(df_episodes, id, post_id, ep_number = number, title, duration)
  df_posts <- dplyr::select(df_posts, ID, post_date)
  df_mediafile <- df_mediafile %>%
    dplyr::select(id, episode_id) %>%
    dplyr::left_join(df_episodes, by = c("episode_id" = "id")) %>%
    dplyr::select(-episode_id) %>%
    dplyr::left_join(df_posts, by = c("post_id" = "ID")) %>%
    dplyr::mutate(
      post_datetime = lubridate::ymd_hms(post_date),
      post_datehour = lubridate::ymd_h(
        paste0(
          lubridate::year(post_datetime), "-",
          lubridate::month(post_datetime), "-",
          lubridate::day(post_datetime), " ",
          lubridate::hour(post_datetime))),
      post_date = lubridate::date(post_datetime)
    )

  # clean download data, join with ref data

  df_clean <- df_stats %>%
    dplyr::select(id:media_file_id, dldatetime = accessed_at, source, context) %>%
    dplyr::mutate(
      dldatetime = lubridate::ymd_hms(dldatetime),
      dldate = lubridate::date(dldatetime),
      weekday = lubridate::wday(dldatetime, label = TRUE),
      hour = lubridate::hour(dldatetime),
      dldatehour = lubridate::ymd_h(
        paste(lubridate::year(dldatetime),
               lubridate::month(dldatetime),
               lubridate::day(dldatetime),
               lubridate::hour(dldatetime),
               sep = "-"))) %>%
    dplyr::filter(dldate >= lubridate::ymd(launch_date)) %>%
    dplyr::left_join(df_mediafile, by = c("media_file_id" = "id")) %>%
    dplyr::left_join(df_user, by = c("user_agent_id" = "id")) %>%
    dplyr::mutate(
      hours_since_release = round(lubridate::interval(post_datetime, dldatetime) / lubridate::hours(1), 0),
      days_since_release = round(hours_since_release / 24, 0),
      ep_number = as.integer(ep_number)) %>%
    dplyr::select(
      ep_number,
      title,
      duration,
      post_date,
      post_datehour,
      hours_since_release,
      days_since_release,
      source,
      context,
      dldate,
      dldatehour,
      weekday,
      hour,
      client_name,
      client_type,
      os_name) %>%
    dplyr::group_by_all() %>%
    dplyr::summarize(dl_attempts = n()) %>%
    dplyr::ungroup()

    df_clean
    
  }