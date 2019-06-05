library(plyr)
library(dplyr)
library(tidyr)
library(ggplot2)

create_plot <- function(df, select){
  if(select == 'GDP'){
    p <- ggplot(df, aes(x=suicide_rate, y=gdp)) + 
      geom_point()+
      geom_smooth(method=lm)+
      labs(title = 'The relationship between GDP and Suicide Rate', x = 'Suicide Rate(Unit:Percentage)',
           y = 'GDP Per Capita(Unit:Percentage)')
  } else if(select == 'Health'){
    p <- ggplot(df, aes(x=suicide_rate, y=health_spend)) + 
      geom_point()+
      geom_smooth(method=lm)+
      labs(title = 'The relationship between Health Expenditure and Suicide Rate', x = 'Suicide Rate(Unit:Percentage)',
           y = 'Health Expenditure(Unit:Percentage)')
  } else if(select == 'Unemployment'){
    p <- ggplot(df, aes(x=suicide_rate, y=unemployment)) + 
      geom_point()+
      geom_smooth(method=lm)+
      labs(title = 'The relationship between Unemployment Rate and Suicide Rate', x = 'Suicide Rate(Unit:Percentage)',
           y = 'Unemployment Rate(Unit:Percentage)')
  }
  return(p)
}

create_text <- function(select){
  if(select == 'GDP'){
    text <- 'According to the definition of GDP per capita, it is the best measurement of a 
    standard of living in a country and how prosperous a country feels to each of its citizens. 
    Then, I am very curious about if the suicide prevalence or mental health condition in a country 
    is related to the living standard or economic growth. Does better life quality mean lower suicide 
    rates? So for the first section, we compare the suicide rates with the GDP per capita in each country to 
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
    text <- 'As some cases of suicide accident were related to losing a job or economic regression, we want to explore if
    the unemployment rate is a determinant external factor to suicide rates. According to the visual output, 
    we can tell the distribution of the unemployment rate 
    and the suicide rate is pretty random and distributed. We can not observe any obvious relation between 
    these two variables which means the unemployment rate is not an external factor related to the suicide 
    rates.'
  }
  return(text)
}
  

