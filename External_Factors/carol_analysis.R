library(plyr)
library(dplyr)
library(tidyr)
library(ggplot2)

create_plot <- function(df, select){
  if(select == 'GDP'){
    p <- ggplot(df, aes(x=suicide_rate, y=gdp)) + 
      geom_point()+
      geom_smooth(method=lm)+
      labs(title = 'The relationship between GDP and Suicide Rate', x = 'Suicide Rate',
           y = 'GDP Per Capita')
  } else if(select == 'Health'){
    p <- ggplot(df, aes(x=suicide_rate, y=health_spend)) + 
      geom_point()+
      geom_smooth(method=lm)+
      labs(title = 'The relationship between Health Expenditure and Suicide Rate', x = 'Suicide Rate',
           y = 'Health Expenditure')
  } else if(select == 'Unemployment'){
    p <- ggplot(df, aes(x=suicide_rate, y=unemployment)) + 
      geom_point()+
      geom_smooth(method=lm)+
      labs(title = 'The relationship between Unemployment Rate and Suicide Rate', x = 'Suicide Rate',
           y = 'Unemployment Rate')
  }
  return(p)
}
  

