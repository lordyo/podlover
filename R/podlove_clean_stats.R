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
#' @importFrom magrittr %>% 
#' @importFrom dplyr group_by summarize ungroup select mutate left_join filter
#' @importFrom lubridate ymd_hms ydm_h year month day date interval

podlove_clean_stats <- function(df_stats,
                                df_mediafile,
                                df_user,
                                df_episodes,
                                df_posts,
                                launch_date) {
  
  # clean reference data
  df_user <-
    select(df_user, id, client_name, client_type, os_name)
  df_episodes <-
    select(df_episodes, id, post_id, ep_number = number, title, duration) 
  df_posts <- select(df_posts, ID, post_date)
  df_mediafile <- df_mediafile %>%
    select(id, episode_id) %>%
    left_join(df_episodes, by = c("episode_id" = "id")) %>%
    select(-episode_id) %>%
    left_join(df_posts, by = c("post_id" = "ID")) %>%
    mutate(
      post_datetime = ymd_hms(post_date),
      post_datehour = lubridate::ymd_h(
        paste0(
          year(post_datetime), "-",
          month(post_datetime), "-",
          day(post_datetime), " ",
          lubridate::hour(post_datetime))),
      post_date = date(post_datetime)
    )

  # clean download data, join with ref data

  df_clean <- df_stats %>%
    select(id:media_file_id, dldatetime = accessed_at, source, context) %>%
    mutate(
      dldatetime = ymd_hms(dldatetime),
      dldate = date(dldatetime),
      weekday = lubridate::wday(dldatetime, label = TRUE),
      hour = lubridate::hour(dldatetime),
      dldatehour = lubridate::ymd_h(
        paste(year(dldatetime),
               month(dldatetime),
               day(dldatetime),
               lubridate::hour(dldatetime),
               sep = "-")))
  
  # filter for launchdate if parameter is not empty
  if (!is.null(launch_date)) filter(df_clean, dldate >= lubridate::ymd(launch_date))
  
  df_clean <- df_clean %>% 
    left_join(df_mediafile, by = c("media_file_id" = "id")) %>%
    left_join(df_user, by = c("user_agent_id" = "id")) %>%
    mutate(
      hours_since_release = round(interval(post_datetime, dldatetime) / lubridate::hours(1), 0),
      days_since_release = round(hours_since_release / 24, 0),
      ep_number = as.character(ep_number)) %>%
    select(
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
    summarize(dl_attempts = n()) %>%
    ungroup() %>% 
    filter(!is.na(title), !is.na(post_date))

    df_clean
    
  }