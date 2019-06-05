library(dplyr)
library(ggplot2)
library(survey)
library(tidyr)
library(tidyverse)


# Protective Factors
# Protective Factors for Depression (https://youth.gov/youth-topics/youth-mental-health/risk-and-protective-factors-youth)
  # Availability of physical and mental health care
  # Positive physical development
  # Academic achievement/intellectual development
  # Emotional self-regulation
  # Engagement and connections in two or more of the following contexts: school, with peers, in athletics, employment, religion, culture

mental_data <- read.csv("Prevention-Mengjiao/data/mental_data.csv", stringsAsFactors = FALSE)
depression_data <- read.csv("Prevention-Mengjiao/data/depression_data.csv", stringsAsFactors = FALSE)

mental_data <- mental_data %>%
  mutate(
    HLTHPLN1 = HLTHPLN1*100,
    MEDCOST = MEDCOST*100,
    EXERANY2 = EXERANY2*100,
    EMTSUPRT = EMTSUPRT*100,
    LSATISFY = LSATISFY*100,
    EDUCA = EDUCA*100
  )

changefactor <- function(factor) {
  if(factor == "HLTHPLN1") {
    chosen_factors <- "Health Care Coverage"
  } else if (factor == "MEDCOST") {
    chosen_factors <- "Affordability of Medical Cost"
  } else if (factor == "EXERANY2") {
    chosen_factors <- "Exercises"
  } else if (factor == "EMTSUPRT") {
    chosen_factors <- "Frequency of getting emotional support"
  } else if (factor == "LSATISFY") {
    chosen_factors <- "Degree of Life Satisfaction"
  } else if (factor == "EDUCA") {
    chosen_factors <- "Education Level"
  }
  chosen_factors
}


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

dataset <- mental_data
factors <- c("HLTHPLN1")
years <- c(2011, 2012, 2013)
filter_factors <- append(c("Year", "MENTHLTH"), factors)

adjusted_dataset <- dataset[, filter_factors] %>%
  filter(Year %in% years)

factor_col <- adjusted_dataset[, factors]

ggplot(adjusted_dataset, aes(x=MENTHLTH, y=factor_col)) + 
  geom_line(aes(col = as.factor(Year))) + 
  labs(title="Ordered Bar Chart", 
       subtitle="Make Vs Avg. Mileage", 
       caption="source: BRFSS ") + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6)) + theme_minimal()

# mental_healthcare_graph <- ggplot(data=risk_healthcare, aes(x=MENTHLTH, y=num)) +
#   geom_line(aes(col=MEDCOST)) +
#   theme_minimal() +
#   scale_fill_brewer(palette="Blues") +
#   labs(title="Number of Days Mental Health Not Good vs. HealthCare Cost",
#        x="Number of Days Mental Health Not Good",
#        y="Number of People")
# 
# ggsave("Prevention-Mengjiao/chart/age_sex.png", width = 10, height = 10, dpi = 300, units = c("in", "cm", "mm"))

# mental_healthcare_graph <- ggplot(data=risk_healthcare, aes(x=MENTHLTH, y=num)) +
#   geom_point(aes(col=MEDCOST)) +
#   theme_minimal() +
#   scale_fill_brewer(palette="Blues") +
#   labs(title="Number of Days Mental Health Not Good vs. HealthCare Cost",
#        x="Number of Days Mental Health Not Good",
#        y="Number of People")
# 
# ggsave("Prevention-Mengjiao/chart/age_sex.png", width = 10, height = 10, dpi = 300, units = c("in", "cm", "mm"))

