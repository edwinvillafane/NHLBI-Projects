libname JHSdata 'c:\users\ehv02014\Desktop';
proc format;
	value sexfmt 1='Male'
				 2='Female';
	value yesnofmt 0='No'
				   1='Yes';
	value weightfmt 1='Normal'
					2='Overweight'
					3='Obese';
run;

data JHS; set JHSdata.JHSdata;
	*removes underweight subjects from analysis;
	if bmi < 18.5 then delete;

	*create weight categories;
	if 18.5le bmi lt 25.0 then weight=1;
	else if 25.0 le bmi lt 30.0 then weight=2;
	else if bmi ge 30.0 then weight=3;

	label weight='Weight Categories';
	format sex sexfmt. diabetes chd currsmoke alcohol yesnofmt. bmi weightfmt.; 
run;

proc means data= JHS;
	var age systolic diastolic hdl ldl totchol;
run;

proc freq data=JHS;
	tables sex weight diabetes chd currsmoke alcohol;
run;

proc gchart data=JHS;
title 'Age Distribution';
	vbar age;
run;

proc gchart data=JHS;
title 'Systolic Blood Pressure Among Participants';
	vbar systolic;
run;

proc gplot data=JHS;
title 'Age and Systolic Blood Pressure';
	plot systolic*age;
run;

proc means data=JHS;
	where weight=3;
	title 'Obese individuals';
	var age systolic diastolic hdl ldl totchol;
run;

proc freq data=JHS;
	where weight=3;
	title 'Obese individuals';
	tables sex weight diabetes chd currsmoke alcohol;
run;

proc gchart data=JHS;
	where weight=3;
	title 'Age Distribution Among Obese Participants';
	vbar age;
run;

proc gchart data=JHS;
	where weight =3;
	title 'Systolic Blood Pressure Among Obese Participants';
	vbar systolic;
run;

proc gplot data=JHS;
title 'Age and Systolic Blood Pressure Among Obese Participants';
	plot systolic*age;
run;
