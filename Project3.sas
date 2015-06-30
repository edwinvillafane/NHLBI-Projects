/* sets up fhs data using list input */
data proj3_fhs_list; 
	infile 'c:\users\ehv02014\desktop\fram_small1.txt' pad;
	input id totchol1 age1 sysbp1 diabp1 hdlc1 sex $;
	drop hdlc1;	
run;
/* prints up fhs data using list input */
proc print data=proj3_fhs_list;
	title 'List input';
	id id;
run;
/* sets up fhs data using column input */
data proj3_fhs_col;
	infile 'c:\users\ehv02014\desktop\fram_small1.txt' pad;
	input id 1-5 totchol1 7-9 age1 11-12 sysbp1 14-18 diabp1 20-22 sex $ 26;
	keep id totchol1 age1 sysbp1 diabp1 sex;
run;
/* prints up fhs data using column input */	
proc print data=proj3_fhs_col; 
	title 'Column input';
	id id;
run;
/* sets up fhs data from exam 3 */
data proj3_fhs3;
	infile 'c:\users\ehv02014\desktop\fram_small3.txt';
	input id totchol3 age3 sysbp3 diabp3 hdlc3 sex $;
run;
/* prints up fhs data from exam 3 */
proc print data=proj3_fhs3;
	title 'FHS Exam 3';
	id id;
run;
/* sets up jhs exam 1 data */
data proj3_jhs;
	infile 'c:\users\ehv02014\desktop\jhs_small.txt';
	input id totchol1 age1 sysbp1 diabp1 hdlc1 sex $;
run;
/* prints up jhs exam 1 */
proc print data=proj3_jhs;
	title 'JHS Exam 1';
	id id;
run;
/* sets up fhs combined data */
data fhs_all;
	merge proj3_fhs_list proj3_fhs3;
	by  id;
run;
/* prints fhs combined data */
proc print data=fhs_all;
	title 'Combined FHS exams 1 and 3';
	id id;
run;
/* sets up fhs and jhs combined data */
data fhs_jhs;
	set proj3_fhs_list proj3_jhs;
run;
/* prints fhs and jhs combined data */
proc print data=fhs_jhs;
	title 'Combined FHS and JHS data';
	id id;
run;
