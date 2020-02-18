library(dplyr)

library(ggplot2)

Call_chicken_01<-read.csv("CALL_CHICKEN_01MONTH.csv")
Call_cfood_01<-read.csv("CALL_CFOOD_01MONTH.csv")
Call_pizza_01<-read.csv("CALL_PIZZA_01MONTH.csv")

# type 피자가 없어 새로 추가 
type <- rep("피자" , nrow(Call_pizza_01))

Call_pizza_01 <- cbind(Call_pizza_01[,1:7],type,Call_pizza_01[,8])

# 컬럼 명 영어로 변경 
colnames(Call_chicken_01) <- c("date", "wday", "gender", "age", "city", "county", "town", "type", "call")
colnames(Call_cfood_01) <- c("date", "wday", "gender", "age", "city", "county", "town", "type", "call")
colnames(Call_pizza_01) <- c("date", "wday", "gender", "age", "city", "county", "town", "type", "call")

#Call_food_01로 모두 합침
Call_food_01 <- c()
Call_food_01 <- rbind(Call_food_01,Call_chicken_01)
Call_food_01 <- rbind(Call_food_01,Call_cfood_01)
Call_food_01 <- rbind(Call_food_01,Call_pizza_01)

# 날짜 데이터 형 변환
Call_food_01$date <- as.character(Call_food_01$date)
Call_food_01$date <- as.Date(Call_food_01$date, format = "%Y%m%d")

# 요일 데이터 순서 조정
Call_food_01$wday <- factor(Call_food_01$wday,
                            levels = c("월","화","수","목","금","토","일"))

# food_list를 사용하여 type를 영어로 변경
food_list <- c("chicken", "cfood","pizza")
levels(Call_food_01$type) <- food_list

# Na값 확인
sum(is.na(Call_food_01))

group_by_data<-Call_food_01 %>% group_by(data.wday.type) %>% summarize(call = sum(call)) %>% as.data.frame()

head(group_by_data)
