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

combined_df <- read.csv(file = "../Overall-Claire/data/combined.csv")
state_list <- unique(combined_df$States)
gender_list <- unique(combined_df$Gender)

# Define UI for application that draws a histogram
shinyUI(tagList(
  navbarPage(theme = shinytheme("slate"),
             "Suicide",
             # Claire's Panel
             tabPanel(
               "Overall Trend",
               includeCSS('style.css'),
               titlePanel(tags$div(tags$h1(class = "Title",
                                           "Intentional Self-Harm Trend"))),
               sidebarLayout(
                 sidebarPanel(
                   selectInput('region1', 
                               label = h3('Select a State'),
                               choices = state_list,
                               width = '200px'),
                   selectInput('region2', 
                               label = h3('Select a State'),
                               choices = state_list,
                               width = '200px'),
                   selectInput('gender', 
                               label = h3('Select a Gender'),
                               choices = gender_list,
                               width = '200px'),
                   tags$br(),
                   tags$h3("Description"),
                   tags$h5(class = "context",
                           "With this interactive bar chart, you can explore the"),
                   tags$h5(class = "context", "1. Set the decade to 2010-2017")
                   
                 ),
                 mainPanel(
                   plotOutput("trend_graph",
                              width = "800px", height = "600px"
                   )
                 )
               )
             ),
             
             # Carol's Panel
             tabPanel(
               "Worldwide Statistics",
               titlePanel(tags$div(tags$h1(class = "Title",
                                           "Worldwide Statistics: External Factors"))),
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
               "Risk Factors of Depression",
               
               titlePanel("Risk Factors For Depressive Disorder"),
               
               sidebarLayout(
                 
                 sidebarPanel(
                   radioButtons("year", "Select the year:", 
                                c(2011, 2012, 2013, 2014, 2015)),
                   tags$h2("Risk Factors"),
                   tags$h5(class = "context", "College: college students who have been studying for 1 to 3 years"),
                   tags$h5(class = "context", "Divorce: people who are divorced"), 
                   tags$h5(class = "context", "Limited Activities: people who have limited activities due to health problems"),
                   tags$h5(class = "context", "Multiple Cancer: people who have three or more cancers"),
                   tags$h5(class = "context", "No Job: people who are out of work for 1 year or more"), 
                   tags$h5(class = "context", "* some year may not have certain data which is not shown in the graph")
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
             ),
             
             # Mengjiao's Panel
             tabPanel(
               "Protective Factors of Mental Health",
                  titlePanel(tags$div(tags$h1(class = "Title",
                                           "US Statistics: Protective Factors"))),
                   
                   # sidebar panel
                   sidebarPanel(
                     selectInput("choose_factors", label = tags$h3("Choose Protective Factors"), 
                                 choices = protective_factor_list, 
                                 selected = "HLTHPLN1"),
                     
                     checkboxGroupInput("choose_year", label = tags$h3("Choose Years"), 
                                        choices = year_list,
                                        selected = year_list),
                     
                     actionButton("UncheckYear", label = "Check/Uncheck Year"),
                     
                     tags$br(),
                     helpText("Please note that the data for 'Frequency of getting emotional support' and 'Degree of Life Satisfaction' is not available in 2011 and 2012")
                     
                   ),
                   
                   # main panel
                   mainPanel(
                     tabsetPanel(
                       id = 'subpanels1',
                       tabPanel(
                         "Line Plot",
                         plotOutput("years_factors_plot", width = "100%"),
                         tags$br(),
                         textOutput("risk_factor_text"),
                         textOutput("year_text")
                        ),
                       tabPanel(
                         "View Data",
                         tableOutput("chartTable")
                       )
                   )
                )
             )
  )
))
