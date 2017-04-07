### CREATE DB ###
library(dplyr)
library(magrittr)
library(readr)
library(RSQLite)
library(rvest)
library(stringi)

db <- dbConnect(drv = SQLite(), dbname = "data/wp.db")

tab_name <- "wp_wiadomosci"
template <- paste0("data/", tab_name, ".csv") %>%
  read_csv()

dbSendQuery(conn = db,"CREATE TABLE wp_wiadomosci (links TEXT, bodies TEXT)")
dbWriteTable(db, name = tab_name, value = template)

dbDisconnect(db)
