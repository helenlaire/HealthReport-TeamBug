#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
source("../External_Factors/carol_analysis.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  
  ## Claire's Code
  
  
  ## Daisy's Code
  
  
  ## Mengjiao's Code
  
  
  ## Carol's Code
  output$external_plot <- renderPlot({
    return(create_plot(all_data, input$`external factors`))
  })
  
  
})
