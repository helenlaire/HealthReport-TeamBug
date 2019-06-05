library(plyr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(plotly)
overall_trend <- function(combined_df,state_one, state_two, gender_choice){

chosen_states <- combined_df %>% filter(States == state_one| States == state_two| States == "United States")
chosen_gender <- chosen_states %>% filter(Gender == gender_choice)

 
p <- ggplot(data = chosen_gender) +
  geom_line(mapping = aes(x= Year, y = Rate, group = States, color = States))+
  geom_point(mapping = aes(x= Year, y = Rate, group = States, color = States))+
  theme(
    panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
    panel.background = element_blank(), axis.line = element_line(colour = "black")
  )+
  labs(
    title = paste(gender_choice, "Suicide Trend in", state_one, "and", state_two, " from 2000 to 2010")
  )

ggplotly(p)
}



