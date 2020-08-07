library(tidyverse)
library(dslabs)

data("gapminder")

gapminder <- gapminder %>% 
  mutate(dollars_per_day = gdp/population/365)
past_year <- 1970
present_year <- 2010


country_list1 <- gapminder %>% 
  filter(year == past_year & !is.na(dollars_per_day)) %>% .$country

country_list2 <- gapminder %>% 
  filter(year == present_year & !is.na(dollars_per_day)) %>% .$country

country_list <- intersect(country_list1,country_list2)


tab <-gapminder %>%
  filter(year == past_year & country %in% country_list) %>%
  mutate(group = ifelse(region %in% west, "West", "Developing")) %>% group_by(group) %>%
  summarize(n = n()) %>% knitr::kable()

print(tab)

past_year <- 1970
present_year <- 2010


p <- gapminder %>%
  filter(year %in% c(past_year,present_year) & country %in% country_list) %>%
  mutate(group = ifelse(region %in% west, "West", "Developing")) %>%
  ggplot(aes(dollars_per_day, y = ..count.., fill = group)) +
  scale_x_continuous(trans = "log2")
p <- p + geom_density(alpha = 0.2, bw = 0.75) + facet_grid(year ~ .)

print(p)

gapminder <- gapminder %>%
  mutate(group = case_when(
    .$region %in% west ~ "West",
    .$region %in% c("Eastern Asia", "South-Eastern Asia") ~ "East Asia",
    .$region %in% c("Caribbean", "Central America", "South America") ~ "Latin America",
    .$continent == "Africa" & .$region != "Northern Africa" ~ "Sub-Saharan Africa",
    TRUE ~ "Others"))

# reorder factor levels
gapminder <- gapminder %>%
  mutate(group = factor(group, levels = c("Others", "Latin America", "East Asia", "Sub-Saharan Africa", "West")))



r <- gapminder %>%
  filter(year %in% c(past_year, present_year) & country %in% country_list) %>%
  ggplot(aes(dollars_per_day, fill = group)) +
  scale_x_continuous(trans = "log2")

# stacked density plot
r<- r + geom_density(alpha = 05, bw = 0.75, position = "stack") +
  facet_grid(year ~ .)
print(r)

# weighted stacked density plot
s <- gapminder %>%
  filter(year %in% c(past_year, present_year) & country %in% country_list) %>%
  group_by(year) %>%
  mutate(weight = population/sum(population*2)) %>%
  ungroup() %>%
  ggplot(aes(dollars_per_day, fill = group, weight = weight)) +
  scale_x_continuous(trans = "log2") +
  geom_density(alpha = 0.2, bw = 0.75, position = "stack") + facet_grid(year ~ .)

print(s)