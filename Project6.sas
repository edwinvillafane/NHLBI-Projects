libname lib "C:\Users\ehv02014\Desktop";

proc format;

	value weightfmt 0='Not Obese'
					1='Obese';

	value chdfmt 0='No exposure'
					1='1= Disease';
	value smokefmt 0='No'
					1='1= Yes';

run;

data jhs; set lib.JHSdata;
	
	if bmi le 30 then weight=0;
	else if (bmi gt 30) then weight=1;
	else if (bmi ='.') then weight=.;

	label weight='Weight Categories';

	format bmi weightfmt. chd chdfmt. currsmoke smokefmt.

run;

proc freq data=jhs order=formatted;
	tables currsmoke*chd / chisq riskdiff relrisk;
	format currsmoke smokefmt. chd chdfmt.;
run;

proc freq data=jhs order=formatted;
	tables weight*chd / chisq riskdiff relrisk;
	format weight weightfmt. chd chdfmt.;
run;

