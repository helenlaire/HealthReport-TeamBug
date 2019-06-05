library(plyr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(plotly)
overall_trend <- function(combined_df,state_one, state_two, gender_choice){

chosen_states <- combined_df %>% filter(States == state_one| States == state_two| States == "United States")
chosen_gender <- chosen_states %>% filter(Gender == gender_choice)

 
p <- ggplot(data = chosen_gender) +
  geom_line(mapping = aes(x= Year, y = Rate,  color = States))+
  geom_point(mapping = aes(x= Year, y = Rate,  color = States))+
  theme(
    panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
    panel.background = element_blank(), axis.line = element_line(colour = "black")
  )+
  labs(
    title = paste(gender_choice, "Suicide Trend in", state_one, "and", state_two, " from 2000 to 2010"), 
    y = "suicide rate (%)"
    
  )

ggplotly(p)
}

suicide_text <- function(combined_df, state_one, state_two, gender_choice){
  state_one_df <- combined_df %>% filter(States == state_one) %>% filter(Gender == gender_choice)
  state_one_min <- state_one_df %>% filter(Rate == min(Rate))
  state_one_min_row <- head(state_one_min,1)
  state_one_max <- state_one_df %>% filter(Rate == max(Rate))
  state_two_df <- combined_dff %>% filter(States == state_two) %>% filter(Gender == gender_choice)
  state_two_min <- state_two_df %>% filter(Rate == min(Rate))
  state_two_max <- state_two_df %>% filter(Rate == max(Rate))
  state_one_max_row <- head(state_one_max,1)
  state_two_min_row <- head(state_two_min,1)
  state_two_max_row <- head(state_two_max,1)
  
  if(gender_choice == "female"){
    gender_analysis <- "Suicide rate of female in the United States is increasing from 2000 to 2010. The suicide rate in 2000 is 
  4.01%, and the suicide rate in 2010 is 5.16%. In those 10 years, the general trend is increasing suicide rate except in 2003 and 2005.
  In 2002 and 2004, female suicide rate slight decreases. 
  "
    
  }else{
    gender_analysis <- "In general, suicide rate of male in the United States is increasing from 2000 to 2010. The suicide rate in 2000 for female is 
  17.1%, and the suicide rate in 2010 is 19.94%. However, the sucide rate decreases in 2002. From 2003 to 2006, the suicide rate slight increases
  among male, but the increase is relatively small compared to any other time period between 2000 and 2010."
    
  }
  
  paste("The graph above shows the suicide rate of ", gender_choice, " in ", state_one, " and",state_two, gender_analysis)
  
}




