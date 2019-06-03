library(dplyr)
library(ggplot2)
library(tidyr)

data <- read.csv("data/intentional_self_harm_data.csv")
data$Death <- as.numeric(as.character(data$Death))
data$Population <- as.numeric(as.character(data$Population))
data <- data %>% mutate(Rate = round(Death/Population*100000,2))

as.character(data$State)

data$state_length <- nchar(as.character(data$State))
data$state_length <- as.numeric(data$state_length)

usa_data <- data %>% group_by(Year, Gender) %>% summarize(Death = sum(Death), Population = sum(Population), States = "United States")
usa_data <- usa_data %>% mutate(Rate = round(Death/Population*100000,2))
usa_data <- usa_data %>% select(5,2,1,3,4,6)

data$States <-substr(data$State, 1, data$state_length -5)

df <- data %>% select(9,2,3,4,5,7)

combined_df <- bind_rows(usa_data, df)


overall_trend <- function(state_one, state_two, gender_choice){

chosen_states <- combined_df %>% filter(States == state_one| States == state_two| States == "United States")
chosen_gender <- chosen_states %>% filter(Gender == gender_choice)

 
p <- ggplot(data = chosen_gender) +
  geom_line(mapping = aes(x= Year, y = Rate, group = States, color = States))+
  geom_point(mapping = aes(x= Year, y = Rate, group = States, color = States))
p

}

overall_trend("Minnesota", "Washington", "Male")
