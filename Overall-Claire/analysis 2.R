library(dplyr)
library(ggplot2)
library(tidyr)

data <- read.csv("data/master.csv")
USA_DF <- data %>% filter(country == "United States")
summary_sa <- USA_DF %>% group_by(year) %>% summarise(suicide_total = sum(suicides_no),population_total = sum(population))

summary_sa <- summary_sa %>% mutate(percentage = suicide_total/population_total*100)




p1 <- ggplot(summary_sa,aes(x= year, y = percentage))+
  geom_point()+
  geom_line()+
  labs(
    
    title = "Suicide Rates Cross Years"
  )

ggsave(file = "suicide_cross_year.pdf", path = "chart/")
