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
