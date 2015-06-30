libname framdat 'c:\users\ehv02014\Desktop';

proc means data= framdat.frmgham; 
	var age sysbp diabp totchol hdlc ldlc;
run;

PROC IMPORT OUT= WORK.fram1 
            DATAFILE= "C:\Users\ehv02014\Desktop\fram1.xlsx" 
            DBMS=EXCEL REPLACE;
     RANGE="fram1"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

proc freq data=fram1;
	tables sex bpmeds cursmoke diabetes;
run;
