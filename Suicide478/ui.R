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
                                label = h3('Choose An Possible External Factor!'),
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
                         "In this section, we are exploring three possible external factors, 
                          GDP per capita, Health expenditure, and Unemployment rate which may affect 
                          suicide rates.  To see if there is any relationship or correlation between 
                          these possible external factors and suicide rates at the national level. 
                          We use the mean suicide rates from 1985 to 2010 for each country, 
                          mean GDP per capita from 1985 to 2010 for each country, mean unemployment rates 
                          from 2010 to 2014 and mean health expenditure from 1995 to 2010 as indicators to 
                          do the analysis.  You can do this in one simple
                         step:"),
                 tags$h5(class = "context", "1. Use above panel to select the external factor you want to
                         explore"),
                 tags$h3("Interpretation"),
                 tags$h5(class = "context", textOutput('interp'))
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
