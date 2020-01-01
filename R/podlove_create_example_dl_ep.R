#' Create Random Podcast Download Data for One Episode
#'
#' This function generates a tibble with ficticious download data for one podcast
#'     episode. It is the core helper function for \code{podlove_create_example_downloads}.
#'     The function generates three kinds of data: a lognormal (long-tail) curve,
#'     a uniform (noise) curve, and several normal distributed peaks. All three
#'     distributions are mixed to provide approximate download simulation data.
#'
#' @param n_dls number of downloads (rows) to generate
#' @param dl_startdate start date+time of downloads (episode release), formated as
#'     a ymd string (e.g. "2019-01-31 12:31")
#' @param dl_enddate last download date+time
#' @param media_file_id id of the related media file
#' @param seed parameter to fix randomization via \code{set.seed()}
#'
#' @return a tibble with n_dl download times in seconds after release
#'
#' @examples
#' podlove_create_example_dl_ep(n_dls = 1000,
#'                              dl_startdate = "2019-01-01",
#'                              dl_enddate = "2019-12-31",
#'                              media_file_id = 105)
#' 
#' @importFrom stats rlnorm rnorm runif
#' 
#' @export 

podlove_create_example_dl_ep <-  function(n_dls,
           dl_startdate,
           dl_enddate,
           media_file_id,
           seed = NULL) {
    
    if (!is.null(seed)) set.seed(seed)
    
    # strings as dates
    dl_startdate <- lubridate::ymd_hms(dl_startdate)
    dl_enddate <- lubridate::ymd_hms(dl_enddate)
    
    # interval in seconds as numeric
    runtime <- lubridate::interval(dl_startdate, dl_enddate) %>% 
      as.numeric()
    
    # set distribution of downloads
    n_ln <- round(n_dls * 0.7, 0) # number of downloads assigned to lognorm curve
    n_un <- round(n_dls * 0.1, 0) # ... to uniform curve
    n_pk <- round(n_dls * 0.2, 0) # ... to random peaks
    
    # create random lognorm-distributed downloads
    # (these create the long-tail curve of subscribers) 
    dl_ln <- tibble::tibble(
      y = rlnorm(n_ln, 0, sqrt(log(n_ln))))
    
    # get the max integer of the lognorm sample 
    max_ln <- floor(max(dl_ln$y))
    
    # create random uniform downloads (spontaneous tune-in listeners over time)
    dl_un <- tibble::tibble(
      y = runif(n_un, 0, max_ln))
      
    create_peak <- function(n_values, max_y) {
      # helper function to create one random normal distributed peak
      # (viral tune-ins)
      pk <- tibble::tibble(
        y = rnorm(n = n_values,
                  mean = sample(1:max_y, 1),
                  sd = sample(1:(sqrt(max_y)/3), 1))) %>%
        dplyr::filter(y > 0)
      pk
    }
    
    
    # create a random amount of random peaks
    n_peaks <- round(sqrt(n_dls) / 2, 0)
    peak_points <- sample(1:max_ln, size = n_peaks)
    peak_dist <- n_pk * wakefield::probs(n_peaks)
    
    dl_pk <- purrr::map_df(.x = peak_dist,
                           .f = create_peak,
                           max_y = max_ln)
    
    # bind all three distributions together
    downloads <- dplyr::bind_rows(dl_ln, dl_un, dl_pk)
    
    # calculate ratio for mapping y to time values
    b <- max(downloads$y) / runtime
    
    # sort values, add episode id, calculate time values, remove y
    downloads <- downloads %>%
      dplyr::arrange(y) %>%
      mutate(media_file_id = media_file_id,
             access_time = lubridate::as.period(y / b) / lubridate::seconds(1)) %>% 
      # mutate(media_file_id = media_file_id,
      #        access_time = lubridate::as.period(y / b) / lubridate::hours(1)) %>% 
      select(-y)
    
    downloads

  }