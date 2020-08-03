#plots 
# library(dslabs)
# data("murders")

x <- murders$population /(10^6)

y <- murders$total
plot(x, y)

murders <- mutate(murders, rate = total / population * 100000)
# a histogram of murder rates
hist(murders$rate)

# boxplots of murder rates by region
boxplot(rate~region, data = murders)