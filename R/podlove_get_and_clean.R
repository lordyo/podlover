#' Fetch and prepare all download data
#' 
#' \code{podlove_get_and_clean} opens up a connection to a Podlove-enable 
#' Wordpress MySQL database, gets all necessary tables, connects and cleans
#' the data and returns it as a data frame. The function uses
#' \code{rstudioapi::askForSecret()}, which allows securely storing access 
#' info in the local keyring.
#'    
#' @param db_name name of the database
#' @param db_host hostname of the database
#' @param db_user username of the database 
#' @param db_password password of the database
#' @param launch_date date of the first official podcast episode release
#' 
#' @return a dataframe containing all episode download attempts
#' 
#' @examples
#' \dontrun{
#' # will ask for db name, host, username, password
#' dlic_raw <- podlove_get_and_clean(launchdate = "2019-05-01")
#' }
#' \dontrun{
#' dlic_raw <- podlove_get_and_clean(dbname = "my_sql_database",
#'                                   host = "my.database.host",
#'                                   user = "username,"
#'                                   password = "my.secret.password",
#'                                   launchdate = "2019-05-01")
#' }
#' 
#' @importFrom magrittr %>% 


podlove_get_and_clean <- function(db_name = rstudioapi::askForSecret(name = "dbname"),
                                  db_host = rstudioapi::askForSecret(name = "host"),
                                  db_user = rstudioapi::askForSecret(name = "user"),
                                  db_password = rstudioapi::askForSecret(name = "password"),
																	launch_date = NULL)  {
  
  # define which tables to fetch
  
  tbl_names <-	c("wp_podlove_downloadintentclean",
      						"wp_podlove_mediafile",
      						"wp_podlove_useragent",
      						"wp_podlove_episode",
    							"wp_posts")

  # set names of resulting data frames
  
	df_names <- c("db_stats",
								"db_ref_media",
								"db_ref_user",
								"db_ref_episodes",
								"db_ref_posts")

	# open connection
	
  podlove_db <- RMySQL::dbConnect(RMySQL::MySQL(),
                          user = db_user,
                          password = db_password,
                          dbname = db_name,
                          host = db_host)
  
  message("connection established")
 
  # helper function for fetching tables once connection is established
    
  fetch_tbl <- function(con, tbl_name) {
    suppressWarnings(  # no warnings when importing undefined data types
	    rs <- RMySQL::dbSendQuery(con, paste0("select * from ", tbl_name)))
  	
  	df <- RMySQL::fetch(rs, n = -1)
    
	  RMySQL::dbClearResult(rs)
	  
	  message(paste0("fetched table ", tbl_name))
    
	  df
    }

 tables <- tbl_names %>% 
   purrr::map(fetch_tbl, con = podlove_db) %>% 
   purrr::set_names(df_names)
 
  RMySQL::dbDisconnect(podlove_db)
  
  message("connection closed")
	
	#clean data
	# dlic_clean <- podlove_clean_stats(dlic_raw, ref_mediafile, ref_user, ref_episodes, ref_posts)
	dlic_clean <- podlove_clean_stats(tables[[df_names[1]]],
	                                  tables[[df_names[2]]],
	                                  tables[[df_names[3]]],
	                                  tables[[df_names[4]]],
	                                  tables[[df_names[5]]],
																		launch_date)
	
	dlic_clean
}