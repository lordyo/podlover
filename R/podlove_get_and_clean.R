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
#' @param tbl_prefix prefix of the MySLQ table names, defaults to `wp_`
#' @param tbl_downloads name of the MySQL table for clean downloads (without the prefix)
#' @param tbl_mediafile name of the MySQL table for mediafiles (without the prefix)
#' @param tbl_useragent name of the MySQL table for useragents (without the prefix)
#' @param tbl_episode name of the MySQL table for episodes (without the prefix)
#' @param tbl_posts name of the MySQL table for posts (without the prefix)
#' 
#' @return a dataframe containing all episode download attempts
#' 
#' @examples
#' \dontrun{
#' # will ask for db name, host, username, password
#' dlic_raw <- podlove_get_and_clean(launchdate = "2019-05-01")
#' }
#' \dontrun{
#' # don't use clear access data in functions, never save passwords to .R files! 
#' download_data <- podlove_get_and_clean(dbname = "my_sql_database",
#'                                        host = "my.database.host",
#'                                        user = "username,"
#'                                        password = "my.secret.password",
#'                                        launchdate = "2019-05-01")
#' }
#' 
#' @importFrom magrittr %>% 
#' 
#' @export


podlove_get_and_clean <- function(db_name = rstudioapi::askForSecret(name = "dbname", message = "Enter the name of the database", title = "Database Name"),
																	db_host = rstudioapi::askForSecret(name = "host", message = "Enter the hostname of the database", title = "Hostname"),
                                  db_user = rstudioapi::askForSecret(name = "user", message = "Enter the user name of the database", title = "User Name"),
                                  db_password = rstudioapi::askForSecret(name = "password", message = "Enter the Password", title = "Password"),
																	launch_date = NULL,
																	tbl_prefix = "wp_",
																	tbl_downloads = "podlove_downloadintentclean",
																	tbl_mediafile = "podlove_mediafile",
																	tbl_useragent = "podlove_useragent",
																	tbl_episode = "podlove_episode",
																	tbl_posts = "posts")  {
  
  # define which tables to fetch
  
  tbl_names <-	paste0(tbl_prefix, c(tbl_downloads, 
                                    tbl_mediafile, 
                                    tbl_useragent, 
                                    tbl_episode, 
                                    tbl_posts))

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
	
	message("tables connected and data cleaned")
	
	dlic_clean
}