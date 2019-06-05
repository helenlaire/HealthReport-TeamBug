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

source("Prevention-Mengjiao/prevention_analysis.R")


# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  
  ## Claire's Code
  output$trend_graph <- renderPlotly({
    return(overall_trend(combined_df, input$region1, input$region2,input$gender))
  })  
  ## Daisy's Code
  
  # load the data 
  data <- reactive({
    data <- read.csv(paste0("data/", input$year, "_rr.csv"))
    data
  })
  
  output$dotPlot <- renderPlot({
    ggplot(data(), aes(y = Value, x = Metric, color = Sex)) +
      geom_point() +
      xlab("Relative Risk Factors") +
      ylab("Relative Risk") +
      labs(title = "Relative Risk Analysis For Depressive Order")
  })
  
  output$footnote <- renderPrint({
    cat("1. College: college students who have been studying for 1 to 3 years", 
        "2. Divorce: people who are divorced", 
        "3. Limited Activities: people who have limited activities due to health problems",
        "4. Multiple Cancer: people who have three or more cancers",
        "5. No Job: people who are out of work for 1 year or more", 
        "* some year may not have certain data which is not shown in the graph",
        sep="\n\n")
  })
  
  generatesText <- function(temp) {
    for (i in 1:nrow(temp)) {
      metric = as.character(temp[i, ]$Metric)
      if (metric == 'College') {
        metric = "college student who studied for 1 to 3 years"
      } else if (metric == "Divorce") {
        metric = "the divorced"
      } else if (metric == "No_Job") {
        metric = "people who were out of work for at least 1 year"
      } else if (metric == "Limited_Activities") {
        metric = "people who could only do limited activites due to health problems"
      } else {
        metric = "people who have more than 3 or more types of cancers"
      }
      sex = as.character(temp[i, ]$Sex)
      value = as.character(round(temp[i, ]$Value, 2))
      cat("The risk of developing depressive order was ", value, 
          " times higher for ", metric, " than for those who weren't ", metric,"\n\n", sep = '') 
    }
  } 
  
  output$explain_male <- renderPrint({
    cat("In year ", 
        input$year, 
        ", the relative risks for depressive order for males are as followed: \n\n", sep = '')
    temp <- data() %>% filter(Sex == "Male")
    generatesText(temp)
  })
  
  output$explain_female <- renderPrint({
    cat("In year ", 
        input$year, 
        ", the relative risks for depressive order for females are as followed: \n\n", sep = '')
    temp <- data() %>% filter(Sex == "Female")
    generatesText(temp)
  })
  
  
  
  
  
  
  
  
  
  
  
  ## Mengjiao's Code
  output$years_factors_plot <- renderPlot({
    dataset <- mental_data
    factors <- input$choose_factors
    
    filter_factors <- append(c("Year", "MENTHLTH"), factors)
    years <- input$choose_year

    adjusted_dataset <- dataset[, filter_factors] %>%
      dplyr::filter(Year %in% years) %>%
      dplyr::mutate(Year = as.factor(Year))
    
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
      geom_line(aes(col = Year), na.rm = TRUE) + 
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
      dplyr::filter(Year %in% years) %>%
      spread(key = Year, value = `factors`)
    
    head(adjusted_dataset, n = 100)
  })
  
  ## Carol's Code
  output$external_plot <- renderPlot({
    return(create_plot(external, input$external_factors))
  })
  
  output$interp <- renderText({
    return(create_text(input$external_factors))
  })
})
