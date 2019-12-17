# PURPOSE
### Cleans and enriches raw podlove stats data

# INPUT
### df_stats: raw stats data as df
### df_mediafile: reference data on mediafiles
### df_user: reference data on user agents
### df_episodes: reference data on episodes

# OUTPUT
### df_clean: clean data frame
    
podlove_clean_stats <- function(df_stats, df_mediafile, df_user, df_episodes, df_posts) {
    
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
                 lubridate::hour,
                 sep = "-"))) %>%
      dplyr::filter(dldate >= lubridate::ymd(launch_date)) %>%
      dplyr::left_join(df_mediafile, by = c("media_file_id" = "id")) %>%
      dplyr::left_join(df_user, by = c("user_agent_id" = "id")) %>%
      dplyr::mutate(
        hours_since_release = round(interval(post_datetime, dldatetime) / lubridate::hours(1), 0),
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