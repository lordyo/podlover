#' Download attempts of a fictional podcast
#'
#' A dataset of (clean) download data of a fictional podcast with 5 episodes 
#'     over a period of 4 months
#'
#' @format A data frame with 552 rows and 17 variables:
#' \describe{
#'   \item{ep_number}{episode number, as string}
#'   \item{title}{episode title}
#'   \item{duration}{duration of the episode in minutes:seconds.deciseconds}
#'   \item{post_date}{episode publish date in YYYY-MM-DD}
#'   \item{post_datehour}{episode publish date and hour in YYYY-MM-DD HH:MM:SS}
#'   \item{hours_since_release}{interval between episode release and corresponding
#'         donwload attempt in hours, rounded to hours}
#'   \item{days_since_release}{interval between episode release and corresponding
#'         donwload attempt in days, rounded to days}
#'   \item{source}{download source, feed or webplayer}
#'   \item{context}{download context, for feeds: file type, for webplayer: episode}
#'   \item{dldate}{download date in YYYY-MM-DD}
#'   \item{dldatehour}{download date and time in YYYY-MM-DD HH:MM:SS, rounded
#'         to full hours}
#'   \item{weekday}{download weekday as number >> TO BE CORRECTED WITH LABEL}
#'   \item{hour}{download hour as integer}
#'   \item{client_name}{download client name, e.g. browser or podcatcher name}
#'   \item{client_type}{download client type, e.g. mobile app, browser}
#'   \item{os_name}{operating system name, e.g. Android, iOS, Linux}
#'   \item{dl_attemps}{number of attempted downloads by the same user agent}
#' }
#' @source Constructed, fictional data
"podcast_example_data"