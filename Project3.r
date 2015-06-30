#read fram_small1.text into R
#file specifies the location of the txt file
#header=F means that the variable names are  not on the first row of the file
#col.names specifies the column names
#na.strings="." means that missing values are denoted by a period
#fill=T is used to take care of the trailing blank at the end of line 8
#thus fill=T is like the missover option in SAS

fram1<-read.table(file="C:/Users/ehv02014/Desktop/fram_small1.txt", header=F, 
                  col.names=c("id", "totchol1", "age1", "sysbp1", "diabp1", "hdlc1", "sex"), 
                  na.strings=".", fill=T)

#remove hdlc1, the 6th column
fram1<-fram1[,-6]

#reads fram 3 file
fram3<-read.table(file="C:/Users/ehv02014/Desktop/fram_small3.txt", header=F, 
                  col.names=c("id", "totchol1", "age1", "sysbp1", "diabp1", "hdlc1", "sex"), 
                  na.strings=".", fill=T)

#remove hdlc1, the 6th column
fram3<-fram3[,-6]

#reads jhs file
jhs1<-read.table(file="C:/Users/ehv02014/Desktop/jhs_small.txt", header=F, 
                  col.names=c("id", "totchol1", "age1", "sysbp1", "diabp1", "hdlc1", "sex"), 
                  na.strings=".", fill=T)

#remove hdlc1, the 6th column
jhs1<-jhs1[,-6]

#combine framingham data from exams 1 and 3
fhs_all<-merge(x=fram1, y=fram3, by=c("id", "sex"), all.x=T, all.y=T)

#combine the fhs data from exam 1 and jhs data from exam 1
fhs_jhs<-rbind(fram1, jhs1)
