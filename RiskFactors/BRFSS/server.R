library(shiny)
library(dplyr)
library(ggplot2)
source("RR Analysis.R")
shinyServer(function(input, output) {
  
  output$distPlotDD <- renderPlot({
    ggplot(mental, aes(ADDOWN, fill = ADDEPEV2)) +
      geom_bar() +
      xlab("Days felt down, depressed or hopeless over the last 2 weeks") +
      ylab("Frequency") +
      labs(title = "Distribution of Days felt down, depressed or hopeless in year 2011", 
           fill = "Depressive Disorder")
  })
  
  output$distPlotDS <- renderPlot({
    ggplot(mental, aes(ADSLEEP, fill = ADDEPEV2)) +
      geom_bar() +
      xlab("Days had trouble with sleep over the last 2 weeks ") +
      ylab("Frequency") +
      labs(title = "Distribution of Days had trouble with sleep in year 2011", 
           fill = "Depressive Disorder")
  })
})
