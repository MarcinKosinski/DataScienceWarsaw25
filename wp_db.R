### CREATE DB ###
library(dplyr)
library(magrittr)
library(readr)
library(RSQLite)
library(rvest)
library(stringi)

db <- dbConnect(drv = SQLite(), dbname = "data/wp.db")

tab_name <- "wp_kobieta"
template <- paste0("data/", tab_name, ".csv") %>%
  read_csv()

dbGetQuery(db, "DROP TABLE wp_kobieta")
# dbSendQuery(conn = db, paste0("CREATE TABLE ", tab_name,
#                               " (links TEXT, bodies TEXT)"))
dbWriteTable(db, name = tab_name, value = template)

dbDisconnect(db)
