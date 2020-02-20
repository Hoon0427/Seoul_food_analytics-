getwd()
library(dplyr)
# food_list 생성
food_list <- c("CFOOD","CHICKEN","PIZZA")

# 경로 설정
dir <- ("C:/MyRCode/Seoul_food_analytics-/year_18")
setwd(dir)

# 경로 내 파일리스트 생성
file_list <- list.files(dir)
for(j in food_list) {
  # grep 함수를 사용하여 CFOOD, CHICKEN, PIZZA 가 포함된 index를 찾는다.
  food_list_index <- grep(j,file_list)
  df_name <- data.frame()
  for(i in food_list_index) {
    read_data_csv <- read.csv(file_list[i])
    df_name <- rbind(df_name, read_data_csv)
  }
  #데이터를 불러와서 각 변수 생성
  assign(paste0(j,"_18"), df_name)
}
# _18로 끝나는 변수들을 List로 묶어준다.
dataframe_list <- mget(ls(pattern= "18"))

# 패키지 load
# install.packages(c("tidyverse", "fs"))
library(tidyverse)
library(fs)
# 폴더명 생성
year_18_food <- "year_18"
# 폴더에 있는 csv 파일 확인
year_18_food_csv <- fs::dir_ls(year_18_food)
# 첫번째 csv 파일 불러오기
readr::read_csv(year_18_food_csv[1])
# 모든 csv 파일 불러오기
year_18_food_data <- year_18_food_csv %>% 
  map_dfr(read_csv)
# 이를 data.frame으로 변경
year_18_food_data_frame <- as.data.frame(year_18_food_data)
# na 파악하기
sum(is.na(year_18_food_data_frame))
# 컬럼명이 뭔가 다른것이 있음
# 시도, 시군구, 읍면동, 기준일 = 발신지_시도, 발신지_구, 발신지_동, 일자
str(year_18_food_data_frame)
# 먼저 확인해 보고 싶은것이, 이 데이터들이 한쪽에 없으면 다른 한쪽에 무조건 있는가?
# 시도 데이터의 na index와, 발신지_시도의 na가 아닌 곳의 index를 확인해보기
sum(
  which(is.na(year_18_food_data_frame$시도)) != which(!is.na(year_18_food_data_frame$발신지_시도)))
# 시군구 데이터의 na index와, 발신지_구의 na가 아닌 곳의 index를 확인해보기
sum(
  which(is.na(year_18_food_data_frame$시군구)) != which(!is.na(year_18_food_data_frame$발신지_구)))
# 읍면동 데이터의 na index와, 발신지_동의 na가 아닌 곳의 index를 확인해보기
sum(
  which(is.na(year_18_food_data_frame$읍면동)) != which(!is.na(year_18_food_data_frame$발신지_동)))
# 0이 나온것으로 보아 다행히 모두 서로 다른곳에 na가 위치해 있습니다
# 이제 시도,시군구,읍면동의 na위치에 발신지_시도,발신지_구, 발신지_동의 data를 집어 넣어줍니다
year_18_food_data_frame$시도[which(is.na(year_18_food_data_frame$시도))] <- year_18_food_data_frame$발신지_시도[which(!is.na(year_18_food_data_frame$발신지_시도))]
year_18_food_data_frame$시군구[which(is.na(year_18_food_data_frame$시군구))] <-  year_18_food_data_frame$발신지_구[which(!is.na(year_18_food_data_frame$발신지_구))]
year_18_food_data_frame$읍면동[which(is.na(year_18_food_data_frame$읍면동))] <-  year_18_food_data_frame$발신지_동[which(!is.na(year_18_food_data_frame$발신지_동))]
# 그리고나서 na를 살펴보기
sum(is.na(year_18_food_data_frame$시도))
sum(is.na(year_18_food_data_frame$시군구))
sum(is.na(year_18_food_data_frame$읍면동))
# 기준일, 일자도 같은 방법으로 진행 한다.
# 기준일
sum(
  which(is.na(year_18_food_data_frame$기준일)) != which(!is.na(year_18_food_data_frame$일자)))
year_18_food_data_frame$기준일[which(is.na(year_18_food_data_frame$기준일))] <- 
  year_18_food_data_frame$일자[which(!is.na(year_18_food_data_frame$일자))]
sum(is.na(year_18_food_data_frame$기준일))
# 연령대
sum(
  which(is.na(year_18_food_data_frame$연령대)) != which(!is.na(year_18_food_data_frame$연령)))
year_18_food_data_frame$연령대[which(is.na(year_18_food_data_frame$연령대))] <- 
  year_18_food_data_frame$연령[which(!is.na(year_18_food_data_frame$연령))]
sum(is.na(year_18_food_data_frame$연령대))
str(year_18_food_data_frame)
# 이제 필요 없는, 발신지_시도, 발신지_구, 발신지_동, 일자, 연령은 제거 하자.
year_18_food_data_frame <- year_18_food_data_frame[,1:9]
for(i in 1:9) {
  print(sum(is.na(year_18_food_data_frame[,i])))
}
# 과거에 피자는 업종에 데이터가 없어서 NA로 표시가 되어 있다.
year_18_food_data_frame$업종[which(is.na(year_18_food_data_frame$업종))] <- "피자집"
# 최종 NA 확인
sum(is.na(year_18_food_data_frame))