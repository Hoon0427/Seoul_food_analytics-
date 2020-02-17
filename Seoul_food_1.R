Call_chicken_01 <- read.csv("CALL_CHICKEN_01MONTH.csv")

dim(Call_chicken_01)

summary(Call_chicken_01)

library(dplyr)
str(Call_chicken_01)


years30<-Call_chicken_01 %>% filter(class=="30대")
years40<-Call_chicken_01 %>% filter(class=="40대")

years3040<-(years30&years40)

head(years3040)

sum(fri30$통화건수)

sum(fri40$통화건수)

head(years3040[years3040$연령대 == "30대",])
