group_by_data[group_by_data$type=="chicken",]

head(group_by_data)


group_by_data %>% 
   group_by(wday) %>% 
   filter(type == "chicken") %>% 
   filter(date != "2019-01-07") %>%
   filter(date != "2019-01-16") %>%
   filter(date != "2019-01-22") %>%
   filter(date != "2019-01-25") %>%
   summarize(call = mean(call)) %>% 
   as.data.frame()

group_by_data %>% 
   group_by(wday) %>% 
   filter(type == "pizza") %>% 
   filter(date != "2019-01-01") %>%
   # filter(date != "2019-01-16") %>%
   # filter(date != "2019-01-22") %>%
   # filter(date != "2019-01-25") %>%
   summarize(call = mean(call)) %>% 
   as.data.frame()

group_by_data %>% 
   filter(type == "pizza") %>% 
   filter(date == "2019-01-01")
