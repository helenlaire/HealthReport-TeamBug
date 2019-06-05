
library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Risk Factors For Depressive Disorder"),
   
  sidebarLayout(
    
    sidebarPanel(
      radioButtons("year", "Select the year:", 
                  c(2011, 2012, 2013, 2014, 2015)),
      verbatimTextOutput("footnote"),
      tags$head(tags$style(HTML("
                            #footnote {
                              font-size: 11px;
                            }
                            ")))
    ),
    mainPanel(
        plotOutput("dotPlot"),
        tabsetPanel(
          tabPanel("Male", verbatimTextOutput("explain_male"),
                   tags$head(tags$style(HTML("
                              #explain_male {
                                font-size: 11px;
                              }
                              ")))),
          tabPanel("Female", verbatimTextOutput("explain_female"),
                   tags$head(tags$style(HTML("
                                             #explain_female {
                                             font-size: 11px;
                                             }
                                             "))))
          
        )
    )
    
  )
))
