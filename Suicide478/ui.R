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

combined_df <- read.csv(file = "Overall-Claire/data/combined.csv")
combined_list <- combined_df %>% dplyr::filter(States != "United States")
state_list <- unique(combined_list$States) 
gender_list <- unique(combined_df$Gender)

shinyUI(tagList(
  headerPanel("Suicide Prevention Guide"),
  fluidPage(
    theme = shinytheme("slate"),
    tabsetPanel(
            #introduction
            tabPanel(
              "Introduction",
              includeMarkdown("IntroductionPage.Rmd")

            ),
    
    
             # Overall trend panel
             tabPanel(
               "Overall Trend",
               includeCSS('style.css'),
               titlePanel(tags$div(tags$h1(class = "Title","Suicide Trend"))),
               tags$h5("In this section, we focus on the U.S. suicide trend across years. We want to study the suicide 
                       rate trend in different states in the U.S.: how the suicide rate for a specific state changes 
                       from 2000 to 2010, how is the suicide rate of a state compared to the national suicide rate, 
                       and how the suicide rates in two different states comparing to each other, and how the suicide 
                       rate trend differ between female and male. The data was accessed from Center for Disease Control 
                       and Prevention. It includes information about suicide rate in all states in the U.S. from 2000 to 2010. 
                       In the panel below, you can choose two states in the U.S., choose either female or male, and the graph 
                       below will show you the trend in your selected states."),
               tags$br(),
               
               # for user to select two states and gender
               sidebarLayout(
                 sidebarPanel(
                   selectInput('region1', 
                               label = tags$h2('Select First State'),
                               choices = state_list,
                               width = '200px'),
                   selectInput('region2', 
                               label = tags$h2('Select Second State'),
                               choices = state_list,selected = "California",
                               width = '200px'),
                   selectInput('gender', 
                               label = tags$h2('Select a Gender'),
                               choices = gender_list,
                               width = '200px')
                   
                  ),
                 
                 # render graph and interpretation about the graph
                 mainPanel(
                   plotlyOutput("trend_graph",
                              width = "800px", height = "600px"
                   ),
                   br(),
                   tags$h2("Interpretation"),
                   tags$h5(textOutput('overall'))
                 )
               )
             ),
             
             # Carol's Panel
             tabPanel(
               #Panel Title
               "Worldwide Statistics",
               #Title on the top
               titlePanel(tags$div(tags$h1(class = "Title",
                                           "Worldwide Statistics: External Factors"))),
               #Description and introduction for this panel
               tags$h5("In this section, we are exploring three possible external factors, 
                       GDP per capita, Health expenditure per capita, and Unemployment rate which may affect 
                       suicide rates.  To see if there is any relationship or correlation between 
                       these possible external factors and suicide rates at the national level. 
                       We use the mean suicide rates from 1985 to 2010 for each country, 
                       mean GDP per capita from 1985 to 2010 for each country, mean unemployment rates 
                       from 2010 to 2014 and mean health expenditure per capita 
                       from 1995 to 2010 as indicators to do the analysis. You can do this in one simple
                       step: Use below panel to select the external factor you want to
                         explore!"),
               tags$br(),
               
               sidebarLayout(
                 
                 sidebarPanel(
                   #select widget to choose users' interested external factors analysis
                   selectInput('external_factors', 
                      tags$h2('Choose An Possible External Factor!'),
                      choices = list(
                        'GDP' = 'GDP',
                        'Health Expenditure per capita' = 'Health',
                        'Unemployment Rate' = 'Unemployment'),
                      width = '200px'
                   ),
                   tags$br(),
                   
                   #Description and definition for three external factors
                   tags$h2("External Factors"),
                   tags$h5("GDP per capita: GDP per capita is a measure of a country's economic output that accounts 
                     for its number of people. It divides the country's gross domestic product by its total 
                     population. That makes it the best measurement of a country's standard of living. 
                     It tells you how prosperous a country feels to each of its citizens."
                   ),
                   tags$br(),
                   tags$h5("Health Expenditure per capita: Expenditure on health per capita is the sum 
                      of general government health expenditure and private health expenditure in a given 
                      year divided by total popualtion in a country, calculated in national currency units 
                      in current prices. It also reflects the avaliable 
                      medical resources for each citizen and the development of health care system in a country."
                   ),
                   tags$br(),
                   tags$h5("Unemployment Rate: The unemployment rate is defined as the percentage of unemployed workers in the 
                          total labor force. Workers are considered unemployed if they currently do not work, 
                          despite the fact that they are able and willing to do so.")
                 
                 
              ),
              #Visualization
              mainPanel(
                 plotlyOutput("external_plot",
                            width = "800px", height = "600px"
                 ),
                 #Interpretation
                 tags$h2("Interpretation"),
                 tags$h5(textOutput('interp'))
              )
             )
            ),
             
             # Daisy's Panel
            # The panel of relative risk analysis for depressive disorder
            tabPanel(
              "Risk Factors of Depression",
              titlePanel(tags$div(tags$h1(class = "Title",
                                          "US Statistics: Risk Factors For Depressive Disorder"))),
              # Introduction of the section
              tags$h5("In this section, we are exploring three to five risk factors of
                      depressive disorder to see what exposure might be highly correlated to depression
                      at the US level across years from 2011 to 2015 and sex. 
                      We calculated the relative risks of depression for college students who have 
                      been studying for 1 to 3 years,
                      people who are divorced, people who have limited activities due to health problems,
                      people who have three or more cancers and people who are out of work for 1 year or more.
                      Use the panel below to select the year you want to
                      explore!"),
              tags$br(),
              
              # The graph and context section
              sidebarLayout(
                # Year selection section
                sidebarPanel(
                  radioButtons("year", tags$h2("Select the year"), 
                               c(2011, 2012, 2013, 2014, 2015)),
                  tags$br(),
                  tags$h2("Risk Factors"),
                  tags$h5("College: college students who have been studying for 1 to 3 years"),
                  tags$h5("Divorce: people who are divorced"), 
                  tags$h5("Limited Activities: people who have limited activities due to health problems"),
                  tags$h5("Multiple Cancer: people who have three or more cancers"),
                  tags$h5("No Job: people who are out of work for 1 year or more"), 
                  tags$h5("* some year may not have certain data which is not shown in the graph")
                ),
                mainPanel(
                  # Can switch from graph to words and words to graph
                  tabsetPanel(
                    tabPanel("Graph",  plotlyOutput("dotPlot")),
                    tabPanel("Context",  tabsetPanel(
                      tabPanel("Male", tags$h5(class = "context", 
                                               textOutput("explain_male"))),
                      tabPanel("Female", tags$h5(class = "context", 
                                                 textOutput("explain_female")))
                    ))
                  ),
                  # A explanatory section for the graph generated 
                  tags$h2("Interpretation"),
                  tags$h5(textOutput('rr_analysis'))
                )
              )
              ),
             
             # Mengjiao's Panel
             tabPanel(
               "Protective Factors of Mental Health",
                  
                  # a title for the tab
                  titlePanel(
                    tags$div(tags$h1(class = "Title",
                                           "US Statistics: Protective Factors"))
                  ),
               
                  # brief description of the tab
                  tags$h5("In this section, we are exploring six possible protective factors: 'availability health care', 'affordability of health care', 'Positive physical development - Exercise', 'Education', 'Emotional support', 'Degree of Life Satisfaction'. 
                           These factors are carefully selected based on past literatures and availability of data. Our data come from Behavior Risk Factor Surveillance System from 2011 to 2015 and wrangled through package of 'svydesign'. The package is chosen in order to 
                           correctly weight the data and output percentage that each group experienced. It is further combined through R into smaller dataset that this application is using.
                           Since it is impossible to experimentally measure the causation effect of factors on suicide due to ethical reasons, the factors are instead associated with reported days of mental health feeling not good, as it often predicts depression, anxiety
                            disorder and many other mental illness. Users are able to explore their interested protective factors by seeing how it's association with mental health has changed across years. To interact with the system, 
                           users could first choose their interested protective factor, then check their interested years.
                           The line graph that displayed one the side panel indicate both the changing of association across years, as well as an estimation of association line for all data in selected years.
                           A chart table is also available for anyone who might be interested in the data."),
                  br(),
             
                   # sidebar panel
                   sidebarPanel(
                     # select-box: choose one protective factor
                     selectInput("choose_factors", label = tags$h2("Choose Protective Factors"), 
                                 choices = protective_factor_list, 
                                 selected = "HLTHPLN1"),
                     
                     # check-box: choose year
                     checkboxGroupInput("choose_year", label = tags$h2("Choose Years"), 
                                        choices = year_list,
                                        selected = year_list),
                     
                     # action button: check and uncheck all selections of checkbox "choose_year"
                     actionButton("UncheckYear", label = "Check/Uncheck Year"),
                     
                     # brief explanations for all the protective factors mentioned above
                     tags$br(),
                     tags$h2("Protective Factors"),
                     tags$h5("Health Care Coverage: people who are under health care coverage"),
                     tags$h5("Affordability of Medical Cost: peope who need to see doctor but could not because of cost in the past one year"),
                     tags$h5("Exercises: people who participate in regular exercise"),
                     tags$h5("Frequency of getting emotional support: people who get regular and emotional support that they need"),
                     tags$h5("Degree of Life Satisfaction: people who are satisfy with their life"),
                     tags$h5("Education Level: people who have completed high school"),
                     tags$br(),
                     tags$h6("*Please note that the data for 'Frequency of getting emotional support' and 'Degree of Life Satisfaction' is not available in 2011 and 2012"),
                     tags$br()
                   ),
                   
                   # main panel
                   mainPanel(
                     tabsetPanel(
                       tabPanel(
                         "Line Plot",
                         
                         # render a line plot for observing associations between protective factors and mental illness on when year is selected
                         conditionalPanel("input.choose_year != 0", plotlyOutput("years_factors_plot", width = "100%")),
                         tags$br(),
                         
                         # render users choices and interpretation for the line plot
                         tags$h6(textOutput("risk_factor_text")),
                         tags$h6(textOutput("year_text")),
                         tags$h2("Interpretation"),
                         tags$h5(textOutput("interpretation_protective")),
                         tags$h5(textOutput("interpretation_protective_trends"))
                         
                        ),
                       
                       # render a chart for direct data observation
                       tabPanel(
                         "View Data",
                         tableOutput("chartTable")
                       )
                   )
                )
             )
    )
  )
))
