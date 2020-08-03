library(dslabs)
library(tidyverse)
data("heights")

index <- heights$sex=='Male'

x <- heights$height[index]

z <- scale(x)

mean(x <= 69.5)

p <- seq(0.01,0.99,0.01)

obs <- quantile(x,p)

theor <- qnorm(p,mean = mean(x),sd = sd(x))

plot(theor,obs)
abline(0,1)

obs <- quantile(z,p)

theor <- qnorm(p,mean = mean(z),sd = sd(z))

plot(theor,obs)
abline(0,1)
