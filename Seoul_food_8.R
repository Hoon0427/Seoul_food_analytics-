head(year_18_food_data_frame)

# install.packages("lubridate")
library(lubridate)

year_18_food_data_frame$기준일 <- ymd(year_18_food_data_frame$기준일)

year_18_food_data_frame <- year_18_food_data_frame %>%  mutate(month = month(year_18_food_data_frame$기준일))

head(year_18_food_data_frame)

str(year_18_food_data_frame)


year_18_food_data_frame$month<-as.factor(year_18_food_data_frame$month)

head(year_18_food_data_frame)
tail(year_18_food_data_frame)


# group by 월, 시군구, 통화량
data_by_month_county <- year_18_food_data_frame %>%
    group_by(month,시군구,업종) %>%
    summarize(call = sum(통화건수)) %>%
    arrange(month) %>%
    arrange(시군구) %>% 
    arrange(업종) %>%
    as.data.frame()

head(data_by_month_county)

library(ggplot2)
ggplot(data_by_month_county, 
       aes(x=시군구, y=call, group = 업종, colour=업종)) + 
    geom_line(size=1.3) +
    theme(axis.text.x = element_text(angle = 30, size=14)) + 
    theme(legend.text = element_text(size = 13, face = "italic")) +
    geom_point(size=2) + 
    scale_x_discrete(limits = data_by_month_county %>% 
                         filter(업종 == "치킨집") %>%
                         arrange(call) %>%
                         select(시군구) %>% 
                         t %>% 
                         as.factor)

normalize <-function(x){
    ((x - min(x))*100/(max(x)-min(x)))
}

str(data_by_month_county)

data_by_month_county<-data_by_month_county %>%
    group_by(시군구, 업종) %>%
    mutate(normalized=normalize(call)) %>%
    arrange(month)%>%
    arrange(시군구) %>%
    arrange(업종) %>%
    as.data.frame()

data_by_month_county

sd_by_county <- aggregate(normalized ~ 시군구 + 업종, data_by_month_county, sd) %>%
    arrange(desc(normalized)) %>%
    arrange(업종)

sd_by_county
