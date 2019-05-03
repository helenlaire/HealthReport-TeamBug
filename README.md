# Project Proposal: What contributes to suicide rate?

by Team Bug

Author: Chuqian Yin, Claire Zhang, Yu Du, Mengjiao Li


## Project Description
### Purpose of Study
Suicide, as a major, preventable mental health problem, has been the leading causes of death among a variety of age groups worldwide [1]. As the suicidal rate kept increasing for the past years, under the social concerns and curiosity, many researchers have looked into the topic of suicide and have identified a wide range of risk factors, such as mental disorder, substance abuse, and family histories [2]. However, their findings consist huge limitations - since the researchers could not study suicide under experimental control due to ethical reasons, they have little to no direct knowledge about how these risk factors exactly contribute and lead to suicide [3]. Moreover, despite the high incidence, the topic of suicide has not been adequately addressed enough both in terms of national awareness and strategy for intervention [1]. In other say, there is still a gap between the general public’s knowledge and prevention strategies that could and should be implemented. **Therefore, by using the data from studies in the US, we would like to bridge the gap between the topic of suicide and the general public by not only making them aware of the common risk factors but also providing them prevention strategies through effective interactive visualizations. In addition, we will also compare national-level data to explore how some external factors, such as GDP, instead of internal factors, may associate or contribute to the suicidal rate.**

### Previous Study
There are many pieces of psychology research that have studied the area, and here are three recent researches. First of all, in 2018, Franklin and his fellow researchers attempt to study the suicide causes by creating suicide scenarios in virtual reality [3]. Participants are given choice based instructions in the laboratory and are exposed to multiple causes of suicide. Through observing factors’ effects on VR suicide rates, the researchers are able to tentatively investigate the cause of suicide, which re suicidal desire, agitation, and prior suicidality as the common factors. Their work brought up a new approach for assessing risk factors and prevention strategies of suicide. Second, the World Health Organization develops an action plan in 2013-2020, providing an overview of the topic aiming to increase public awareness of suicide prevention methods [4]. In 2014, Matsubayashi and her fellow researchers studied the effect of public awareness campaigns on suicide. By comparing suicide counts before and after a city-wide campaign in Japan, they found public awareness of depression promote care-seeking behaviors and was negatively correlate with the suicide rate. Although the underlying mechanism remains unclear, it is clear that the campaign reduces the suicide rate. Their researches brought up the importance of stimulating public awareness, as more frequent distributions associate with decrease number of suicide [5]. Third, Colucci and Lester, in 2013, studied the external systems’ impacts on suicide, especially for culture. They point out that 90% of people in US commit suicide due to mental disorder with a majority of elderly men, versus in China, young women has a higher rate of suicide. In Japan, suicide could mean an act of honor under certain circumstances, while Muslims see suicide an unforgivable act [6]. Therefore, seeing the great demographic differences among cultures, it is important to researchers to see the role of cultural context and use it a part of guiding work on understanding suicide. Based on the previous work and combining data from studies, our group wishes to bring a universal view to the general public on how to avoid risks behaviors and appropriately engage in prevention strategies.

