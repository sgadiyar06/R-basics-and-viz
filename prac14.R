library(tidyverse)
library(dslabs)

data("gapminder")

west <- c('Western Europe','Northern Europe','Southern Europe','Northern America',
          'Australia and New Zealand')

past_year <- 1970
present_year <- 2010


gapminder <- gapminder %>% 
  mutate(dollar_per_day = gdp/population/365)

p <- gapminder %>%
  filter(year == past_year & !is.na(gdp)) %>%
  mutate(group = ifelse(region %in% west, 'West','Developing')) %>% 
  ggplot(aes(dollar_per_day)) + 
  geom_histogram(binwidth = 1,color = 'black') +
  scale_x_continuous(trans = 'log2') +
  facet_grid(.~group)



q <- gapminder %>%
  filter(year %in% c(past_year,present_year) & !is.na(gdp)) %>%
  mutate(group = ifelse(region %in% west, 'West','Developing')) %>% 
  ggplot(aes(dollar_per_day)) + 
  geom_histogram(binwidth = 1,color = 'black') +
  scale_x_continuous(trans = 'log2') +
  facet_grid(year~group)

#since for the year 2010 many countries are new which werent present in 1970
#example USSR, so we are only gonna plot the data for the countries where 
#records are present for both the years

country_list1 <- gapminder %>% 
  filter(year == past_year & !is.na(dollar_per_day)) %>% .$country

country_list2 <- gapminder %>% 
  filter(year == present_year & !is.na(dollar_per_day)) %>% .$country

country_list <- intersect(country_list1,country_list2)


r <- gapminder %>%
  filter(year %in% c(past_year,present_year) & country %in% country_list) %>%
  mutate(group = ifelse(region %in% west, 'West','Developing')) %>% 
  ggplot(aes(dollar_per_day)) + 
  geom_histogram(binwidth = 1,color = 'black') +
  scale_x_continuous(trans = 'log2') +
  facet_grid(year~group)
  
s <- gapminder %>%
  filter(year %in% c(past_year,present_year) & country %in% country_list) %>%
  mutate(group = ifelse(region %in% west, 'West','Developing')) %>% 
  ggplot() + 
  theme(axis.text.x = element_text(angle = 90,hjust = 1)) +
  xlab('') +
  scale_y_continuous(trans = 'log2') 

s <- s + geom_boxplot(aes(region,dollar_per_day,fill=continent)) + 
  facet_grid(year~.)

# as we can see to compare it is a bit diffcult so we change it by not using
#facet but by filling in color for 1970 and 2010

t <- gapminder %>%
  filter(year %in% c(past_year,present_year) & country %in% country_list) %>%
  mutate(group = ifelse(region %in% west, 'West','Developing')) %>% 
  ggplot() + 
  theme(axis.text.x = element_text(angle = 90,hjust = 1)) +
  xlab('') +
  scale_y_continuous(trans = 'log2') 

t <- t + geom_boxplot(aes(region,dollar_per_day,fill = factor(year)))
  
print(p)
print(q)
print(r)
print(s)
print(t)