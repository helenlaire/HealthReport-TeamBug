library(dplyr)
library(ggplot2)

data <- read.csv("2011.csv")
d <- head(data, 2)

mental <- data %>% select(ADDEPEV2, ADDOWN, ADSLEEP, ADFAIL) %>% 
          filter(ADDOWN != "NA")

mental <- mental %>% 
          filter(ADDOWN != 77 & ADDOWN != 99) %>% 
          filter(ADSLEEP != 77 & ADSLEEP != 99) %>% 
          filter(ADFAIL != 77 & ADFAIL != 99) %>% 
          filter(ADDEPEV2 != 7 & ADDEPEV2 != 9) 

mental$ADDOWN[mental$ADDOWN == 88] <- 0
mental$ADSLEEP[mental$ADSLEEP == 88] <- 0
mental$ADFAIL[mental$ADFAIL == 88] <- 0
mental$ADDEPEV2[mental$ADDEPEV2 == 1] <- "Yes"
mental$ADDEPEV2[mental$ADDEPEV2 == 2] <- "No"

ggplot(mental, aes(ADDOWN, fill = ADDEPEV2)) +
  geom_bar() +
  xlab("Days felt down, depressed or hopeless over the last 2 weeks") +
  ylab("Frequency") +
  labs(title = "Distribution of Days felt down, depressed or hopeless in year 2011", 
       fill = "Depressive Disorder")

ggsave("DD.png")


ggplot(mental, aes(ADSLEEP, fill = ADDEPEV2)) +
  geom_bar() +
  xlab("Days had trouble with sleep over the last 2 weeks ") +
  ylab("Frequency") +
  labs(title = "Distribution of Days had trouble with sleep over the last 2 weeks in year 2011", 
       fill = "Depressive Disorder")

ggsave("DS.png")
