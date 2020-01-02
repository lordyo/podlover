#' Create a sample Wordpress "podlove_episodes" table
#'
#' This function generates a tibble with sample data corresponding to the Wordpress
#'     MySQL database table \code{wp_podlove_episodes}. 
#'
#' @param n_episodes number of posts (rows) to generate
#' @param df_posts data frame with corresponding posts
#' @param seed parameter to fix randomization via \code{set.seed()}
#'
#' @return a tibble with n_episodes episode entries and corresponding columns
#'
#' @examples
#' # preparation: create posts 
#' example_posts <- podlove_create_example_posts(n_posts = 50,
#'                              start_date = "2018-10-25",
#'                              end_date = "2019-12-24")
#' 
#' # random posts episodes based
#' podlove_create_example_episodes(n_episodes = 30, 
#'                                 df_posts = example_posts)
#' 
#' @export 

podlove_create_example_episodes <-
  function(n_episodes, df_posts, seed = NULL) {
   
    #helper function to pad numbers
    pad_num <- function(num, padding) {
      padded <- formatC(num,
                        width = padding,
                        format = "d",
                        flag = "0")
      padded
    }
    
    # set seed if given 
    if (!is.null(seed)) set.seed(seed)
    
    # construct random slug (three-letter abbreviation) for the podcast
    slug_base = paste0(sample(letters, 3, replace = TRUE), collapse = "")
    
    # build table
    posts <-
      tibble::tibble(
        # get random posts
        post_id = sample(df_posts$ID, n_episodes, replace = FALSE),
        # no subtitles, lipsum description text
        subtitle = rep(NA, n_episodes),
        summary = wakefield::lorem_ipsum(n_episodes),
        # random epside type with fixed probabilities
        type = sample(c("full", "trailer", "bonus"),
                      n_episodes, 
                      prob = c(0.9, 0.025, 0.075), 
                      replace = TRUE),
        # not used
        enable = rep(NA, n_episodes),
        # random duration with padding 
        duration = paste0("00:",
                          pad_num(floor(rnorm(n_episodes, 30, 10)), 2),
                          ":", 
                          pad_num(floor(runif(n_episodes, 0, 59)), 2), 
                          ".",
                          pad_num(floor(runif(n_episodes, 0, 999)), 2)),
        # not used
        cover_art = rep(NA, n_episodes),
        chapters = rep(NA, n_episodes),
        recording_date = rep(NA, n_episodes),
        explicit = rep(NA, n_episodes),
        license_name = rep(NA, n_episodes),
        license_url = rep(NA, n_episodes)
      ) %>% 
      # attach post titles
      dplyr::left_join(select(df_posts, post_id = ID, title = post_title)) %>%
      # sort by post number for correct id
      dplyr::arrange(post_id) %>% 
      # id, number, slug
      dplyr::mutate(id = dplyr::row_number(),
                    number = id,
                    slug = paste0(slug_base, "-", id)) %>%
      # field cleanup
      select(id, post_id, title, subtitle, summary, number, type, enable, slug, 
             duration, cover_art, chapters, recording_date, explicit, 
             license_name, license_url)
    
    posts
  }
