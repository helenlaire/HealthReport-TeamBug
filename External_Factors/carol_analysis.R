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

create_text <- function(select){
  if(select == 'GDP'){
    text <- 'For the first section, we compare the suicide rates with the GDP per capita in each country to 
    see if there is any relationship between them. However, according to the 
    visual, we do not see any obvious correlation between these two variables. Countries with lower GDP per 
    capita have varied suicide rates in a wide range and countries with higher GDP do not have obviously 
    lower suicide rates or higher suicide rates compared to other countries. Therefore, GDP per capita may 
    not be determinant external factors to suicide rates.'
  }else if(select == 'Health'){
    text <- 'When comparing the health expenditure with the suicide rates, my assumption is the country with 
    higher health expenditure may have lower suicide rates because there is more available medical recourse 
    for those people who have suicide trend. However, the output turns not consistent as my assumption. 
    According to the regression line, health expenditure and suicide rates have some degrees of a positive 
    relationship. And most countries with lower health expenditure have lower suicide rates than countries 
    with higher health expenditure. Therefore, health expenditure is not a determinant external factor to 
    the suicide rates.'
  }else if(select == 'Unemployment'){
    text <- 'c'
  }
  return(text)
}
  

