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
