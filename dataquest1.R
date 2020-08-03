library(readr)
library(tidyverse)

#reading the csv file
covid_df <- read.csv('covid19.csv')

#checking the dimensions of the file
dimensions <- dim(covid_df)
print('Dimensions: ')
print(dimensions)

#checking the column names
vector_cols <- colnames(covid_df)
print('The names of the columns are: ')
print(vector_cols)

print(head(covid_df))

glimpse(covid_df)

#filtering the dataset to contain only the data which we need
#choosing the data where province name is as 'all states'

covid_df_all_states <- covid_df %>%
  filter(Province_State == 'All States')

#extracting data where only daily data columns are used and we avoid
#cumulative data

covid_df_all_states_daily <- covid_df_all_states %>%
  select(Date,Country_Region,active,hospitalizedCurr,daily_tested,daily_positive)

#grouping by country and summarizing

covid_df_all_states_daily_sum <- covid_df_all_states_daily %>%
  group_by(Country_Region) %>%
  summarise(
    tested = sum(daily_tested),
    positive = sum(daily_positive),
    active = sum(active),
    hospitalized = sum(hospitalizedCurr),
  ) %>%
  arrange(-tested)

print(covid_df_all_states_daily_sum)

#storing the top 10
covid_top_10 <- head(covid_df_all_states_daily_sum,10)

countries <- covid_top_10$Country_Region
tested_cases <- covid_top_10$tested
positive_cases <- covid_top_10$positive
active_cases <- covid_top_10$active
hospitalized_cases <- covid_top_10$hospitalized


names(positive_cases) <- countries
names(tested_cases) <- countries
names(active_cases) <- countries
names(hospitalized_cases) <- countries

#identifying top 3 cases with criteria: positive/tested
ratio <- positive_cases/tested_cases

positive_top_3 <- sort(ratio,decreasing = T) %>%
  head(3) %>%
  print()

united_kingdom <- c(0.11, 1473672, 166909, 0, 0)
united_states <- c(0.10, 17282363, 1877179, 0, 0)
turkey <- c(0.08, 2031192, 163941, 2980960, 0)

covid_mat <- rbind(united_kingdom,united_states,turkey)

colnames(covid_mat) <- c('Ratio','tested','positive','active','hospitalized')

#putting it all together

question <- 'Which countries have had the highest number of positive cases against the number of tests?'

answer <- c('Positive tested cases '=positive_top_3)

dataframes <- list(
  original = covid_df,
  allstates = covid_df_all_states,
  daily = covid_df_all_states_daily,
  sumdaily = covid_df_all_states_daily_sum,
  top10 = covid_top_10
)

matrices <- list(matrix = covid_mat)

vectors <- list(columns = vector_cols,
                countries = countries)

datastructure_list <- list(dataframes,matrices,vectors)

covid_analysis_test <- list(question,answer,datastructure_list)

cat('\n')

print('The final result: ')

cat('\n')

print(covid_analysis_test[[2]])
