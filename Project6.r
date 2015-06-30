install.packages("epiR")
library("epiR")

#reads the frmgham.csv file into an R data frame named "frmgham"
frmgham<-read.csv(file.choose(), header=T)

fram2=subset(frmgham, PERIOD==2)

#recode smoking, obesity and chd variables
chd<-ifelse(fram2$PREVCHD==1, 'Diseased', ifelse(fram2$PREVCHD==0, 'Not Diseased', NA))
cursmoke<-ifelse(fram2$CURSMOKE==1, 'aSmoking', ifelse(fram2$CURSMOKE==0, 'Not Smoking', NA))
obesity<-ifelse(fram2$BMI>=30, 'aObese', ifelse(fram2$BMI <30, 'Not Obese', NA))
#make a 2x2 table of sex by CHD with sex on the rows adn chd on columns 
tab<-table(cursmoke, obesity)
tab<-table(obesity, chd)

#calculate OR< RR< and chi square statistic and store into an object named 'results'
results<-epi.2by2(tab, method="cohort.count", conf.level=0.95)

#display a summary of results
summary(results)
