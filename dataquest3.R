library(tidyverse)
library(lubridate)

sales <- read.csv('sales2019.csv')

size <- dim(sales)

for(i in colnames(sales)){
  print(paste('Type of',i,'is',typeof(sales[[i]])))
}

for (i in colnames(sales)) {
  paste0(i,
      ", number of missing value in the col: ",
      is.na(sales[[i]]) %>% sum) %>% print

}

#sales1 is the dataframe where the rows with user reviews with 
#NA have been removed
sales1 <- sales %>%
  filter(!is.na(user_submitted_review))

mean_sales <- sales1 %>%
  filter(!is.na(total_purchased)) %>% 
  pull(total_purchased) %>% mean

complete_sales <- sales1 %>% 
  mutate(
    imputed_purchases = if_else(is.na(total_purchased), 
                                mean_sales,
                                as.double(total_purchased))
  )

rating_review <- function(review) {
  user_review <- str_to_lower(review)
  verdict <- case_when(
    str_detect(user_review,'awesome') ~ 'Positive',
    str_detect(user_review,'not') ~ 'Negative',
    str_detect(user_review,'hate') ~ 'Negative',
    str_detect(user_review,'good') ~ 'Positive',
    str_detect(user_review,'learn') ~ 'Positive',
    str_detect(user_review,'recommend') ~ 'Positive',
    str_detect(user_review,'ok') ~ 'Positive',
    str_detect(user_review,'other') ~ 'Negative',
    str_detect(user_review,'never') ~ 'Positive',
    TRUE ~ 'Positive'
  )
  return(verdict)
}

complete_sales <- complete_sales %>%
  mutate(
    review = unlist(map(user_submitted_review,rating_review))
  )

complete_sales <- complete_sales %>%
  mutate(
    timeperiod = if_else(mdy(date) < ymd('2019-07-01'),'Pre','Post')
  )

summ <- complete_sales %>%
  group_by(timeperiod) %>%
  summarise(
    books_purchased = sum(imputed_purchases)
  )

print(summ)

summ2 <- complete_sales %>%
  group_by(customer_type,timeperiod) %>%
  summarise(
    books_purchased = sum(imputed_purchases)
  )
print(summ2)

summ3 <- complete_sales %>%
  group_by(review,timeperiod) %>%
 summarise(
   n()
 )
print(summ3)