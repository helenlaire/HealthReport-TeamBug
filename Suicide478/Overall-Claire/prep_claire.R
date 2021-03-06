library(dplyr)
library(ggplot2)
library(tidyr)
# read in the state 
data <- read.csv("data/intentional_self_harm_data.csv")
data$Death <- as.numeric(as.character(data$Death))
data$Population <- as.numeric(as.character(data$Population))
data <- data %>% mutate(Rate = round(Death/Population*100000,2))

as.character(data$State)
# data prep for later rows
data$state_length <- nchar(as.character(data$State))
data$state_length <- as.numeric(data$state_length)
# calculate usa suicide rate by gender
usa_data <- data %>% group_by(Year, Gender) %>% summarize(Death = sum(Death), Population = sum(Population), States = "United States")
usa_data <- usa_data %>% mutate(Rate = round(Death/Population*100000,2))
usa_data <- usa_data %>% select(5,2,1,3,4,6)
# make the state column with right format 
data$States <-substr(data$State, 1, data$state_length -5)
# reorganize the data
df <- data %>% select(9,2,3,4,5,7)
# combine state data with usa data
combined_df <- bind_rows(usa_data, df)
write.csv(combined_df, file = 'data/combined.csv')
state_list <- unique(df$States)
gender_list <- unique(df$Gender)
