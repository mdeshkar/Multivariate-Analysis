ods html close;
ods preferences;
ods html;
ods listing;
option ls = 80 ps = 70 nodate;
ods pdf startpage = never file = 'c:\removable disk\sss\s520\mreg.pdf';


data a;
infile 'c:\removable disk\sss\s520\semi.dat';
input x1 x2 y1 y2 y3;
run;

proc print;
run;


proc reg data = a;
model y1 y2 y3 = x1 x2;
mtest;
quit;

proc reg data = a;
model y1 y2 y3 = x1 x2;
model: mtest x1,x2/print;
onlyx1: mtest x1;
onlyx2: mtest x2;
allcoef: mtest y1-y2, y2-y3, intercept, x1, x2;
x1andx2: mtest y1-y2, y2-y3,x1,x2;
title 'Spatial Univormity in Semiconductor Processes';
run; 
quit;
ods pdf close;
