library(tidyverse)
library(dslabs)

data("gapminder")

#time series plots
gapminder %>% 
  filter(country=='United States') %>%
  ggplot(aes(year,fertility)) +
  geom_point()

gapminder %>% 
  filter(country=='United States') %>%
  ggplot(aes(year,fertility)) +
  geom_line()

#for two countries
countries <- c('South Korea','Germany')
gapminder %>% 
  filter(country %in% countries) %>%
  ggplot(aes(year,fertility)) +
  geom_line()
#this does not specify we need two separate lines
#to do this we do
gapminder %>% 
  filter(country %in% countries) %>%
  ggplot(aes(year,fertility,group = country)) +
  geom_line()
#here we cant differentiate b/w the countries
#so we add color and by default we get two separate lines
gapminder %>% 
  filter(country %in% countries) %>%
  ggplot(aes(year,fertility,col = country)) +
  geom_line()
#legend is automatically added as well

#if we want to label then:
labels <- data.frame(country=countries,x=c(1975,1965),y=c(60,72))
gapminder %>% 
  filter(country %in% countries) %>%
  ggplot(aes(year,life_expectancy,col = country)) +
  geom_line() +
  geom_text(data=labels,aes(x,y,label=country),size=5) + 
  theme(legend.position = 'none')