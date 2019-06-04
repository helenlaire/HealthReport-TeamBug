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
external <- read.csv(file = "../External_Factors/data/prepare_data.csv")
source("../Overall-Claire/analysis.R")
combined_df <- read.csv(file = "../Overall-Claire/data/combined.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  
  ## Claire's Code
  output$trend_graph <- renderPlot({
    return(overall_trend(combined_df, input$region1, input$region2,input$gender))
  })  
  ## Daisy's Code
  
  
  ## Mengjiao's Code
  
  
  ## Carol's Code
  output$external_plot <- renderPlot({
    return(create_plot(external, input$external_factors))
  })
  
  
})