### Dataset Description
We are planning on using multiple datasets to study suicide-related mental health issues.
The first data collect information about countries’ **GDP** and **prevalence of depression** from 1990 and 2017. The data was accessed from [Our World in Data](https://ourworldindata.org/mental-health#depression) (section: Prevalence of depressive disorders). The GDP data was published by the Global Burden of Disease Collaborative Network and was also the Global Burden of Disease Study 2016 (GBD 2016) Results. The prevalence of depression data was initially published by the World Bank. We will use this data to study the relationship between depression and GDP, and answer the question that “Worldwide, how do external factors such as GDP, impact populations’ mental health, transfer to suicide rate? ”.

The second data provides information about suicide rates in countries in the world from 1987 to 2010, including the rates across genders and different age groups. The data was accessed from [Kaggle](https://www.kaggle.com/russellyates88/suicide-rates-overview-1985-to-2016). This compiled data set contains information originally from 4 sources: United Nations Development Program, World Bank, Suicide in the Twenty-First Century and World Health Organization. We will use this data to study mental health problems and the suicide rate in different areas and different age groups, and answer the question “ How do mental health problems contribute to suicide rate?” By using these two data sets, we could explore external factors around suicide to the world level.

The third data we use focus risk behaviors and anxiety in the U.S.A. from 2011 to 2015. We accessed it from [Kaggle](https://www.kaggle.com/cdc/behavioral-risk-factor-surveillance-system#2012.csv). This data is collected by the Behavioral Risk Factor Surveillance System (BRFSS) using survey via telephone and collect data about health-related risk behaviors, chronic health conditions, and use of preventive services. Residents from all 50 states are included and more than 400,000 adults are interviewed, which makes it the largest continuously conducted health survey system in the world. The dataset includes numerous amount of risk factors that we could draw connections with depression and other mental disorders.

### Target Audience
According to the National Center for Health Statistics(NCHS), there are over 45,000 suicide cases in 2016 in the U.S. Due to the increasing numbers of suicide and mental health issue cases in recent years,  it is a huge tragedy when we lost people who choose to end their life in such a sad way, their family members, friends and all closed people around them may be affected by those cases. Therefore, our report is aiming to reveal a better understanding of the cause of suicide to anyone who might be struggling in mental health problem and potential suicide intention, or just anyone who care about mental health of people around them. The best solution to avoid the suicide case is to know what causes it and what we can do to prevent it from happening. We want to use our analysis and report to help those people to know suicide is not an unstoppable decision and you are not only one fighting with it. In conclusion, our target audience is people who are struggling with suicide problem and people around them.

Specifically, if a parent has kids who he would like them to stay healthy, he could come to our website, looking into how and what risk behaviors often lead to mental health problems. Based on the data visualizations on our website, he would be able to draw connections and start to not only avoid those risky behaviors, but also apply prevention strategies to promote his child’s physical health. If he would like to see how the external factors impact the children, he could also look into the culture and GDP to broaden his worldviews.

## Technical Description
### Product Format
The final product will be a Shiny app with interactive data visualizations and exhaustive report to present our findings. Once we finish the data analysis process through data wrangling, cleaning and merging using the dplyr package in R, we will use various data visualization R packages such as the ggplot2, Leaflet, RColorBrewer to explore different aspects of our dataset in an aesthetically pleasing way. Then, we will add the user-friendly and interactive design of scrollers, drop-down menus, and maps, etc. within the Shiny framework which allows our users to interact with the dataset however they want to.

### Data Management Challenge
1. Since our questions are mainly focusing on what factors contribute to the suicide rate across the globe, and especially in the U.S. There are challenges with the scope of the data: some countries might not have as much as data as the other countries simply because there are fewer researchers focusing on such issues while they have starvation and war to worry about. Thus it is challenging to find a data set that actually incorporates every country around the world.

2. Another data collection challenge is that we need to find workable survey data that comparatively have less complex psychological terminologies. Even though we do have a psychology major student on our team, the rest of the team members still need a lot of time just to process the data by doing some research. It’s more efficient to have a data set that contains less professional terms and acronyms but such data sources are much harder to find.  

3. The third data collection challenge we face is that we need data to be transferable, meaning the suicide data that we collect not only need to show us its distribution around a certain area but also can be linked to our depression, risky behaviors, and GDP data sets. The suicide data set needs to provide suicide rate of a certain population shared by our depression, risky behaviors, and GDP data sets so that we can develop the correlation coefficients to measure the relationships. If there is no shared medium in the data sets then we can not establish the relationships within these variables.

4. One of the data management challenges we have to face is that we need to link our different sub-data sources together using data merging to measure the relationship between the variables. Since we can’t find the suicide and depression data simultaneously measured on the same person, we can’t calculate its relative risk or odds ratios. What we can calculate is a suicide to depression ratio in a population and compare that with other metrics such as GDP, and other metrics.

### Skills Needed

We need to learn how to exactly merge different data through whether statistical tools or certain R package that we never used before. We also need to learn how to use Shiny to create not only interactive maps but also link the maps to other components such as a scroller or a click on a part of a graph. We also need to learn how to perform data cleaning as our data set might contain missing values and we need to decide how to include these particular variations within the data. We also need to learn the RColorBrewer package within R to generate visualizations with richer color.

### Anticipated Challenges

One challenge is to finish all the analysis within our time limit. Since we have multiple data sources, it can take a long time just to clean and merge the data and then we also need to figure out how to use the relationship between the suicide rate and depression and relationship between depression and risky behaviors to establish a potential relationship between suicide rate and risky behaviors.

Another challenge is to present our findings within one user interface. Since our analysis is divided by three parts: GDP, depression and risky behaviors and each individual part is a potential metric to the suicide rate, the users might feel the transitions on the visualizations too abrupt. So we need to work on the transitions of the scope of our findings: from global to national, from GDP to depression and to risky behaviors.


## Project Set-up
We have created the [public repository](https://github.com/helenlaire/HealthReport-TeamBug) on Github. We have also created 9 issues and assigned them to our group members; however, we might update or add more issues as the our role become more clear later in the quarter

We have also created a group chat for communication.

## Reference
Reference
[1] Franklin, J., Huang, X., & Bastidas, D. (2018). Virtual reality suicide: Development of a translational approach for studying suicide causes. Behaviour Research and Therapy, Behaviour Research and Therapy, 12/2018.
https://alliance-primo.hosted.exlibrisgroup.com/primo-explore/fulldisplay?docid=TN_crossref10.1016/j.brat.2018.12.013&context=PC&vid=UW&search_scope=all&tab=default_tab&lang=en_US

[2] Cazarian, S. (2017). Suicide Awareness. The American Journal of Nursing, 117(2), 11.
https://alliance-primo.hosted.exlibrisgroup.com/primo-explore/fulldisplay?docid=TN_scopus2-s2.0-85030620929&context=PC&vid=UW&search_scope=all&tab=default_tab&lang=en_US

[3] United States. Congress. Senate. Committee on Appropriations. Subcommittee on Departments of Labor, Health Human Services, Education, Related Agencies. (2001). Suicide awareness and prevention : Hearing before a subcommittee of the Committee on Appropriations, United States Senate, One Hundred Sixth Congress, second session, special hearing, February 8, 2000, Washington, DC. (United States. Congress. Senate. S. hrg. ; 106-940). Washington: U.S. G.P.O. : For sale by the U.S. G.P.O., Supt. of Docs., Congressional Sales Office.
https://alliance-primo.hosted.exlibrisgroup.com/primo-explore/fulldisplay?docid=CP71173955390001451&context=L&vid=UW&search_scope=all&tab=default_tab&lang=en_US

[4] Wasserman, D. (2016). Suicide : An unnecessary death (Second ed.). Oxford: Oxford University Press.
https://alliance-primo.hosted.exlibrisgroup.com/primo-explore/fulldisplay?docid=CP71246214310001451&context=L&vid=UW&search_scope=all&tab=default_tab&lang=en_US

[5] Matsubayashi, Ueda, & Sawada. (2014). The effect of public awareness campaigns on suicides: Evidence from Nagoya, Japan. Journal of Affective Disorders, 152-154(1), 526-529.
https://alliance-primo.hosted.exlibrisgroup.com/primo-explore/fulldisplay?docid=TN_sciversesciencedirect_elsevierS0165-0327(13)00681-2&context=PC&vid=UW&search_scope=all&tab=default_tab&lang=en_US

[6] Bell, C. (2014). Suicide and Culture: Understanding the Context. Journal Of Clinical Psychiatry, 75(6), E594.
https://alliance-primo.hosted.exlibrisgroup.com/primo-explore/fulldisplay?docid=TN_wos000338458200008&context=PC&vid=UW&search_scope=all&tab=default_tab&lang=en_US
