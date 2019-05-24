library(dplyr)
library(ggplot2)
library(tidyr)
suicide_data <- read.csv(file = 'data/suicide.csv')
suicide_data <- subset(suicide_data, select = -HDI.for.year)
suicide_data$suicides.100k.pop[suicide_data$suicides.100k.pop == 0] <- NA
suicide_data$gdp_per_capita....[suicide_data$gdp_per_capita.... == 0] <- NA
suicide_data <- na.omit(suicide_data)
suicide_gdp <- suicide_data %>%  group_by(country) %>% 
  summarise(suicide_number = sum(suicides.100k.pop), gdp = sum(gdp_per_capita....))
ggplot(suicide_gdp, aes(x=gdp, y=suicide_number)) + 
  geom_point()+
  scale_x_continuous(labels = scales::comma)+
  labs(title = 'Ralationship between suicide rates and gdp in 100 countries from 1987 to 2016', x = 'GDP',
       y = 'Suicide Rates')+
  geom_smooth()
ggsave(filename = 'GdpVSsuicide.png', path = 'chart/', width = 12)