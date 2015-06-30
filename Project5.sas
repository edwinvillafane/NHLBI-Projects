/*Assigns name to location of library*/
libname old 'c:\users\ehv02014\desktop';

/*creates temporary sas dataset for framingham exam 1 data*/
data fhs1;
	set old.fram1;
	
	/*Creates cohort variable, keeps variables, and renames variables to match jhs variables*/
	cohort = 'fhs';

	keep age1 sysbp1 glucose1 bmi1 cohort;

	rename sysbp1=systolic;
	rename age1=age;
	rename glucose1=glucose;
	rename bmi1=bmi;

run;

/*creates temporary sas dataset for framingham exam3 data*/
data fhs3;
	set old.fram3;
run;

/*creates temporary sas dataset for Jackson heart study data*/
data jhs;
	set old.jhsdata;

	/*Creates cohort variable and keeps variables for use*/
	cohort= 'jhs';

	keep age systolic glucose bmi cohort;
run;

/*this data set combines both the fhs data sets*/
data fhs1_fhs3;
	merge fhs1 fhs3;
	by randid;
run;

/*Macro that runs paired t test*/
%macro paired(var1, var2);
	proc ttest data= fhs1_fhs3;
	paired &var1*&var2;
	title "Paired t-test of &var1, &var2";
run;
%mend;

/*runs paired t tests using macro and variables given*/
options mprint;
%paired(age3, age1);
%paired(sysbp3, sysbp1);
%paired(cigpday3, cigpday1);
%paired(bmi3, bmi1);

/*data set combining fhs exam 1 and jhs data sets*/
data fhs1_jhs;
	set fhs1 jhs;
	keep age systolic glucose bmi cohort;
run;

/*macro that sets up t test procedure*/
%macro ttest(var);
	ods exclude statistics;
	proc ttest data=fhs1_jhs;
		class cohort;
		var &var;
	title "2 Sample t-test of &var";
run;
%mend;

/*runs t test procedure defined in macro and uses given variables*/
options mprint;
%ttest(age);
%ttest(systolic);
%ttest(glucose);
%ttest(bmi);


