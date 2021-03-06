*A producer of various feed additives for cattle conducts a study of the number of days of
feedlot time required to bring beef cattle to market weight. Eighteen steers of essentially identical
age and weight are purchased and brought to a feedlot. Each steer is fed a diet with a specific
combination of protein content, antibiotic concentration, and percentage of feed supplement.
The data are as follows;

data diet;
input steer protein antibio supplem times;
datalines;
1 10 1 3 88
2 10 1 5 82
3 10 1 7 81
4 10 2 3 82
5 10 2 5 83
6 10 2 7 75
7 15 1 3 80
8 15 1 5 80
9 15 1 7 75
10 15 2 3 77
11 15 2 5 76
12 15 2 7 72
13 20 1 3 79
14 20 1 5 74
15 20 1 7 75
16 20 2 3 74
17 20 2 5 70
18 20 2 7 69
;
run;


*pairwise scatterplots between all variables and Pearson correlation coefficients (n=18);
proc corr plots=matrix;
var times protein antibio supplem;
run;


proc reg data=diet;
model0: model times=;
model1: model times=protein;
model2: model times=antibio; 
model3: model times=supplem;
model4: model times=protein antibio supplem/clb; 
test1: test antibio=-5.0; 
test2: test antibio=-5.0, supplem=-1.0; 
test3: test antibio=0, supplem=0; 
modelred: model times=protein; 
modelfull: model times=antibio supplem protein;
run;

*use the model to predict the average time for steers with protein=12%, antibio=1.5%, and supplem=6%;
data newobs;
input steer protein antibio supplem times;
datalines;
19 12 1.5 6 .
run;

data newobs;
set diet newobs;
run;

*95% confidence interval;
proc reg data=newobs;
model5: model times=protein antibio supplem/cli clm; 
run;


data temp;
Pval=1-probf(42.32,2,14);
proc print data=temp;
run;
