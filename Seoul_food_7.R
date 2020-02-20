getwd()
library(dplyr)
# food_list ����
food_list <- c("CFOOD","CHICKEN","PIZZA")

# ��� ����
dir <- ("C:/MyRCode/Seoul_food_analytics-/year_18")
setwd(dir)

# ��� �� ���ϸ���Ʈ ����
file_list <- list.files(dir)
for(j in food_list) {
  # grep �Լ��� ����Ͽ� CFOOD, CHICKEN, PIZZA �� ���Ե� index�� ã�´�.
  food_list_index <- grep(j,file_list)
  df_name <- data.frame()
  for(i in food_list_index) {
    read_data_csv <- read.csv(file_list[i])
    df_name <- rbind(df_name, read_data_csv)
  }
  #�����͸� �ҷ��ͼ� �� ���� ����
  assign(paste0(j,"_18"), df_name)
}
# _18�� ������ �������� List�� �����ش�.
dataframe_list <- mget(ls(pattern= "18"))

# ��Ű�� load
# install.packages(c("tidyverse", "fs"))
library(tidyverse)
library(fs)
# ������ ����
year_18_food <- "year_18"
# ������ �ִ� csv ���� Ȯ��
year_18_food_csv <- fs::dir_ls(year_18_food)
# ù��° csv ���� �ҷ�����
readr::read_csv(year_18_food_csv[1])
# ��� csv ���� �ҷ�����
year_18_food_data <- year_18_food_csv %>% 
  map_dfr(read_csv)
# �̸� data.frame���� ����
year_18_food_data_frame <- as.data.frame(year_18_food_data)
# na �ľ��ϱ�
sum(is.na(year_18_food_data_frame))
# �÷����� ���� �ٸ����� ����
# �õ�, �ñ���, ���鵿, ������ = �߽���_�õ�, �߽���_��, �߽���_��, ����
str(year_18_food_data_frame)
# ���� Ȯ���� ���� ��������, �� �����͵��� ���ʿ� ������ �ٸ� ���ʿ� ������ �ִ°�?
# �õ� �������� na index��, �߽���_�õ��� na�� �ƴ� ���� index�� Ȯ���غ���
sum(
  which(is.na(year_18_food_data_frame$�õ�)) != which(!is.na(year_18_food_data_frame$�߽���_�õ�)))
# �ñ��� �������� na index��, �߽���_���� na�� �ƴ� ���� index�� Ȯ���غ���
sum(
  which(is.na(year_18_food_data_frame$�ñ���)) != which(!is.na(year_18_food_data_frame$�߽���_��)))
# ���鵿 �������� na index��, �߽���_���� na�� �ƴ� ���� index�� Ȯ���غ���
sum(
  which(is.na(year_18_food_data_frame$���鵿)) != which(!is.na(year_18_food_data_frame$�߽���_��)))
# 0�� ���°����� ���� ������ ��� ���� �ٸ����� na�� ��ġ�� �ֽ��ϴ�
# ���� �õ�,�ñ���,���鵿�� na��ġ�� �߽���_�õ�,�߽���_��, �߽���_���� data�� ���� �־��ݴϴ�
year_18_food_data_frame$�õ�[which(is.na(year_18_food_data_frame$�õ�))] <- year_18_food_data_frame$�߽���_�õ�[which(!is.na(year_18_food_data_frame$�߽���_�õ�))]
year_18_food_data_frame$�ñ���[which(is.na(year_18_food_data_frame$�ñ���))] <-  year_18_food_data_frame$�߽���_��[which(!is.na(year_18_food_data_frame$�߽���_��))]
year_18_food_data_frame$���鵿[which(is.na(year_18_food_data_frame$���鵿))] <-  year_18_food_data_frame$�߽���_��[which(!is.na(year_18_food_data_frame$�߽���_��))]
# �׸������� na�� ���캸��
sum(is.na(year_18_food_data_frame$�õ�))
sum(is.na(year_18_food_data_frame$�ñ���))
sum(is.na(year_18_food_data_frame$���鵿))
# ������, ���ڵ� ���� ������� ���� �Ѵ�.
# ������
sum(
  which(is.na(year_18_food_data_frame$������)) != which(!is.na(year_18_food_data_frame$����)))
year_18_food_data_frame$������[which(is.na(year_18_food_data_frame$������))] <- 
  year_18_food_data_frame$����[which(!is.na(year_18_food_data_frame$����))]
sum(is.na(year_18_food_data_frame$������))
# ���ɴ�
sum(
  which(is.na(year_18_food_data_frame$���ɴ�)) != which(!is.na(year_18_food_data_frame$����)))
year_18_food_data_frame$���ɴ�[which(is.na(year_18_food_data_frame$���ɴ�))] <- 
  year_18_food_data_frame$����[which(!is.na(year_18_food_data_frame$����))]
sum(is.na(year_18_food_data_frame$���ɴ�))
str(year_18_food_data_frame)
# ���� �ʿ� ����, �߽���_�õ�, �߽���_��, �߽���_��, ����, ������ ���� ����.
year_18_food_data_frame <- year_18_food_data_frame[,1:9]
for(i in 1:9) {
  print(sum(is.na(year_18_food_data_frame[,i])))
}
# ���ſ� ���ڴ� ������ �����Ͱ� ��� NA�� ǥ�ð� �Ǿ� �ִ�.
year_18_food_data_frame$����[which(is.na(year_18_food_data_frame$����))] <- "������"
# ���� NA Ȯ��
sum(is.na(year_18_food_data_frame))