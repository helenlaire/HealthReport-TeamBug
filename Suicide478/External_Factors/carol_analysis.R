library(plyr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(plotly)
#Create function to display the plot
create_plot <- function(df, select){
  
#Create plot when users choose GDP 
  if(select == 'GDP'){
    p <- ggplot(df, aes(y=suicide_rate, x=gdp, label = country)) + 
      geom_point()+
      geom_smooth(method=lm)+
      labs(title = 'The relationship between GDP and Suicide Rate', y = 'Suicide Rate(Unit:Numbers per 100k Population)',
           x = 'GDP Per Capita(Unit:US$)')
    
#Create plot when users choose Health
  } else if(select == 'Health'){
    p <- ggplot(df, aes(y=suicide_rate, x=health_spend, label = country)) + 
      geom_point()+
      geom_smooth(method=lm)+
      labs(title = 'The relationship between Health Expenditure per Capita and Suicide Rate', y = 'Suicide Rate(Unit:Numbers per 100k Population)',
           x = 'Health Expenditure per capita(Unit:US$)')
    
#Create plot when users choose Unemployment
  } else if(select == 'Unemployment'){
    p <- ggplot(df, aes(y=suicide_rate, x=unemployment, label = country)) + 
      geom_point()+
      geom_smooth(method=lm)+
      labs(title = 'The relationship between Unemployment Rate and Suicide Rate', y = 'Suicide Rate(Unit:Numbers per 100k Population)',
           x = 'Unemployment Rate(Unit:Percentage)')
  }
  
#use plotly package to return the plot with hover function
  ggplotly(p)
}

#create function for interpretation under different visuals
create_text <- function(select){
  
  #Interpretation for GDP VS. Suicide Rates
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
    
  #Interpretation for Health Expenditure VS. Suicide Rates
  }else if(select == 'Health'){
    text <- 'When comparing the health expenditure per capita with the suicide rates, my assumption is the country with 
    higher health expenditure per capita may have lower suicide rates because there is more available medical recourse 
    for those people who have suicide trend. However, the output turns not consistent as my assumption. 
    According to the regression line, health expenditure and suicide rates have some degrees of a positive 
    relationship. And most countries with lower health expenditure have lower suicide rates than countries 
    with higher health expenditure. Therefore, health expenditure is not a determinant external factor to 
    the suicide rates.'
    
  #Interpretation for Unemployment VS. Suicide Rates
  }else if(select == 'Unemployment'){
    text <- 'As some cases of suicide accident were related to losing a job or economic regression, we want to explore if
    the unemployment rate is a determinant external factor to suicide rates. According to the visual output, 
    we can tell the distribution of the unemployment rate 
    and the suicide rate is pretty random and distributed. We can not observe any obvious relation between 
    these two variables which means the unemployment rate is not an external factor related to the suicide 
    rates.'
  }
  
  #Return text content
  return(text)
}
  

