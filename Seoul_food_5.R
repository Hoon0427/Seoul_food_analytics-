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

group_by_data<-Call_food_01 %>% group_by(date,wday,type) %>% summarize(call = sum(call)) %>% as.data.frame()

head(group_by_data)

for(i in 1:3){
  group_by_data_food <- group_by_data %>% filter(type==food_list[i])
}


ggplot(group_by_data, aes(x=date, y=call, group = type, colour=type)) + 
  geom_line(size=1) + 
  geom_point(size=2)

# 구, 별 data 그룹화
data_by_county <- Call_food_01 %>%
  group_by(county,type) %>%
  summarize(call = sum(call)) %>%
  arrange(call) %>%
  as.data.frame()

ggplot(data_by_county, 
       aes(x=county, y=call, group = type, colour=type)) +  
  geom_line(size=1.3) +
  theme(axis.text.x = element_text(angle = 30, size=14)) + 
  theme(legend.text = element_text(size = 13, face = "italic")) +
  geom_point(size=2)

ggplot(data_by_county, 
       aes(x=county, y=call, group = type, colour=type)) + 
  geom_line(size=1.3) +
  theme(axis.text.x = element_text(angle = 30, size=14)) + 
  theme(legend.text = element_text(size = 13, face = "italic")) +
  geom_point(size=2) + 
  scale_x_discrete(limits = data_by_county %>% 
                     filter(type == "chicken") %>%
                     arrange(call) %>%
                     select(county) %>% 
                     t %>% 
                     as.factor)

ggplot(data_by_county, 
       aes(x=county, y=call, group = type, colour=type)) + 
  geom_line(size=1.3) +
  theme(axis.text.x = element_text(angle = 30, size=14)) + 
  theme(legend.text = element_text(size = 13, face = "italic")) +
  geom_point(size=2) + 
  scale_x_discrete(limits = data_by_county %>% 
                     filter(type == "cfood") %>%
                     arrange(call) %>%
                     select(county) %>% 
                     t %>% 
                     as.factor)
