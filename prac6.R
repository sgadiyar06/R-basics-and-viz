library(dslabs)
data("murders")


#working of if else:

a <- 5
if (a>0) {
  print(1/a)
} else { print(NA)}

#one more example:
murder_rate <- murders$total/murders$population*100000
ind <- which.min(murder_rate)
if (murder_rate[ind] < 0.5){
  print(murders$state[ind])
} else {
  print('No other state')
}

if (murder_rate[ind] < 0.25){
  print(murders$state[ind])
} else {
  print('No other state')
}


#working of ifelse() single line function
a <- -1
ifelse(a>0,print('Positive'),print('Non positive'))

#working with vectors:
b <- c(1,2,3,-5,-6)
result <- ifelse(b>0,print('Positive'),print('Non positive'))
print(result)

# the ifelse() function is also helpful for replacing missing values
data(na_example)
print(sum(is.na(na_example)))
no_nas <- ifelse(is.na(na_example), 0, na_example) 
print(sum(is.na(no_nas)))

# the any() and all() functions evaluate logical vectors
z <- c(TRUE, TRUE, FALSE)
print(any(z))
print(all(z))
z2 <- c(T,T,T)
print(all(z2))


