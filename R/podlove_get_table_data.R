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

podlove_get_table_data <- function(db_con, tablename) {
  
  rs <- RMySQL::dbSendQuery(db_con, paste0("select * from ", tablename))
  df <- RMySQL::fetch(rs, n=-1)
  
  df
  
}