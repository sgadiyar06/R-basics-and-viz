library(readr)
library(tidyverse)

df <- read.csv('book_reviews.csv')

#check dimensions
dimensions <- dim(df)

col_names <- colnames(df)

for(i in col_names){
  print(paste('Type of',i,'is',typeof(df[[i]])))
}

for(i in col_names) {
  print(unique(df[[i]]))
}

filtered <- df %>%
  filter(!is.na(review))

print(dim(filtered))


df2 <- filtered %>%
  mutate(
    state = case_when(
      state == 'California' ~ 'CA',
      state == "Florida" ~ 'FL',
      state == 'Texas' ~ 'TX',
      state == 'New York' ~ 'NY',
      state == 'CA' ~ 'CA',
      state == "FL" ~ 'FL',
      state == 'TX' ~ 'TX',
      state == 'NY' ~ 'NY',
    )
  )

for(i in colnames(df2)) {
  print(unique(df2[[i]]))
}

df3 <- df2 %>%
  mutate(
    review_num = case_when(
      review == "Poor" ~ 1,
      review == "Fair" ~ 2,
      review == "Good" ~ 3,
      review == "Great" ~ 4,
      review == "Excellent" ~ 5
    ),
    is_high_review = if_else(review_num >= 4,T,F)
  )