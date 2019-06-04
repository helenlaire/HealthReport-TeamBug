library(dplyr)
library(ggplot2)
library(tidyr)

# Load data and explore the data from the first 2 rows of the data
data <- read.csv("data/2011.csv")
d <- head(data, 2)

# Select only relevant columns
mental <- data %>% select(ADDEPEV2, MARITAL, EDUCA, EMPLOY,
                          CNCRDIFF, QLACTLM2, SEX) 
# Filtered out invalid data
mental <- mental %>% 
          filter(MARITAL != 9 & EDUCA != 9) %>% 
          filter(EMPLOY != 9) %>% 
          filter(ADDEPEV2 != 7 & ADDEPEV2 != 9) %>%
          filter(CNCRDIFF != 7 & CNCRDIFF != 9) %>%
          filter(QLACTLM2 != 7 & QLACTLM2 != 9) %>%
          filter(SEX != 9)

# Set the numeric data as textual to make it more intuitive 
mental$ADDEPEV2[mental$ADDEPEV2 == 1] <- "Yes"
mental$ADDEPEV2[mental$ADDEPEV2 == 2] <- "No"

# Prepare the data for relative risk analysis: set the exposure to risk factor as yes,
# otherwise set as no.

# Education 
mental$EDUCA[mental$EDUCA == 5] <- "Yes"
mental$EDUCA[mental$EDUCA != "Yes"] <- "No"
# Marital Status
mental$MARITAL[mental$MARITAL == 2] <- "Yes"
mental$MARITAL[mental$MARITAL != "Yes"] <- "No"
# Employment 
mental$EMPLOY[mental$EMPLOY == 3] <- "Yes"
mental$EMPLOY[mental$EMPLOY != "Yes"] <- "No"
# Cancer
mental$CNCRDIFF[mental$CNCRDIFF == 3] <- "Yes"
mental$CNCRDIFF[mental$CNCRDIFF != "Yes"] <- "No"
# Limited Activity
mental$QLACTLM2[mental$QLACTLM2 == 1] <- "Yes"
mental$QLACTLM2[mental$QLACTLM2 != "Yes"] <- "No"

mental_male <- mental %>% filter(SEX == 1)
mental_female <- mental %>% filter(SEX == 2)

# Function that calculates Relative Risk with given metric such as divorce or not
# and returns a double value which is the calculated relative risk
give_rr <- function(mental, metric){
  mental <- mental %>% select(ADDEPEV2, (!!as.name(metric)))
  metric_depre <- mental %>% filter((!!as.name(metric)) == 'Yes' 
                                     & ADDEPEV2 == 'Yes') %>% 
                             nrow()
  
  metric_nodepre <- mental %>% filter((!!as.name(metric)) == 'Yes' 
                                      & ADDEPEV2 == 'No') %>% 
                               nrow()
  
  nometric_depre <- mental %>% filter((!!as.name(metric)) == 'No' 
                                      & ADDEPEV2 == 'Yes') %>% 
                               nrow()
  
  nometric_nodepre <- mental %>% filter((!!as.name(metric)) == 'No' 
                                 & ADDEPEV2 == 'No') %>% 
                          nrow()
  return ((metric_depre / (metric_depre + metric_nodepre)) /
    (nometric_depre / (nometric_depre + nometric_nodepre)))
}

# Create a data point for the relative risk which will be put inside a dataframe later
edu <- give_rr(mental_male, "EDUCA") # College 1 year to 3 years 
divorced <- give_rr(mental_male, "MARITAL") # Divorce vs Not Divorce
no_job <- give_rr(mental_male, "EMPLOY") # Out of work for 1 year or more
mul_cancer <- give_rr(mental_male, "CNCRDIFF") # Three or more cancers
limited <- give_rr(mental_male, "QLACTLM2") # Limited activities

# Join the calculated relative risk for males together in one data frame
male <- data.frame("College" = edu, "Divorce" = divorced, 
                   "No_Job" = no_job, "Multiple_Cancer" = mul_cancer, 
                   "Limited_Activities" = limited)

# Create a data point for the relative risk which will be put inside a dataframe later
edu_fe <- give_rr(mental_female, "EDUCA") # College 1 year to 3 years 
divorced_fe <- give_rr(mental_female, "MARITAL") # Divorce vs Not Divorce
no_job_fe <- give_rr(mental_female, "EMPLOY") # Out of work for 1 year or more
mul_cancer_fe <- give_rr(mental_female, "CNCRDIFF") # Three or more cancers
limited_fe <- give_rr(mental_female, "QLACTLM2") # Limited activities

# Join the calculated relative risk for females together in one data frame
female <- data.frame("College" = edu_fe, "Divorce" = divorced_fe, 
                   "No_Job" = no_job_fe, "Multiple_Cancer" = mul_cancer_fe, 
                   "Limited_Activities" = limited_fe)

# reshape the data for graphing purposes
male <- male %>% gather("Metric", Value) %>%
                 mutate("Sex" = "Male")

# reshape the data for graphing purposes
female <- female %>% gather("Metric", Value) %>%
  mutate("Sex" = "Female")

# join all the data in one dataframe
data <- full_join(male, female)

# save the dataframe as a csv file
write.csv(data, file = "data/2011_rr.csv")

# draw the graphs the relative risks in this year just to double check if the 
# data looks normal
ggplot(data, aes(y = Value, x = Metric, color = Sex)) +
  geom_point() +
  xlab("Relative Risk Factors") +
  ylab("Relative Risk") +
  labs(title = "Relative Risk Analysis For Depressive Order")

# generate the text block which explains the relative risk in the dataframe of this year





