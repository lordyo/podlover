
#' Fetch a table from a MySQL database
#' 
#' \code{podlove_get_table_data} opens up a connection to a MySQL database and
#' fetches a whole table as a df. It Uses \code{rstudioapi::askForSecret()}, 
#' which allows securely storing access info in the local keyring.
#'    
#' @param tablename name of the MySQL table
#' @param dbname name of the database
#' @param host hostname of the database
#' @param user username of the database 
#' @param password password of the database
#' 
#' @return A dataframe containing the table data.
#' 
#' @examples
#' \dontrun{
#' dlic_raw <- podlove_get_table_data(db_stats)
#' }


# purpose
### wrapper function to get all table data and clean it
### calls on podlove_get_table_data() and podlove_clean_stats

# output
### dlic_clean: a clean dataframe containing all podcast data

podlove_get_and_clean <- function(db_name = rstudioapi::askForSecret(name = "dbname"),
                                  db_host = rstudioapi::askForSecret(name = "host"),
                                  db_user = rstudioapi::askForSecret(name = "user"),
                                  db_password = rstudioapi::askForSecret(name = "password")) {
  
	wp_names <-	c("wp_podlove_downloadintentclean", 
								"wp_podlove_mediafile", 
								"wp_podlove_useragent", 
								"wp_podlove_episode", 
								"wp_posts")
	
	db_names <- c("db_stats",
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
  
 
  # add map function for wp_names, db_names
  
   
  RMySQL::dbClearResult(rs)
  RMySQL::dbDisconnect(podlove_db)
	
	
	
	# get all data from stats table (dlic)
	dlic_raw <- podlove_get_table_data(db_stats)
	
	# get all reference values
	ref_mediafile <- podlove_get_table_data(db_ref_media)
	ref_user <- podlove_get_table_data(db_ref_user)
	ref_episodes <- podlove_get_table_data(db_ref_episodes)
	ref_posts <- podlove_get_table_data(db_ref_posts)
	
	#clean data
	dlic_clean <- podlove_clean_stats(dlic_raw, ref_mediafile, ref_user, ref_episodes, ref_posts)
	
	dlic_clean
}