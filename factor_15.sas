ods html close;
ods preferences;
ods html;
ods pdf startpage= never file = 'F:\Mandar\College stuff\statistics\STAT 520\SAS Codes\s';
data a;
infile 'e:\sss\s520\socio.dat';
input pop school employ services house;
run;

proc corr data = a;
run;

proc factor data = a;
quit;

*proc factor data = a scree preplot method = ml  heywood rotate= promax ;*plot;
run;

/*proc factor data = a  method = ml  heywood rotate= promax ;
run;
*/

proc factor data = a  method = prin   rotate= promax;* plot;
run;

proc factor data=a method = ml heywood n=1;
title 'one factor';
run; 
/*proc factor data=a method = ml heywood n=2;
title 'two factors';
run; */
proc factor data=a method = ml heywood n=3 rotate= promax;
title 'three factors';
run; 
ods pdf close;
