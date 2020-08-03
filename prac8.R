library(tidyverse)
library(dslabs)
data(murders)
library(ggthemes)
library(ggrepel)
ds_theme_set()

r <- murders %>%
  summarise(rate = sum(total)/ sum(population) * 10^6) %>% 
  pull(rate)

p <- murders %>% ggplot(aes(population/10^6,total,label=abb)) + 
  geom_abline(intercept = log10(r),lty=2,color='darkgrey') + 
  geom_point(aes(col=region),size=3)+
  geom_text_repel() +
  scale_x_log10() +
  scale_y_log10() + 
  xlab("Population in millions (log scale)") +
    ylab("Total number of murders (log scale)") +
    ggtitle("US Gun Murders in 2010") +
    scale_color_discrete(name = "Region") +
    theme_economist()
  
#local pref can override global aes pref
# p <- murders %>% ggplot(aes(population/10^6,total,label=abb)) + 
#   geom_point(size=3) +
#   geom_text(aes(10,800,label='Hello there'))


print(p)