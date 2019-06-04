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
library(DT)

year_list <- list("2011" = 2011, 
                  "2012" = 2012,
                  "2013" = 2013,
                  "2014" = 2014,
                  "2015" = 2015)

protective_factor_list <- list("Health Care Coverage" = "HLTHPLN1", 
                               "Affordability of Medical Cost" = "MEDCOST",
                               "Exercises" = "EXERANY2",
                               "Frequency of getting emotional support" = "EMTSUPRT",
                               "Degree of Life Satisfaction" = "LSATISFY",
                               "Education Level" = "EDUCA")

# Define UI for application that draws a histogram
shinyUI(tagList(
  navbarPage(theme = shinytheme("slate"),
             "Suicide",
             
             # Claire's Panel
             tabPanel(
               "About Suicide",
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
               "Protective Factors of Mental Health",
               tabsetPanel(
                 
                 #tab1 How does the availability of health care impact the chance of one committing suicide
                 tabPanel(
                   "Comparison of Protective Factors on Mental Helath Across Years",
                   h4("Chose your interested protective factors to see the trend on how it assocaiated with mental health for past several years."),
                   
                   
                   # sidebar panel
                   sidebarPanel(
                     
                     selectInput("choose_factors", label = h4("Choose Protective Factors"), 
                                 choices = protective_factor_list, 
                                 selected = "HLTHPLN1"),
                     
                     checkboxGroupInput("choose_year", label = h4("Choose Years"), 
                                        choices = year_list,
                                        selected = year_list),
                     
                     actionButton("UncheckYear", label = "Check/Uncheck Year"),
                     
                     br(),
                     helpText("Please note that the data for 'Frequency of getting emotional support' and 'Degree of Life Satisfaction' is not available in 2011 and 2012")
                     
                   ),
                   
                   
                   # main panel
                   mainPanel(
                     tabsetPanel(
                       id = 'subpanels1',
                       tabPanel(
                         "Line Plot",
                         plotOutput("years_factors_plot", width = "100%"),
                         br(),
                         textOutput("risk_factor_text"),
                         textOutput("year_text")
                        ),
                       tabPanel(
                         "View Data",
                         tableOutput("chartTable"))
                    )
                  )
                )
               )
             )
  )
))
