library(plyr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(plotly)

# the function will generate an interative graphs about suicide rate in chosen states 
overall_trend <- function(combined_df,state_one, state_two, gender_choice){
# combine states data with united states data
chosen_states <- combined_df %>% filter(States == state_one| States == state_two| States == "United States")
chosen_gender <- chosen_states %>% filter(Gender == gender_choice)

 
p <- ggplot(data = chosen_gender) +
  geom_line(mapping = aes(x= Year, y = Rate,  color = States))+
  geom_point(mapping = aes(x= Year, y = Rate,  color = States))+
  theme(
    panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
    panel.background = element_blank(), axis.line = element_line(colour = "black")
  )+scale_x_continuous(breaks = chosen_gender$Year) +
  labs(
    title = paste(gender_choice, "Suicide Trend in", state_one, "and", state_two, " from 2000 to 2010"), 
    y = "suicide rate per 100,000"
    
  )

ggplotly(p)
}
# the following function will render text to interprete the suicide rate graph
suicide_text <- function(combined_df, state_one, state_two, gender_choice){
  state_one_df <- combined_df %>% filter(States == state_one) %>% filter(Gender == gender_choice)
  state_one_min <- state_one_df %>% filter(Rate == min(Rate))
  state_one_min_row <- head(state_one_min,1)
  state_one_max <- state_one_df %>% filter(Rate == max(Rate))
  state_one_2000 <- state_one_df %>% filter(Year == "2000")
  state_one_2010 <- state_one_df %>% filter(Year == "2010")
  state_two_df <- combined_df %>% filter(States == state_two) %>% filter(Gender == gender_choice)
  state_two_min <- state_two_df %>% filter(Rate == min(Rate))
  state_two_max <- state_two_df %>% filter(Rate == max(Rate))
  state_one_max_row <- head(state_one_max,1)
  state_two_min_row <- head(state_two_min,1)
  state_two_max_row <- head(state_two_max,1)
  state_two_2000 <- state_two_df %>% filter(Year == "2000")
  state_two_2010 <- state_two_df %>% filter(Year == "2010")
  # different statement for female and male
  if(gender_choice == "Female"){
    gender_analysis <- "Suicide rate of female in the United States is increasing from 2000 to 2010. The suicide rate of U.S. in 2000 is 
  4.01 per 100,000, and the suicide rate in 2010 is 5.16 per 100,000. In those 10 years, the general trend of suicide rate is increasing except in 2002 and 2004.
  In 2002 and 2004, female suicide rate slight decreases. 
  "
    
  }else{
    gender_analysis <- "In general, suicide rate of male in the United States is increasing from 2000 to 2010. The suicide rate of U.S. in 2000 for male is 
  17.1 per 100,000, and the suicide rate in 2010 is 19.94 per 100,000. However, the sucide rate decreases in 2002. From 2003 to 2006, the suicide rate slight increases
  among male, but the increase is relatively small compared to any other time period between 2000 and 2010."
    
  }
  
  output_text <- paste("The graph above shows the suicide rate of ", gender_choice, " in ", state_one, " ,",state_two, "and United States as whole. Let's start with 
        the United States stats.", gender_analysis, " Focusing on ", state_one, ", the suicide rate in 2000 is ", state_one_2000$Rate, "per 100,000, and the
        sucide rate in 2010 is ", state_one_2010$Rate,"per 100,000. The highest suicide rate happened in ", state_one_max$Year, ", and the suicide rate is ", 
        state_one_max_row$Rate, "per 100,000. The lowest suicide rate happened in ", state_one_min$Year, ", and the suicide rate is ", state_one_min_row$Rate,
        "per 100,000. For ", state_two, ", the suicide rate trend is quite different. In 2000, the suicide rate of ", state_two, " is ", state_two_2000$Rate, "per 100,000,
        and the sucide rate in 2010 is ", state_two_2010$Rate, "per 100,000. The highest sucide rate happened in ", state_two_max$Year, " with a suicide rate of ", 
        state_two_max_row$Rate, "per 100,000. The lowest suicide rate happened in ", state_two_min$Year, ", and the suicide rate is ", state_two_min_row$Rate, "per 100,000. The state suicide rate trend and 
        national suicide rate trend have different patterns. We want to explore both internal and external factors associated with depressing and suicide. More information about risk 
        factors could be found on later tabs.")
  
  output_text
}


