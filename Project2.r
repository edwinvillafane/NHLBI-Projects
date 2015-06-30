#load necessary packages
library(gdata)

#read the jhsdat.csv file into an r data frame named jhs
jhs<-read.csv(file.choose(), header=T)

#removes individuals that are underweight
jhs<-subset(jhs, jhs$bmi>=18.5)

#creates weight categories
jhs$weight<-ifelse(18.5<=jhs$bmi & jhs$bmi< 25, 1, 
                   ifelse(25<=jhs$bmi % jhs$bmi<30, 2, 3))

#outputs summary statistics for AGE
summary(jhs$age)
sd(jhs$age, na.rm=T)
nobs(jhs$age)

#outputs summary statistics for systolic
summary(jhs$systolic)
sd(jhs$systolic, na.rm=T)
nobs(jhs$systolic)

#outputs summary statistics for diastolic
summary(jhs$diastolic)
sd(jhs$diastolic, na.rm=T)
nobs(jhs$diastolic)

#outputs summary statistics for HDL
summary(jhs$HDL)
sd(jhs$HDL, na.rm=T)
nobs(jhs$HDL)

#outputs summary statistics for LDL
summary(jhs$LDL)
sd(jhs$LDL, na.rm=T)
nobs(jhs$LDL)

#outputs summary statistics for totchol
summary(jhs$totchol)
sd(jhs$totchol, na.rm=T)
nobs(jhs$totchol)

#gives the number of people of a certain sex
table(jhs$sex)

#gives the number of people who have diabetes
table(jhs$Diabetes)

#gives the number of people who have CHD
table(jhs$chd)

#gives the number of people who currently smoke
table(jhs$currsmoke)

#gives the number of people who consume alcohol
table(jhs$alcohol)

#creates histogram of age
hist(jhs$age, main="Distribution of Age in JHS", col="red", xlab="Age")

#creates histogram of systolic blood pressure
hist(jhs$systolic, main="Distribution of Systolic Blood Pressure in JHS", col="red", xlab="Age")

#creates scatterplot of age vs systolic blood pressure
plot(jhs$age~jhs$systolic, main="Scatterplot of Age vs. Systolic Blood Pressure in JHS", xlab="SBP", ylab="Age")
