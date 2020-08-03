library(dslabs)
library(dplyr)

data("murders")

my_state <- murders %>% mutate(rate=total/population*100000,rank=rank(-rate)) %>%
  filter(region %in% c('Northeast','West') & rate < 1) %>% 
  select(state,rate,rank)