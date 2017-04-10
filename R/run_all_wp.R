library(dplyr)
library(magrittr)
library(pbapply)
library(readr)
library(RSQLite)
library(rvest)
library(stringi)
# setwd('R/') if you run this not using `run_.sh` from the main directory
db <- dbConnect(drv = SQLite(), dbname = "../data/wp.db")
list.files('wp/', full.names = TRUE, pattern = 'wp') %>%
  sapply(source, echo = TRUE, encoding = 'UTF-8')
dbDisconnect(db)
