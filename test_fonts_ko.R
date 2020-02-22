plot(c(1:5), main="가나다")

#터미널에서 $ fc-list

#$ cd /usr/share/fonts

#$ wget http://cdn.naver.com/naver/NanumFont/fontfiles/NanumFont_TTF_ALL.zip

#$ unzip NanumFont_TTF_ALL.zip -d NanumFont

#$ rm -f NanumFont_TTF_ALL.zip

#$ fc-list :lang=ko

#위의 경로까지 한 후 아래의 코드를 차례로 실행


install.packages("sysfonts")
library(sysfonts)

plot(c(1:5), main="가나다")
