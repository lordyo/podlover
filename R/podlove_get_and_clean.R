
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
  
 
  # helper function for fetching tables once connection is established
    
  fetch_tbl <- function(con, tbl_name) {
    rs <- RMySQL::dbSendQuery(con, paste0("select * from ", tbl_name))
    df <- RMySQL::fetch(rs, n=-1)
    df
    }

 tables <- tbl_names %>% 
   purrr::map(fetch_tbl, con = podlove_db) %>% 
   purrr::set_names(df_names)
 
  RMySQL::dbDisconnect(podlove_db)
	
	#clean data
	# dlic_clean <- podlove_clean_stats(dlic_raw, ref_mediafile, ref_user, ref_episodes, ref_posts)
	dlic_clean <- podlove_clean_stats(tables[[df_names[1]]],
	                                  tables[[df_names[2]]],
	                                  tables[[df_names[3]]],
	                                  tables[[df_names[4]]],
	                                  tables[[df_names[5]]])
	
	
	dlic_clean
}