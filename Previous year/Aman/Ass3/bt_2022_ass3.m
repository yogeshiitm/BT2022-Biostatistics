clc;
alpha  = 0.016209;
trt = 10;rep =10;
todof = trt*rep -1;
tr_dof = 9;rep_dof =9;
errordof_temp = todof - tr_dof- rep_dof;
errordof = errordof_temp;

X  = [13.477, 12.923, 9.6244, 13.347, 15.624, 15.296, 11.314, 16.647, 12.957, 18.719;
16.383, 14.673, 12.19, 14.781, 10.561, 19.891, 14.696, 14.863, 12.286, 13.179;
9.2551, 11.039, 6.6935, 6.3657, 16.837, 8.8383, 13.769, 8.0044, 14.606, 20.768;
6.3116, 8.2847, 3.7204, 4.1699, 6.411, 8.0551, -0.13232, 6.0208, 3.5803, 1.7014;
7.5653, 7.9782, 8.5533, 8.3085, 8.6867, 8.2702, 8.8592, 7.9622, 8.2844, 7.6912;
8.1384, 11.034, 12.936, 6.1292, 7.9466, 9.9332, 14.415, 9.0873, 11.39, 8.7818;
2.3421, 4.9645, 5.2901, 1.9368, 3.9702, 6.5918, 7.3781, 3.1992, 6.6074, 1.1878;
14.094, 10.883, 15.884, 15.101, 16.035, 14.071, 20.273, 12.012, 14.493, 15.528;
8.4775, 7.4478, 8.6582, 10.099, 9.403, 8.6079, 7.9338, 10.205, 9.8743, 5.2708;
11.767, 9.291, 6.3252, 8.6402, 10.164, 8.4243, 10.868, 11.48, 10.493, 11.261];

smt = 0;sst =0;
for i =1:10
    for j = 1:10
        smt = smt + X(i,j);
        sst = sst + X(i,j)^2;
  
    end
end

cf  = smt^2 / (trt *rep);
tot_SS = sst-cf;
disp("Square Total: "); disp(tot_SS); %1

tr_SS = 0;
for i = 1 :10
    sum_1 =0;
    sum_1 = sum(X(i,:));
    tr_SS = tr_SS + sum_1^2;
end
tr_SS = (tr_SS/rep)- cf;
disp("Sum of Square Treat: "); disp(tr_SS); %2


rep_SS = 0;
for  i= 1:10
    sum_2 =0;
    sum_2 = sum(X(:,i));
    rep_SS = rep_SS + sum_2^2; 
end
rep_SS = (rep_SS /trt)-cf;
disp("Sum of Square Repl: "); disp(rep_SS); %3
error_SS = tot_SS - tr_SS - rep_SS;
disp("Sum of Square error: "); disp(error_SS); %4

ftrt = (tr_SS/tr_dof)/(error_SS/errordof_temp);
frep = (rep_SS/rep_dof)/(error_SS/errordof_temp);
disp("[f_treat f_rep]: "); disp([ftrt frep]); %5 and 6

ftest_trt = 0; ftest_rep =0;
if ftrt < finv(alpha/2,tr_dof,errordof_temp) || ftrt > finv(1-(alpha/2),tr_dof,errordof_temp)
   ftest_trt =1; 
end

if frep < finv(alpha/2,rep_dof,errordof_temp) || frep > finv(1-(alpha/2),rep_dof,errordof_temp)
   ftest_rep =1; 
end

disp("[ftest_treat ftest_rep]: "); disp([ftest_trt ftest_rep]); %7 and 8

if ftest_rep == 0
    error_SS = error_SS + rep_SS;
    errordof = errordof + rep_dof;
end

ems  = error_SS / errordof;
disp("[Error mean Sqr, Error DOF]: "); disp([ems errordof]); %9 and 10