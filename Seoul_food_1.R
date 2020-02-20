Call_chicken_01 <- read.csv("CALL_CHICKEN_01MONTH.csv")

dim(Call_chicken_01)

summary(Call_chicken_01)

library(dplyr)
str(Call_chicken_01)

years3040<-Call_chicken_01 %>% filter(연령대=="30대"|연령대=="40대")

head(years3040)

fri30<-Call_chicken_01 %>% filter(연령대=="30대"&요일=="금")
fri40<-Call_chicken_01 %>% filter(연령대=="40대"&요일=="금")

sum(fri30$통화건수)

sum(fri40$통화건수)

head(years3040[years3040$연령대 == "30대",])
