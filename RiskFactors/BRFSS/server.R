library(shiny)
library(dplyr)
library(ggplot2)
shinyServer(function(input, output) {
  
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
    cat("College: college students who have been studying for 1 to 3 years", 
    "Divorce: people who are divorced", 
    "Limited Activities: people who have limited activities due to health problems",
    "Multiple Cancer: people who have three or more cancers",
    "No Job: people who are out of work for 1 year or more", 
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
})
