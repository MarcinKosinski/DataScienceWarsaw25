list.files('R/', full.names = TRUE, pattern = 'wp') %>%
  sapply(source, echo = TRUE)