#' Podlover: Selection of real-wolrd podcast user agents
#'
#' A collection of unique user agents accessing podcast data, sampled from two
#'     existing podcasts over 4 years. User agents are combinations of devices,
#'     clients, and OS which attempt to download podcast audio files. This list
#'     can be used to sample user agents for the generation of sample podcast 
#'     data.
#'
#' @format A data frame with 52516 rows and 10 variables:
#' \describe{
#'   \item{id}{user agent ID}
#'   \item{user agent}{full name of the user agent}
#'   \item{bot}{duration of the episode in minutes:seconds.deciseconds}
#'   \item{client_name}{episode publish date in YYYY-MM-DD}
#'   \item{client_version}{episode publish date and hour in YYYY-MM-DD HH:MM:SS}
#'   \item{client_type}{interval between episode release and corresponding
#'         donwload attempt in hours, rounded to hours}
#'   \item{os_name}{interval between episode release and corresponding
#'         donwload attempt in days, rounded to days}
#'   \item{os_version}{download source, feed or webplayer}
#'   \item{device_brand}{download context, for feeds: file type, for webplayer: episode}
#'   \item{device_mode}{download date in YYYY-MM-DD}
#' }
#' @source Combination of user agents of two podcasts over 4 years
"podcast_example_useragents"