ods pdf file="C:\Users\myers\Dropbox\Myers_x220\Documents\WEB_COURSES\E626\E626 Fall 2018\Module5\fun\Results_Influence.pdf";

Title1 "Regression is fun if you are careful!";
Title2 "An exploration of influential obsertations on regression outcomes.";
Title3 "Or, just because you get results doesn't mean they are worth anything.";
footnote1 height=9pt justify=left  "Author: Steven C. Myers, econdatascience.com";
footnote2 height=8pt justify=left "Source: Anscombe Quartet, https://en.wikipedia.org/wiki/Anscombe%27s_quartet";
footnote3 height=8pt justify=left "For interpretation of Influence Statistics see https://documentation.sas.com/?docsetId=statug&docsetTarget=statug_reg_details26.htm&docsetVersion=15.1&locale=en";
footnote4 height=8pt justify=left "FOr LOESS see https://en.wikipedia.org/wiki/Local_regression";
DATA FUN;                         
INPUT  X Y1 Y2 Y3 X4 Y4;

xsq=x*x;
d3=0; if y3=12.74 then d3=1;
d4=0; if y4=12.5  then d4=1;
datalines;                            
10.0  8.04 9.14  7.46  8.0  6.58  
 8.0  6.95 8.14  6.77  8.0  5.76  
13.0  7.58 8.74 12.74  8.0  7.71  
 9.0  8.81 8.77  7.11  8.0  8.83
11.0  8.33 9.26  7.81  8.0  8.47  
14.0  9.96 8.10  8.84  8.0  7.04  
 6.0  7.24 6.13  6.08  8.0  5.25  
 4.0  4.26 3.10  5.39 19.0 12.5   
12.0 10.84 9.13  8.15  8.0  5.56  
 7.0  4.82 7.26  6.42  8.0  7.91 
 5.0  5.68 4.74  5.73  8.0  6.89  
;                                 
RUN;   


ods graphics on; 

Title5 "The Anscombe Data";
proc print;
	var X X4 Y1 Y2 Y3 Y4 ;
	run;

Title5 "Plots of the Anscombe Quartet";

%Macro plot(ind, dep);
proc sgplot data=fun;
loess x=&ind y=&dep /smooth=.4;
reg x=&ind y=&dep /nomarkers; 
run;
%mend plot;

%plot(x,y1);
%plot(x,y2);
%plot(x,y3);
%plot(x4,y4);

Title5;
Footnote4;

PROC REG s plots(only)=residualchart;                         
     MODEL1: MODEL Y1 = X / influence;                
     MODEL2: MODEL Y2 = X / influence;    
     MODEL3: MODEL Y3 = X / influence;       
     MODEL4: MODEL Y4 = X4 / influence;  
     RUN;   

ods graphics off;
 
ods pdf close; 
run cancel;

