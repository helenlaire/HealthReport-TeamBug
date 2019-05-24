library(dplyr)
library(ggplot2)
library(survey)
library(tidyr)
# Protective Factors
# Connectedness
# Availability of physical and mental health care
# Coping ability


# data_2015 <- read.csv("Prevention-Mengjiao/data/2015.csv", stringsAsFactors = FALSE)

# data <- data_2015 %>%
#   select(
#     SEQNO,
#     X_STSTR,
#     X_LLCPWT,
#     
#     MENTHLTH, # number of days mental health not good
#     # HLTHPLN1 # have any health care coverage
#     # exerany2, # exercise in Past 30 Days
#     MEDCOST # could Not See Doctor Because of Cost
#     # lsatisfy, # Satisfaction with life
#     # adanxev # ever told anxiety
#   )

# write.csv(data, file = "Prevention-Mengjiao/data/chart1.csv")

data <- read.csv("Prevention-Mengjiao/data/chart1.csv", stringsAsFactors = FALSE)

## attributable risk for healthcare in mental health
risk_healthcare <- data %>% 
  mutate(
    MENTHLTH=replace(MENTHLTH, MENTHLTH == 77 | MENTHLTH == 99, NA),
    MENTHLTH=replace(MENTHLTH, MENTHLTH == 88, 0)
  ) %>%
  mutate(
    MEDCOST=replace(MEDCOST, MEDCOST == 7 | MEDCOST == 9, NA),
    MEDCOST=replace(MEDCOST, MEDCOST == 2, "NO"),
    MEDCOST=replace(MEDCOST, MEDCOST == 1, "YES")
  ) %>%
  group_by(MEDCOST, MENTHLTH) %>%
  summarise(num = n()) %>%
  filter(!is.na(MEDCOST), !is.na(MENTHLTH))


mental_healthcare_graph <- ggplot(data=risk_healthcare, aes(x=MENTHLTH, y=num)) +
  geom_line(aes(col=MEDCOST)) +
  theme_minimal() +
  scale_fill_brewer(palette="Blues") +
  labs(title="Number of Days Mental Health Not Good vs. HealthCare Cost",
       x="Number of Days Mental Health Not Good",
       y="Number of People")

ggsave("Prevention-Mengjiao/chart/age_sex.png", width = 10, height = 10, dpi = 300, units = c("in", "cm", "mm"))
