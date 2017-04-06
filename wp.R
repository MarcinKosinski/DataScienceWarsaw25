library(dplyr)
library(magrittr)
library(rvest)
library(stringi)
library(pbapply)

### WIADOMOŚCI ###
adress <- c("http://wiadomosci.wp.pl/")
adresses <- c("polska", "swiat", "spoleczenstwo", "przestepczosc", "polityka",
              "ciekawostki", "nauka", "tylko-w-wp", "dzieje-sie-na-zywo") %>%
  paste0(adress, .)

links <- pblapply(adresses, function(one_ad) {
  ad_html <- read_html(one_ad)
  ad_nodes <- html_nodes(ad_html, css = "div")
  
  ad_text <- ad_nodes %>%
    grep("menuText-Raporty desktop", .) %>%
    ad_nodes[.] %>%
    as.character()
  
  biggest_list <- ad_text %>%
    stri_count_regex("href") %>%
    which.max()
  
  big_links <- biggest_list %>%
    ad_text[.] %>%
    stri_extract_all_regex("href.*[[:digit:]].*data-reactid.*<div") %>%
    unlist() %>%
    gsub("href=\"/", adress, .) %>%
    gsub("\".*", "", .)
  
  articles <- big_links %>%
    grepl("[[:digit:]]", .) %>%
    big_links[.]
  
  articles
}) %>%
  unlist() %>%
  unique()

bodies <- pblapply(links, function(link) {
  link %>%
    read_html() %>%
    html_nodes(css = "p , ._1HGmjUl , ._1xAmRvR") %>%
    html_text() %>%
    paste0(collapse = " ")
}) %>%
  unlist()

df_to_DB <- data_frame(links = links, bodies = bodies)