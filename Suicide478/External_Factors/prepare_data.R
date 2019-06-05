suicide <- read.csv('data/suicide.csv')
health_spend <- read.csv('data/health_spending.csv')
unemployment <- read.csv('data/unemployment.csv')
suicide_rate <- suicide %>% select(country, year, suicides.100k.pop, gdp_per_capita....) %>% 
  group_by(country, year) %>% summarise(suicide_rate = sum(suicides.100k.pop, na.rm = TRUE)) %>% 
  group_by(country) %>% summarise(suicide_rate = mean(suicide_rate))
health_spend <- health_spend %>% gather(year, value, -1) %>% group_by(X) %>% 
  summarise(health_spend = mean(value, na.rm = T)) %>% filter(health_spend != "NaN")
colnames(health_spend) <- c('country', 'health_spend')
all_data <- join(suicide_rate, health_spend, type = 'left', by = 'country')
unemployment <- unemployment %>% select(-Country.Code) %>% gather(year, unemployment, -1) %>% 
  group_by(Country.Name) %>% summarise(unemployment = mean(unemployment, na.rm = T))
colnames(unemployment) <- c('country', 'unemployment')
all_data <- join(all_data, unemployment, type = 'left', by = 'country')
gdp <- suicide %>% select(country, gdp_per_capita...., year) %>% distinct() %>% group_by(country) %>% 
  summarise(gdp = round(mean(gdp_per_capita...., na.rm = T), 0))
all_data <- join(all_data, gdp, type = 'left', by = 'country') %>% drop_na()
write.csv(all_data, file = 'data/prepare_data.csv')

