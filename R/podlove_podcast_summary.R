#' Summarize Podcast data
#'
#' Calculates, returns and optionally downloads per episode
#'     `downloads_per_episode_5num`: five-number summary of downloads per episode
#'     `downloads_per_day_mean`: average downloads per day
#'     `downloads_per_day_5num`: five-number summary of downloads per day
#' 
#' @examples 
#' #create sample data
#' dls <- podlove_create_example(clean = TRUE)
#' 
#' #get summary
#' dls_summary <- podlove_podcast_summary(dls) 
#' 
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by summarize ungroup select mutate left_join filter
#' @importFrom lubridate ymd_hms ydm_h year month day date interval
#' 
#' @export

podlove_podcast_summary <- function(df_tidy_data,
                                    verbose = TRUE,
                                    return_params = FALSE) {
  
  # episodes
  
  n_ep <- df_tidy_data %>% 
    select(ep_num_title) %>%
    dplyr::distinct() %>% 
    summarize(n = n()) %>% 
    as.numeric()
  
  ep_first_date <- min(df_tidy_data$post_datehour)
  ep_last_date  <- max(df_tidy_data$post_datehour)
  rt  <- lubridate::interval(ep_first_date, ep_last_date)
  runtime <- lubridate::as.period(rt)
  
  ep_interval <- lubridate::as.duration(ep_last_date - ep_first_date) / n_ep
  
  # downloads
  
  n_dl <- nrow(df_tidy_data)
  dl_ep <- n_dl / n_ep
  
  dl_ep_5num <- df_tidy_data %>%
    group_by(ep_num_title) %>%
    summarize(n = n())
  
  dl_ep_5num <- fivenum(dl_ep_5num$n)
  
  dl_day_5num <- df_tidy_data %>%
    group_by(dldate) %>%
    summarize(n = n())
  
  dl_day_5num <- fivenum(dl_day_5num$n)
  
  dl_first_date <- min(df_tidy_data$dldatehour)
  dl_last_date <- max(df_tidy_data$dldatehour)
  dl_period <- lubridate::as.duration(dl_last_date - dl_first_date)
  
  dl_day <- n_dl / as.numeric(dl_period) * as.numeric(lubridate::days(1))
  
  # printout
  
  if (verbose) {
  
    msg = paste0("'", deparse(substitute(df_tidy_data)), "': \n\n",
                 
                 "A podcast with ", n_ep, " episodes, released between ",
                 lubridate::as_date(ep_first_date), " and ", 
                   lubridate::as_date(ep_last_date), ".\n\n",
                 
                 "Total runtime:  ", runtime, ".\n",
                 "Average time between episodes: ", ep_interval, ".\n\n",
                 
                 "Episodes were downloaded ", n_dl, " times between ", 
                   lubridate::as_date(dl_first_date), " and ", 
                   lubridate::as_date(dl_last_date), ".\n",
                 
                 ifelse(dl_first_date < ep_first_date,
                        "(Note: first download lies before release of first episode)\n\n",
                        "\n"), 
                 
                 "Downloads per episode: ", round(dl_ep, 1), "\n",
                 "min: ", dl_ep_5num[1],
                   " | 25p: ", dl_ep_5num[2],
                   " | med: ", dl_ep_5num[3],
                   " | 75p: ", dl_ep_5num[4],
                   " | max: ", dl_ep_5num[5], "\n\n", 
                 
                 "Downloads per day: ", round(dl_day, 1), "\n",
                 "min: ", dl_day_5num[1],
                   " | 25p: ", dl_day_5num[2],
                   " | med: ", dl_day_5num[3],
                   " | 75p: ", dl_day_5num[4],
                   " | max: ", dl_day_5num[5] 
                 )
    
    message(msg)
    
  }
  
  
  # output
 
  if (return_params) {
   
  out <- list(n_episodes = n_ep,
                   ep_first_date = ep_first_date,
                   ep_last_date = ep_last_date,
                   runtime = runtime,
                   ep_interval = ep_interval,
                   n_downloads = n_dl,
                   dl_first_date = dl_first_date,
                   dl_last_date = dl_last_date,
                   downloads_per_episode_mean = dl_ep,
                   downloads_per_episode_5num = dl_ep_5num,
                   downloads_per_day_mean = dl_day,
                   downloads_per_day_5num = dl_day_5num) 
  } else {
    
    out = NULL 
    
  }
  
  out
}

