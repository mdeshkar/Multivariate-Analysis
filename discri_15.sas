option ls=100 ps=100 nodate nonumber;
ods html close;
ods preferences;
ods html;* path='F:\College stuff\Statistics\STAT 520\';
ods listing;
*ods pdf startpage = never file = 'F:\College stuff\Statistics\STAT 520\gpa.pdf';

data gpa;
*infile 'c:\removable disk\sss\s520\gpa.dat';
infile 'F:\Mandar\College stuff\Statistics\STAT 520\Data\gpa(1).dat';
input admit $ gpa gmat;
run;

proc print data = gpa;
run;


%include 'e:\sss\s520\multinorm_macro.sas';

%multnorm(data = gpa, var = gpa gmat);

proc standard data  = gpa mean = 0 std = 1 out = gpastd;
var gpa gmat;
run;

proc means data = gpa;
run;

proc means data = gpa maxdec = 3;
class admit;
run;

*proc print data = gpastd;
run;
proc means data  = gpastd;
run;


*proc print data = gpa;
run;

data admitst;
*infile 'c:\removable disk\sss\s520\gpatst.dat';
infile 'e:\sss\s520\gpatst.dat';
input admit $ gpa gmat;
run;

proc print data = admitst;
run;


proc means data = gpa maxdec = 3;
var gpa gmat;
run;

proc sort data = gpa;
by admit;

proc means data = gpa;
class admit;
var gpa gmat;
run;

*ods html path='e:\sss\s520\';
proc sgscatter data = gpa;
matrix gpa gmat/group = admit;
run;
*ods html close;

/* *ods html;
proc sgscatter data = gpa;
matrix gpa gmat/group = admit diagonal=
(histogram kernel);
run;
*ods html close;
*/


proc sgscatter data = gpa;
matrix gpa gmat/group = admit diagonal=
(histogram normal);
run;
*ods html path='e:\sss\s520\';
proc sgscatter data = gpa;
matrix gpa gmat/group = admit diagonal=
(histogram normal);
run;
*ods html close;



proc sort data = gpa;
by admit ;
run;

proc discrim data=gpa outstat=gpastat 
method=normal pool=yes  listerr manova ;
priors 'a'=.3333 'b'=.3333 'c'=.3333; /* a: admin b:notadmit c:border */
class admit;
var gpa gmat;
title 'Using Linear Discriminant Function';
run;
quit;



proc discrim data=gpa outstat=gpastat 
method=normal pool=test  listerr manova ;
priors 'a'=.3333 'b'=.3333 'c'=.3334; /* a: admin b:notadmit c:border */
class admit;
var gpa gmat;
title 'Using Linear Discriminant Function';
run;
quit;


proc discrim data=gpa outstat=gpastat distance
method=normal pool=test  listerr manova ;
priors 'a'=.36 'b'=.33 'c'=.31; /* a: admin b:notadmit c:border */

class admit;
var gpa gmat;
title 'Using Linear Discriminant Function';
run;
quit;

proc discrim data=gpastat testdata=admitst testout=tout 
testlist distance;
class admit;
var gpa gmat;
run;

proc print data=tout;
title2 'Output Classification Results of Test Data';
run;
*ods pdf close;



proc discrim data=gpa
method=normal pool=test manova wcov pcov 
listerr crosslisterr distance;
priors 'a'=.3333 'b'=.3333 'c'=.3334; /* a: admin b:notadmit c:border */
class admit;
var gpa gmat;
run;

proc discrim data=gpa
method=normal pool=test manova wcov pcov listerr crosslisterr distance;
*priors 'a'=.3333 'b'=.3333 'c'=.3334; /* a: admin b:notadmit c:border */
class admit;
priors prop;
var gpa gmat;
run;

proc discrim data=gpa
method=npar k=5 listerr crosslisterr distance;
*priors 'a'=.3333 'b'=.3333 'c'=.3334; /* a: admin b:notadmit c:border */
class admit;
priors prop;
var gpa gmat;
run;

proc means data = gpa maxdec = 3 n mean std var;
class admit;
var gpa gmat;
run;


proc discrim data=gpa
method=normal pool = test listerr crosslisterr distance;
*priors 'a'=.3333 'b'=.3333 'c'=.3334; /* a: admin b:notadmit c:border */
class admit;
priors equal;
var gpa gmat;
run;

