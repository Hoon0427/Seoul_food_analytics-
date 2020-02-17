Call_cfood_01 <- read.csv("CALL_CFOOD_01MONTH.csv")

colnames(Call_cfood_01) <- c("date", "wday", "gender", "age", "city", "county", "town", "type", "call")
Call_cfood_01$date <- as.character(Call_cfood_01$date)
Call_cfood_01$date <- as.POSIXct(Call_cfood_01$date, format = "%Y%m%d")
Call_cfood_01$wday <- factor(Call_cfood_01$wday,
                             levels = c("월", "화", "수","목","금","토","일"))

sum(is.na(Call_cfood_01))


data_by_years_days <- Call_cfood_01 %>%
  group_by(age,wday) %>%
  summarize(call = sum(call)) %>% as.data.frame()

data_by_years_days %>% arrange(call)
