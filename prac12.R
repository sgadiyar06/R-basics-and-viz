library(tidyverse)
library(dslabs)

data("gapminder")

#transformations

gapminder <- gapminder%>% 
  mutate(dollars_per_day = gdp/population/365)

past_year <- 1970
p <- gapminder %>% 
  filter(year == past_year & !is.na(gdp)) %>%
  ggplot(aes(dollars_per_day)) +
  geom_histogram(binwidth = 1,color='black')

#applying log transformation
q <- gapminder %>% 
  filter(year == past_year & !is.na(gdp)) %>%
  ggplot(aes(log2(dollars_per_day))) +
  geom_histogram(binwidth = 1,color='black')

#scale the axis
#not scaling the data is useful as we retain the original points
r <- gapminder %>% 
  filter(year == past_year & !is.na(gdp)) %>%
  ggplot(aes(dollars_per_day)) +
  geom_histogram(binwidth = 1,color='black')+
  scale_x_continuous(trans = 'log2')

print(p)
print(q)
print(r)