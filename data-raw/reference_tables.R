library(tidyverse)

fp <- "https://www.opensecrets.org/downloads/crp/CRP_Categories.txt"

categories <- read_tsv(fp, skip = 8) %>%
  janitor::clean_names()

committees <- read_delim("https://www.opensecrets.org/downloads/crp/CRP_CongCmtes.txt", delim = ' ') %>%
  janitor::clean_names() %>%
  mutate_all(str_squish)

library(opensecrets)

all_legislators <- state.abb %>%
  map(get_legislators)

legislators <- bind_rows(all_legislators) %>%
  mutate(state = str_extract(office, "[A-Z]{2}")) %>%
  select(cid, firstlast, lastname, state, everything())


write_csv(categories, "data/categories.csv")
write_csv(legislators, "data/legislators.csv")
write_csv(committees, "data/committees.csv")

usethis::use_data(committees, legislators, categories)
