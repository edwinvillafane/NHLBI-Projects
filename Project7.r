fram1<-read.csv(file.choose(), header=T)
#create an age group variable
fram1$AGEGRP<-ifelse(fram1$AGE>30 & fram1$AGE<=45, 1, 
                     ifelse(fram1$AGE>45 & fram1$AGE<=60, 2, ifelse(fram1$AGE>60 & fram1$AGE<=75, 3, NA)))

#creates weight group variables
fram1$weight<-ifelse(fram1$BMI>18.5 & fram1$BMI< 25, 1,
                     ifelse(fram1$BMI<=25 & fram1$BMI<30,2, ifelse(fram1$BMI>=30,3, NA)))

#creates a binary variable to indicate whether an individual is a male or not
fram1$SEXGRP<-ifelse(fram1$SEX==1,1, ifelse(fram1$BMI==1, 0, NA))

#does total cholesterol differ by age group?
anova1<-aov(fram1$TOTCHOL~fram1$AGEGRP)
summary(anova1)

#does age differ by weight groups?
anovaage<-aov(fram1$AGE~fram1$weight)
summary(anovaage)

#does systolic blood pressure differ by weight groups?
anovasysbp<-aov(fram1$SYSBP~fram1$weight)
summary(anovaage)

#does diastolic blood pressure differ by weight groups?
anovadiabp<-aov(fram1$DIABP~fram1$weight)
summary(anovadiabp)

#does diastolic blood pressure differ by weight groups?
anovatotchol<-aov(fram1$TOTCHOL~fram1$weight)
summary(anovatotchol)

#is there a linear association between total cholesterol (outcome), and age?
lin.mod1<-lm(fram1$TOTCHOL~fram1$AGE)
summary(lin.mod1)

#is there a linear association between BMI (outcome), and age?
lin.bmiage<-lm(fram1$BMI~fram1$AGE)
summary(lin.bmiage)

#is there a linear association between BMI (outcome), and being male?
lin.bmisex<-lm(fram1$BMI~fram1$SEXGRP)
summary(lin.bmisex)

#is there a linear association between BMI (outcome), and sysbp?
lin.bmisysbp<-lm(fram1$BMI~fram1$SYSBP)
summary(lin.bmisysbp)

#is there a linear association between BMI (outcome), and totchol?
lin.bmitotchol<-lm(fram1$BMI~fram1$TOTCHOL)
summary(lin.bmitotchol)

#is there a linear association between total cholesterol (outcome), and age, sex, and BMI?
lin.mod2<-lm(fram1$TOTCHOL~fram1$AGE+fram1$SEX+fram1$BMI)
summary(lin.mod2)

#is there a linear association between BMI (outcome), and age, sex, and systolic blood pressure and total cholesterol?
lin.mult<-lm(fram1$BMI~fram1$AGE+fram1$SEX+fram1$SYSBP+fram1$TOTCHOL)
summary(lin.mult)

#create a binary variable to indicate high total cholesterol
fram1$HI_TC<-ifelse(fram1$TOTCHOL>=200, 1, ifelse(fram1$TOTCHOL<200, 0, 
                                                  NA))

#creates a binary variable to indicate whether an individual is obese or not
fram1$OBESE<-ifelse(fram1$BMI>=30,1, ifelse(fram1$BMI<30, 0, NA))

#is there an association between high total chol (outcome) and age?
log.mod1<-glm(fram1$HI_TC~fram1$AGE, family="binomial")
summary(log.mod1)

#is there an association between Obesity (outcome) and age?
log.obeseage<-glm(fram1$OBESE~fram1$AGE, family="binomial")
summary(log.obeseage)

#is there an association between Obesity (outcome) and being male?
log.obesesex<-glm(fram1$OBESE~fram1$SEX, family="binomial")
summary(log.obesesex)

#is there an association between Obesity (outcome) and sysbp?
log.obesesysbp<-glm(fram1$OBESE~fram1$SYSBP, family="binomial")
summary(log.obesesysbp)

#is there an association between Obesity (outcome) and age?
log.obesetotchol<-glm(fram1$OBESE~fram1$TOTCHOL, family="binomial")
summary(log.obesetotchol)

#is there an association between high total chol (outcome) and age, sex, and BMI?
log.mod2<-glm(fram1$HI_TC~fram1$AGE+fram1$SEX+fram1$BMI, family="binomial")
summary(log.mod2)

#is there an association between BMI (outcome) and age, sex, and systolic blood pressure and total cholesterol?
log.multlog<-glm(fram1$OBESE~fram1$AGE+fram1$SEX+fram1$SYSBP+fram1$TOTCHOL, family="binomial")
summary(log.multlog)
