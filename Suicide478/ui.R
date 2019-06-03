#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(markdown)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(tagList(
  navbarPage(theme = shinytheme("slate"),
             "Suicide",
             
             # Claire's Panel
             tabPanel(
               "About Suicide",
               
               includeCSS("style.css"),
               tabsetPanel(
                 #tab1 introduction
                 tabPanel(
                   "Introduction"
                   # includeMarkdown("Script/TaxMarkDown.Rmd")
                 ),
                 
                 # more panels overhere
                 tabPanel(
                   "Sub - Panel 2"
                   # includeMarkdown("Script/TaxMarkDown.Rmd")
                 )
               )
             ),
             
             # Carol's Panel
             tabPanel(
               "Worldwide Statistics",
               titlePanel(tags$div(tags$h1(class = "Title",
                                           "External Factors"))),
               sidebarLayout(
                 
                 sidebarPanel(
                   selectInput('external_factors', 
                                label = h3('Choose an possible external factor'),
                  choices = list(
                    'GDP' = 'GDP',
                    'Health Expenditure' = 'Health',
                    'Unemployment Rate' = 'Unemployment'
                  ),
                  width = '200px'
                 ),
                 tags$br(),
                 tags$h3("Description"),
                 tags$h5(class = "context",
                         "With this interactive bar chart, you can explore the
                         dataset within different time periods. In the specific
                         decade you choose, the graph displays numbers of shark
                         attacks against different time periods. For instance,
                         if you want to learn about the month with the highest
                         frequency of attacks and the month with less frequency of
                         attacks between 2010-2017. You can do this in two simple
                         steps:"),
                 tags$h5(class = "context", "1. Set the decade to 2010-2017"),
                 tags$h5(class = "context", "2. Set the unit, time period, as month."),
                 tags$h5(class = "context", "That's it! Feel free to explore!")
                
               ),
               mainPanel(
                 plotOutput("external_plot",
                            width = "800px", height = "600px"
                 )
             )
               )
            ),
             
             # Daisy's Panel
             tabPanel(
               "Risk Factors of Suicide",
               tabsetPanel(
                 #tab1 introduction
                 tabPanel(
                   "Introduction"
                   # includeMarkdown("Script/TaxMarkDown.Rmd")
                 ),
                 
                 # more panels overhere
                 tabPanel(
                   "Sub - Panel 2"
                   # includeMarkdown("Script/TaxMarkDown.Rmd")
                 )
               )
             ),
             
             # Mengjiao's Panel
             tabPanel(
               "Preventive Factors of Suicide",
               tabsetPanel(
                 #tab1 introduction
                 tabPanel(
                   "Introduction"
                   # includeMarkdown("Script/TaxMarkDown.Rmd")
                 ),
                 
                 # more panels overhere
                 tabPanel(
                   "Sub - Panel 2"
                   # includeMarkdown("Script/TaxMarkDown.Rmd")
                 )
               )
             )
  )
))
