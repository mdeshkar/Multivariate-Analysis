/* Principal Component Analysis Example
By: Dr. Lin
*/
ods html close;
ods preferences;
ods html;
option ls=80 ps=70;

ods rtf file = 'e:\sss\s520\pc_track.rtf';


data a;
length country $20.;
infile 'e:\sss\s520\mentrack.dat' firstobs = 2;    /* use negative sign to show that the smaller,the better */
input country $ 
x100 x200 x400 x800 x1500 x5k x10k xmarathon;
/*
x100=-x100; x200=-x200;x400=-x400;x800=-x800;x1500=-x1500;x5k=-x5k;
x10k=-x10k;xmarathon=-xmarathon;
*/
run;

proc print data = a;
run;

proc means data = a maxdec  = 3;
run;

proc corr data = a;
run;
quit;
run;


proc princomp    data = a  out=result1;
var x100 x200 x400 x800 x1500 x5k  x10k xmarathon;
run;
quit;
run;


proc print data = result1; 
*var country prin1 prin2 prin3;
run;

proc princomp   std out=result;
var x100 x400 x1500  x10k ;
run;



/* use cov instead of corr */


/* 
proc princomp  cov  out=result;
var x100 x400 x1500  x10k ;
run;

*/

proc sgplot data=a;
scatter  x=x100 y=x200/datalabel = country;
*plot x100*x200;
run;
quit;

proc sgplot data=result1; 
scatter x=prin1 y=prin2/datalabel=country;
run;
quit;


proc gplot data=result1; 
plot prin2 *prin1 =country;
run;
quit;


ods rtf close;
