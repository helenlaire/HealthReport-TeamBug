library(dplyr)
library(ggplot2)
library(tidyr)

data <- read.csv("data/intentional_self_harm_data.csv")

as.character(data$State)



data$state_length <- nchar(as.character(data$State))
data$state_length <- as.numeric(data$state_length)


data$state <-substr(data$State, 1, data$state_length -5)

df <- data %>% select(8,2,3,4,5)

df <- df %>% mutate(rate = as.numeric(Death)/as.numeric(Population))
