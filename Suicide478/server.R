#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
source("External_Factors/carol_analysis.R")
external <- read.csv(file = "External_Factors/data/prepare_data.csv")
source("Overall-Claire/analysis.R")
combined_df <- read.csv(file = "Overall-Claire/data/combined.csv")
source("Prevention-Mengjiao/prevention_analysis.R")


# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

  ## Claire's Code
  output$trend_graph <- renderPlotly({
    return(overall_trend(combined_df, input$region1, input$region2,input$gender))
  })  
  output$overall <- renderText({
    return(suicide_text(combined_df, input$region1, input$region2,input$gender))
  })
  
  # Daisy's code
  
  # load the data 
  data <- reactive({
    data <- read.csv(paste0("data/", input$year, "_rr.csv"))
    data
  })
  
  output$dotPlot <- renderPlotly({
    p <- ggplot(data(), aes(y = Value, x = Metric, color = Sex)) +
      geom_point() +
      xlab("Relative Risk Factors") +
      ylab("Relative Risk") +
      labs(title = "Relative Risk Analysis For Depressive Order")
    ggplotly(p)
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
          " times higher for ", metric, " than for those who weren't ", metric,"\n\n") 
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
  
  output$rr_analysis <- renderText({
    paste("It is pretty clear that the Limited Activity is the most influential risk factor 
          among these data points through out the years no matter which sex it concerns 
          and it has greatly affected the males way more than the females in terms of 
          the risk of getting depression.", "Generally speaking, among these risk factors, 
          males seem to be affected more than females especially by having no job for 1 to 
          3 years and limited activities. Yet if we look at having multiple cancers in year 
          2014 as a factor, females are affected way more than males. ", 
          "For the most of the times, when we look at college students who have studied for 
          1 to 3 years and divorced people, the relative risk for getting a depression is 
          close across two sexes.  ")
  })
  
  
  ## Mengjiao's Code
  
  ### render the protective factor plot
  output$years_factors_plot <- renderPlotly({
    dataset <- mental_data
    factors <- input$choose_factors
    filter_factors <- append(c("Year", "MENTHLTH"), factors)
    years <- input$choose_year
    
    # filter data based on inputs
    adjusted_dataset <- dataset[, filter_factors] %>%
      dplyr::filter(Year %in% years) %>%
      dplyr::mutate(Year = as.factor(Year), Days = MENTHLTH)
    
    # based on chosen years, output different graph title
    if (length(input$choose_year) == 0) {
      plot_title <- paste0("Year has not been selected")
    } else if (length(input$choose_year) == 1) {
      plot_title <- paste0("Days of Mental Health Not Good for the Past 30 Days by ", changefactor(input$choose_factors), " in ", input$choose_year)
    } else if (length(input$choose_year) > 1) {
      chosen_year <- paste(input$choose_year,collapse=" ")
      plot_title <- paste0("Days of Mental Health Not Good for the Past 30 Days by ", changefactor(input$choose_factors), " in ", chosen_year)
    }
    
    # change numbers to percentage
    Percentage <- adjusted_dataset[, factors]
    
    plot <- ggplot(adjusted_dataset, aes(x=Days, y=Percentage)) + 
      geom_line(aes(col = Year), na.rm = TRUE) + 
      geom_smooth(method="lm", se=F, na.rm = TRUE) +
      labs(title=plot_title,
           x = "Days of Mental Health Not Good for the Past 30 Days (day)",
           y = "Percentage of Risk Factors within the Year (%)",
           caption="source: BRFSS 2011-2015") + 
      theme_dark() + 
      theme(plot.background = element_rect(fill = "grey88")) + 
      ylim(0, 100)
    
    # add hovering data to the plot
    plot<- ggplotly(plot)
      
    return(plot)
  })

  # observe if the uncheckyear is clicked, if clicked, either empty/select all options
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
  
  # render users choice for the years they chose
  output$year_text <- renderText({
    if(length(input$choose_year) != 0) {
      chosen_year <- paste(input$choose_year,collapse=" ")
      output <- paste0("You have chose the following years: ", chosen_year)
    } else {
      output <- "No years are selected"
    }
  })
  
  # render users choice for the protective factor they chose
  output$risk_factor_text <- renderText({
    paste0("You have chosen risk factor: ", changefactor(input$choose_factors))
  })
  
  # render a interpretation for the protective factor for line graph
  output$interpretation_protective <- renderText({
    association <- "lower"
    effect <- "positive"
    if (input$choose_factors == "MEDCOST") {
      association <- "higher"
      effect <- "negative"
    }
    output_text <- paste0("Based on the options selected above, we could see that, overall, patients who reported higher mental health not good days often have a ", association, " percentage/chance for getting ", changefactor(input$choose_factors), ".")
    output_text <- paste0(output_text, " In other words, participants who reported ", effect," conditions of ", changefactor(input$choose_factors), " often experience less mental health conditions.")
    output_text <- paste0(output_text, "This corresponds with our prediction, that the existence of the ", changefactor(input$choose_factors), " is a protective factor of healthy mental health, which could be suggested to the general public.")
  })
  
  # render a interpretation for the protective factors' trends across year graph
  output$interpretation_protective_trends <- renderText({
    if (input$choose_factors == "EXERANY2" | input$choose_factors == "EDUCA") {
      across_year_variation <- " association across year is the most steady, the shapes overlapped the most, suggesting it have not been changed much for the past several years. This is same as our predictions, 
      as more education regarding mental health and regular exercise will help promote better mental and physical health. But the mechanism of how it affect mental health has not changed."
    } else if (input$choose_factors == "EMTSUPRT" | input$choose_factors == "LSATISFY") {
      across_year_variation <- " association across year has a lot of flutuation. This may due to smaller sample sizes comparing to other factors, which we suggest could be further analysis with larger sample data. 
      As mentioned in the side note, the emotional support and life satisfation is only measured in two states (MINNESOTA, RHODE ISLAND), rather than all states. This may greatly impact the accuracy of the association and be biased based on culture preference and personal standards." 
    } else if (input$choose_factors == "HLTHPLN1") {
      across_year_variation <- " association across year is relatively steady, with slightly shift from 2011 to 2015. In general, 2015 has higher percentage of factors reported than 2011, suggesting other confounding factors that impact the change, 
      such as policies that increase healthcare coverage. "
    } else if (input$choose_factors == "MEDCOST") {
      across_year_variation <- " association across year is relatively steady, with slightly shift from 2011 to 2015. In general, 2015 has lower percentage of factors reported than 2011, suggesting other confounding factors that impact the change, 
      such as policies that made healthcare more affordable to the general publics."
    }
    output_text <- paste0("Overall, across all year selected, the trends for ", changefactor(input$choose_factors), " was roughly the same, with some flutuation.")
    output_text <- paste0(output_text, " Comparing to the other factors, ", changefactor(input$choose_factors), "'s ", across_year_variation)
    output_text
  })
  
  # render a chart table for data used for the current graph
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
  #Render the Plot created in function
  output$external_plot <- renderPlotly({
    return(create_plot(external, input$external_factors))
  })
  
  #Render the text created in function
  output$interp <- renderText({
    return(create_text(input$external_factors))
  })
})
