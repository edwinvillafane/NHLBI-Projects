/* assigns name to location of library */
libname datloc 'c:\users\ehv02014\desktop\';
/* sets up categories for age */
proc format;
	value agegrpf 1='1=60 and older';
				  2='2=under 60';
run;
/* creates temporary sas dataset for framingham data set */
data fhs3;
	set datloc.frmgham;
	
	/*Limits data to period 3 data */
	if period=3;
	
	/*Places subjects into different age groups depending on their age */
	if (0 le age le 59) then agegrp=2;
	else if age ge 60 then agegrp=1;

	/*Creates a new variable midbp */
	midbp=(sysbp+diabp)/2;

	/*Creates cohort variable */
	cohort = 'FHS';

	/*retains variables */
	keep randid cohort sex agegrp totchol hdlc ldlc sysbp diabp midbp prevchd;

	/*formats agegroup variable */
	format agegrp agegrpf.;

	/*Within the fhs dataset, renames sysbp to be named systolic*/
	rename sysbp=systolic;
	/*still have to put old variable name on keep statement*/
	keep sysbp;

	/*Within the fhs dataset, renames diabp to be named diastolic*/
	rename diabp=diastolic;
	/*still have to put old variable name on keep statement*/
	keep diabp;

	/*Within the fhs dataset, renames randid to be named id*/
	rename randid=id;
	/*still have to put old variable name on keep statement*/
	keep randid;

	/*Within the fhs dataset, renames prevchd to be named chd*/
	rename prevchd=chd;
	/*still have to put old variable name on keep statement*/
	keep prevchd;

	/*Within the fhs dataset, renames hdlc to be named hdl*/
	rename hdlc=hdl;
	/*still have to put old variable name on keep statement*/
	keep hdlc;

	/*Within the fhs dataset, renames ldlc to be named ldl*/
	rename ldlc=ldl;
	/*still have to put old variable name on keep statement*/
	keep ldlc;

run;

/* creates temporary sas dataset for jackson heart study data set */
data jhs;
	set datloc.jhsdata;
	
	/*Places subjects into different age groups depending on their age */
	if (0 le age lt 60) then agegrp=2;
	else if age ge 60 then agegrp=1;

	/*Creates a new variable midbp */
	midbp=(systolic+diastolic)/2;

	/*Creates cohort variable */
	cohort = 'JHS';

	/*retains variables */
	keep id cohort sex agegrp totchol hdl ldl systolic diastolic midbp chd;

	/*formats agegroup variable */
	format agegrp agegrpf.;
run;


/*this data set combines both the fhs and jhs data sets*/
data fhs_jhs;
	set fhs3 jhs;
run;

/*Sorts combined data set by cohort and age group */
proc sort data=fhs_jhs;
	by cohort agegrp;
run;

/*Creates frequency tables for sex and chd variables*/
proc freq data=fhs_jhs;
	by cohort agegrp;
	tables sex chd;
run;

/* runs a descriptive statistical test */
proc means data=fhs_jhs;
	by cohort agegrp;
	var totchol hdl ldl systolic diastolic midbp;
run;

/* runs a procedure that produces histograms */
proc chart data=fhs_jhs;
	by cohort agegrp;
	vbar totchol hdl ldl systolic diastolic midbp;
run;
