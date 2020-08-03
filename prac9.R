library(tidyverse)
library(dslabs)

data("heights")

h <- heights %>%
  filter(sex=='Male') %>%
  ggplot(aes(x=height))

h <- h + geom_density(fill='blue')

h <- h + geom_histogram(binwidth = 1,fill='blue',col='black') +
   xlab('Male heights in inches') +
   ggtitle('Histogram')

params <- heights %>% 
  filter(sex == 'Male') %>%
  summarize(mean = mean(height),sd = sd(height))


# h <- heights %>%
#   filter(sex=='Male') %>%
#   ggplot(aes(sample=scale(height)))
# h <- h + geom_qq() +                           #use dparams = paramas if data
#   geom_abline()                                #not scaled

h1 <- h + geom_histogram(binwidth = 1,fill='blue',col='black')
h2 <- h + geom_histogram(binwidth = 2,fill='blue',col='black')
h3 <- h + geom_histogram(binwidth = 3,fill='blue',col='black')
library(gridExtra)
grid.arrange(h1,h2,h3,ncol=3)
print(h)