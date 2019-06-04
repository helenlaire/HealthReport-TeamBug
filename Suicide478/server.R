#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

source("Prevention-Mengjiao/prevention_analysis.R")


# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  
  ## Claire's Code
  
  
  ## Daisy's Code
  
  
  ## Mengjiao's Code

  
  # ADD REACTIVE FUNCTION FOR DATASET

  
  output$years_factors_plot <- renderPlot({
    dataset <- mental_data
    factors <- input$choose_factors
    
    filter_factors <- append(c("Year", "MENTHLTH"), factors)
    years <- input$choose_year

    adjusted_dataset <- dataset[, filter_factors] %>%
      filter(Year %in% years) %>%
      mutate(Year = as.factor(Year))
    
    factor_col <- adjusted_dataset[, factors]
    
    output$risk_factor_text <- renderText({
      paste0("You have chosen risk factor: ", changefactor(input$choose_factors))
    })
    
    output$year_text <- renderText({
      chosen_year <- paste(input$choose_year,collapse=" ")
      paste0("You have chose the following years: ", chosen_year)
    })
    
    if (length(input$choose_year) == 0) {
      plot_title <- paste0("Year has not been selected")
    } else if (length(input$choose_year) == 1) {
      plot_title <- paste0("Days of Mental Health Not Good for the Past 30 Days in ", input$choose_year, " by ", changefactor(input$choose_factors))
    } else if (length(input$choose_year) > 1) {
      plot_title <- paste0("Days of Mental Health Not Good for the Past 30 Days from ", input$choose_year[1], " to ", tail(input$choose_year, n=1), " by ", changefactor(input$choose_factors))
    }
    
    plot <- ggplot(adjusted_dataset, aes(x=MENTHLTH, y=factor_col)) + 
      geom_line(aes(col = as.factor(Year)), na.rm = TRUE) + 
      geom_smooth(method="lm", se=F, na.rm = TRUE) +
      labs(title=plot_title,
           x = "Days of Mental Health Not Good for the Past 30 Days",
           y = "Percentage of Risk Factors within the Year",
           caption="source: BRFSS 2011-2015") + 
      theme_dark() + 
      theme(plot.background = element_rect(fill = "grey88")) + 
      ylim(0, 1)

    return(plot)
  })
  
  observe({
    if (input$UncheckYear > 0) {
      if (input$UncheckYear %% 2 == 0){
        updateCheckboxGroupInput(session=session,
                                 inputId="choose_year",
                                 choices = year_list,
                                 selected = year_list)
        
      } else {
        updateCheckboxGroupInput(session=session,
                                 inputId="choose_year",
                                 choices = year_list,
                                 selected = "")
      }
    }
  })
  
  
  output$chartTable <- renderTable({
    dataset <- mental_data
    factors <- input$choose_factors
    
    filter_factors <- append(c("Year", "MENTHLTH"), factors)
    years <- input$choose_year 
    
    adjusted_dataset <- dataset[, filter_factors] %>%
      filter(Year %in% years) %>%
      spread(key = Year, value = `factors`)
    
    head(adjusted_dataset, n = 100)
  })
  
  ## Carol's Code
  
  
  
})
