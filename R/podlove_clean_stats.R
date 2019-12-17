podlove_clean_stats <- function(df_stats, df_mediafile, df_user, df_episodes, df_posts) {
  
  # PURPOSE
  ### Cleans and enriches raw podlove stats data 
  
  # INPUT
  ### df_stats: raw stats data as df
  ### df_mediafile: reference data on mediafiles
  ### df_user: reference data on user agents
  ### df_episodes: reference data on episodes
  
  # OUTPUT
  ### df_clean: clean data frame
  
  # clean reference data
  df_user <- select(df_user, id, client_name, client_type, os_name)
  df_episodes <- select(df_episodes, id, post_id, ep_number = number, title, duration)
  df_posts <- select(df_posts, ID, post_date)
  df_mediafile <- df_mediafile %>% 
    select(id, episode_id) %>% 
    left_join(df_episodes, by = c("episode_id" = "id")) %>% 
    select(-episode_id) %>% 
    left_join(df_posts, by = c("post_id" = "ID")) %>% 
    mutate(post_datetime = ymd_hms(post_date),
           post_datehour = ymd_h(paste0(year(post_datetime), "-", month(post_datetime), "-", day(post_datetime), " ", hour(post_datetime))),
           post_date = date(post_datetime))
  
  # clean download data, join with ref data 
  
  df_clean <- df_stats %>%
    select(id:media_file_id, dldatetime = accessed_at, source, context) %>%
    mutate(dldatetime = ymd_hms(dldatetime),
           dldate = date(dldatetime),
           weekday = wday(dldatetime, label = TRUE),
           hour = hour(dldatetime),
           dldatehour = ymd_h(paste(year(dldatetime), month(dldatetime), day(dldatetime), hour, sep = "-"))) %>%
    filter(dldate >= ymd(launch_date)) %>% 
    left_join(df_mediafile, by = c("media_file_id" = "id")) %>%
    left_join(df_user, by = c("user_agent_id" = "id")) %>% 
    mutate(hours_since_release = round(interval(post_datetime, dldatetime) / hours(1), 0),
           days_since_release = round(hours_since_release / 24, 0),
           ep_number = as.integer(ep_number)) %>% 
    select(ep_number, title, duration, post_date, post_datehour, hours_since_release, days_since_release, source, 
           context, dldate, dldatehour, weekday, hour, client_name, client_type, os_name) %>% 
    group_by_all() %>%
    summarize(dl_attempts = n()) %>%
    ungroup()

  df_clean

}