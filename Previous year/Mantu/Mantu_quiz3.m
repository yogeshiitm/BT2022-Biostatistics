clc;
alpha  = 0.038742;
trt = 10;rep =10;
todof = trt*rep -1;
tr_dof = 9;rep_dof =9;
errordof_temp = todof - tr_dof- rep_dof;
errordof = errordof_temp;
X  = [2.5659,2.3555,0.046298,4.1139,2.179,3.5422,1.3832,2.8101,1.2929,3.0564;
12.99,12.847,10.941,10.739,12.84,13.285,11.035,13.313,7.8567,10.987;
13.936,10.3,7.212,12.351,2.0537,5.3817,7.9762,5.1921,10.552,11.927;
6.2527,12.435,5.6202,10.295,4.1771,1.6613,10.135,9.1679,13.364,7.2549;
14.984,12.518,15.517,14.664,14.89,12.638,17.997,13.509,11.266,17.886;
6.0757,5.8856,5.7795,7.2195,7.9618,4.4713,6.093,7.6841,6.0751,6.9387;
8.0907,8.3593,5.1497,3.8607,6.8894,5.0701,4.7775,5.1,4.6563,5.8553;
13.996,17.163,11.869,12.434,11.398,10.649,10.203,20.898,13.306,10.714;
14.007,7.9782,8.3362,7.6909,8.9054,11.622,8.3751,3.5555,5.422,8.8451;
13.717,13.591,14.8,14.544,16.194,14.114,13.772,13.899,14.933,12.984;];
smt = 0;sst =0;
for i =1:10
    for j = 1:10
        smt = smt + X(i,j);
        sst = sst + X(i,j)^2;
  
    end
end

cf  = smt^2 / (trt *rep);
tot_SS = sst-cf;
disp(tot_SS);

tr_SS = 0;
for i = 1 :10
    sum_1 =0;
    sum_1 = sum(X(i,:));
    tr_SS = tr_SS + sum_1^2;
end
tr_SS = (tr_SS/rep)- cf;
disp(tr_SS);


rep_SS = 0;
for  i= 1:10
    sum_2 =0;
    sum_2 = sum(X(:,i));
    rep_SS = rep_SS + sum_2^2; 
end
rep_SS = (rep_SS /trt)-cf;
disp(rep_SS);
error_SS = tot_SS - tr_SS - rep_SS;
disp(error_SS);

ftrt = (tr_SS/tr_dof)/(error_SS/errordof_temp);
frep = (rep_SS/rep_dof)/(error_SS/errordof_temp);
disp([ftrt frep]);

ftest_trt = 0; ftest_rep =0;
if ftrt < finv(alpha/2,tr_dof,errordof_temp) || ftrt > finv(1-(alpha/2),tr_dof,errordof_temp)
   ftest_trt =1; 
end

if frep < finv(alpha/2,rep_dof,errordof_temp) || frep > finv(1-(alpha/2),rep_dof,errordof_temp)
   ftest_rep =1; 
end

disp([ftest_trt ftest_rep]);

if ftest_rep == 0
    error_SS = error_SS + rep_SS;
    errordof = errordof + rep_dof;
end

ems  = error_SS / errordof;
disp([ems errordof]);