library(plyr)
library(dplyr)
library(tidyr)
library(ggplot2)
#read data
suicide <- read.csv('data/suicide.csv')
health_spend <- read.csv('data/health_spending.csv')
unemployment <- read.csv('data/unemployment.csv')
suicide_rate <- suicide %>% select(country, year, suicides.100k.pop, gdp_per_capita....) %>% 
  group_by(country, year) %>% summarise(suicide_rate = sum(suicides.100k.pop, na.rm = TRUE)) %>% 
  group_by(country) %>% summarise(suicide_rate = mean(suicide_rate))
health_spend <- health_spend %>% gather(year, value, -1) %>% group_by(X) %>% 
  summarise(health_spend = mean(value, na.rm = T)) %>% filter(health_spend != "NaN")
colnames(health_spend) <- c('country', 'health_spend')
all_data <- join(suicide_rate, health_spend, type = 'left', by = 'country')
unemployment <- unemployment %>% select(-Country.Code) %>% gather(year, unemployment, -1) %>% 
  group_by(Country.Name) %>% summarise(unemployment = mean(unemployment, na.rm = T))
colnames(unemployment) <- c('country', 'unemployment')
all_data <- join(all_data, unemployment, type = 'left', by = 'country')
gdp <- suicide %>% select(country, gdp_per_capita...., year) %>% distinct() %>% group_by(country) %>% 
  summarise(gdp = round(mean(gdp_per_capita...., na.rm = T), 0))
all_data <- join(all_data, gdp, type = 'left', by = 'country')


create_plot <- function(df, select){
  if(select == 'GDP'){
    p <- ggplot(df, aes(x=suicide_rate, y=gdp)) + 
      geom_point(size = 2)+
      geom_smooth(method=lm)+
      labs(title = 'The relationship between GDP and Suicide Rate', x = 'Suicide Rate',
           y = 'GDP Per Capita')
  } else if(select == 'Health'){
    p <- ggplot(df, aes(x=suicide_rate, y=health_spend)) + 
      geom_point(size = 2)+
      geom_smooth(method=lm)+
      labs(title = 'The relationship between Health Expenditure and Suicide Rate', x = 'Suicide Rate',
           y = 'Health Expenditure')
  } else if(select == 'Unemployment'){
    p <- ggplot(df, aes(x=suicide_rate, y=unemployment)) + 
      geom_point(size = 2)+
      geom_smooth(method=lm)+
      labs(title = 'The relationship between Unemployment Rate and Suicide Rate', x = 'Suicide Rate',
           y = 'Unemployment Rate')
  }
  return(p)
}
  

