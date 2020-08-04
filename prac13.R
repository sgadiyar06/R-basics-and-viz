library(tidyverse)
library(dslabs)

data("gapminder")
gapminder <- gapminder%>% 
  mutate(dollars_per_day = gdp/population/365)

#boxplots
past_year <- 1970
p <- gapminder %>%
  filter(year==past_year & !is.na(gdp)) %>%
  ggplot(aes(region,dollars_per_day)) + 
  geom_boxplot()
#change text orientation on x axis to vertical
p <- p + theme(axis.text = element_text(angle = 90,hjust = 1))

#reorder the list of countries to make it more meaningful
p <- gapminder %>%
  filter(year == past_year & !is.na(gdp)) %>%
  mutate(region = reorder(region, dollars_per_day, FUN = median)) %>%    # reorder
  ggplot(aes(region, dollars_per_day, fill = continent)) +    # color by continent
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  xlab("")

p <- p + scale_y_continuous(trans = 'log2')

p <- p + geom_point(show.legend = F)
print(p)