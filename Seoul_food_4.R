Call_pizza_01 <- read.csv("CALL_PIZZA_01MONTH.csv")

str(Call_pizza_01)

# 컬럼 명 영어로 변경
colnames(Call_pizza_01) <- c("date", "wday", "gender", "age", "city", "county", "town", "call")

# type 피자가 없어 새로 추가
type <- rep("피자",nrow(Call_pizza_01))

# type를 그대로 재조합 해서 컬럼에 추가
Call_pizza_01 <- cbind(Call_pizza_01[,1:7],type, call = Call_pizza_01[,8])

# 날짜 데이터 형 변환
Call_pizza_01$date <- as.character(Call_pizza_01$date)
Call_pizza_01$date <- as.POSIXct(Call_pizza_01$date, format = "%Y%m%d")

# 요일 데이터 순서 조정
Call_pizza_01$wday <- factor(Call_pizza_01$wday,
                             levels = c("월", "화", "수","목","금","토","일"))

# Na값 확인
sum(is.na(Call_pizza_01))

# 연령, 요일 별 Data 그룹화
data_by_years_days <- Call_pizza_01 %>%
  group_by(age,wday) %>%
  summarize(call = sum(call)) %>% as.data.frame()

# 구, 별 data 그룹화
data_by_county <- Call_pizza_01 %>%
  group_by(county) %>%
  summarize(call = sum(call)) %>% as.data.frame()
data_by_years_days %>% arrange(call)
data_by_county %>% arrange(call)

data_by_years_days %>% arrange(call)
data_by_county %>% arrange(call)