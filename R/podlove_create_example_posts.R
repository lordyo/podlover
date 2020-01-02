#' Create a sample Wordpress "posts" table
#'
#' This function generates a tibble with sample data corresponding to the Wordpress
#'     MySQL database table \code{wp_posts}. 
#'
#' @param n_posts number of posts (rows) to generate
#' @param start_date first post's publish date
#' @param end_date last post's publish date
#' @param seed parameter to fix randomization via \code{set.seed()}
#'
#' @return a tibble with n_posts post entries and corresponding columns
#'
#' @examples
#' # random posts
#' podlove_create_example_posts(n_posts = 20,
#'                              start_date = "2018-10-25",
#'                              end_date = "2019-12-24")
#' 
#' # random posts with fixed seed (try several times to see the results are equal)
#' podlove_create_example_posts(n_posts = 20, 
#'                              start_date = "2018-10-25", 
#'                              end_date = "2019-12-24",
#'                              seed = 10)
#' 
#' @export 

podlove_create_example_posts <-
  function(n_posts, start_date, end_date, seed = NULL) {
   
    # set seed if given 
    if (!is.null(seed)) set.seed(seed)
    
    # start and end dates to timedates
    start_date = lubridate::ymd_hms(paste0(start_date, " 00:00:01"))
    end_date = lubridate::ymd_hms(paste0(end_date, " 23:59:59"))
    # average interval between posts
    post_interval = (lubridate::interval(start_date, end_date) / (n_posts - 1)) / lubridate::days(1)
    
    # construct table 
    posts <-
      tibble::tibble(
        # post id
        ID = 1:n_posts,
        # pick random one of three author ids
        post_author = sample(1:3, n_posts, replace = TRUE, prob = wakefield::probs(3)),
        # jitter post dates to create deviations from average interval
        post_date = lubridate::as_datetime(
          seq(
            length.out = n_posts,
            from = start_date,
            to = end_date) + rnorm(n_posts, mean = 0, sd = post_interval / 3)),
        post_date_gmt = post_date,
        # lipsum conent
        post_content = wakefield::lorem_ipsum(n_posts),
        # # random baby names as post titles
        # post_title = wakefield::name(n_posts),
        # random Wikipedia article titles as titles
        post_title = sample(wp_featured_articles$article, n_posts, replace = FALSE),
        # excerpt same as conten 
        post_excerpt = post_content,
        # statuses fixed
        post_status = rep("publish", n_posts),
        comment_status = rep("closed", n_posts),
        ping_status = rep("closed", n_posts),
        # not used
        post_password = rep("", n_posts),
        post_name = post_title,
        to_ping = rep("", n_posts),
        pinged = rep("", n_posts),
        # modification = publish
        post_modified = post_date,
        post_modified_gmt = post_date,
        # not used
        post_content_filtered = rep("", n_posts),
        post_parent = rep(0, n_posts),
        # URL from date and title
        guid = paste0(
          "https://fakeurl",
          wakefield::name(n_posts),
          wakefield::name(n_posts),
          ".pod/",
          lubridate::year(post_date),
          "/",
          lubridate::month(post_date),
          "/",
          lubridate::day(post_date),
          "/", post_title),
        # not used
        menu_order = rep(0, n_posts),
        post_type = rep("podcast", n_posts),
        post_mime_type = rep("", n_posts),
        comment_count = rep(0, n_posts)
      )
    
    posts
  }
