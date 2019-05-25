
library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Risk Factors For Mental Health"),
  h5("The graphs take a while to load...I will add a progress bar later"),
   
  sidebarLayout(
    sidebarPanel(
      selectInput("measure", "Select the desired risk factor of mental health:", 
                  choices = list('Days felt down', 
                                 'Days had trouble with sleep'))
    ),
    
    mainPanel(
      conditionalPanel(
        condition = "input.measure == 'Days felt down'",
        plotOutput("distPlotDD")
      ),
      conditionalPanel(
        condition = "input.measure == 'Days had trouble with sleep'",
        plotOutput("distPlotDS")
      )
    )
  )
))
