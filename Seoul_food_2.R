summary(Call_chicken_01)

str(Call_chicken_01)

Call_chicken_01$기준일 <- as.character(Call_chicken_01$기준일)
Call_chicken_01$기준일 <- as.POSIXct(Call_chicken_01$기준일, format = "%Y%m%d")
Call_chicken_01$요일 <- factor(Call_chicken_01$요일,
                             levels = c("월", "화", "수","목","금","토","일"))

str(Call_chicken_01)

Call_chicken_01_10years <- Call_chicken_01[Call_chicken_01$연령대 == "10대",]
Call_chicken_01_20years <- Call_chicken_01[Call_chicken_01$연령대 == "20대",]
Call_chicken_01_30years <- Call_chicken_01[Call_chicken_01$연령대 == "30대",]
Call_chicken_01_40years <- Call_chicken_01[Call_chicken_01$연령대== "40대",]
Call_chicken_01_50years <- Call_chicken_01[Call_chicken_01$연령대 == "50대",]
Call_chicken_01_60years <- Call_chicken_01[Call_chicken_01$연령대 == "60대이상",]
Call_chicken_01_Mon <- Call_chicken_01[Call_chicken_01$요일 == "월",]
Call_chicken_01_Tue <- Call_chicken_01[Call_chicken_01$요일 == "화",]
Call_chicken_01_Wed <- Call_chicken_01[Call_chicken_01$요일 == "수",]
Call_chicken_01_Thu <- Call_chicken_01[Call_chicken_01$요일 == "목",]
Call_chicken_01_Fri <- Call_chicken_01[Call_chicken_01$요일 == "금",]
Call_chicken_01_Sat <- Call_chicken_01[Call_chicken_01$요일 == "토",]
Call_chicken_01_Sun <- Call_chicken_01[Call_chicken_01$요일 == "일",]

aggregate(Call_chicken_01$통화건수, 
          by=list(Call_chicken_01$연령대), FUN=sum)
aggregate(Call_chicken_01$통화건수, 
          by=list(Call_chicken_01$요일), FUN=sum)


library(dplyr)

data_by_days <- Call_chicken_01 %>%
  group_by(요일) %>%
  summarize(통화건수 = sum(통화건수)) %>% as.data.frame()

data_by_days

data_by_day_years <- Call_chicken_01 %>%
  group_by(요일,연령대) %>%
  summarize(통화건수 = sum(통화건수)) %>% as.data.frame()

data_by_day_years


data_by_years_days <- Call_chicken_01 %>%
  group_by(연령대,요일) %>%
  summarize(통화건수 = sum(통화건수)) %>% as.data.frame()

data_by_day_years

data_by_years_days %>% arrange(통화건수)
