clc;
%change alpha and X according to the values given to you

alpha = 0.023799;

X = [
13.477, 12.923, 9.6244, 13.347, 15.624, 15.296, 11.314, 16.647, 12.957, 18.719;
16.383, 14.673, 12.19, 14.781, 10.561, 19.891, 14.696, 14.863, 12.286, 13.179;
9.2551, 11.039, 6.6935, 6.3657, 16.837, 8.8383, 13.769, 8.0044, 14.606, 20.768;
6.3116, 8.2847, 3.7204, 4.1699, 6.411, 8.0551, -0.13232, 6.0208, 3.5803, 1.7014;
7.5653, 7.9782, 8.5533, 8.3085, 8.6867, 8.2702, 8.8592, 7.9622, 8.2844, 7.6912;
8.1384, 11.034, 12.936, 6.1292, 7.9466, 9.9332, 14.415, 9.0873, 11.39, 8.7818;
2.3421, 4.9645, 5.2901, 1.9368, 3.9702, 6.5918, 7.3781, 3.1992, 6.6074, 1.1878;
14.094, 10.883, 15.884, 15.101, 16.035, 14.071, 20.273, 12.012, 14.493, 15.528;
8.4775, 7.4478, 8.6582, 10.099, 9.403, 8.6079, 7.9338, 10.205, 9.8743, 5.2708;
11.767, 9.291, 6.3252, 8.6402, 10.164, 8.4243, 10.868, 11.48, 10.493, 11.261];

m = 10; n = 10;

SST = 0;
SStreat = 0;
SSrep = 0;
SSE = 0;
sum = 0;
sum_square_treat = 0;
sum_square_rep = 0;

for i=1:10
    for j=1:10
        sum_square_treat = sum_square_treat + X(i,j)^2;
        sum_square_rep = sum_square_rep + X(j,i)^2;
        sum = sum + X(i,j);
        SST = SST + X(i,j)^2;
    end
    SStreat = SStreat + sum_square_treat;
    SSrep = SSrep + sum_square_rep;
    sum_square_rep = 0;
    sum_square_treat = 0;
end

CF = sum^2/100;
SST = SST - CF
SStreat = SStreat/10 - CF
SSrep = SSrep/10 - CF
SSE = SST - SStreat - SSrep

f_cal_treat = (SStreat/(m-1))/(SSE/((m-1)*(n-1)))
f_cal_rep = (SSrep/(n-1))/(SSE/((m-1)*(n-1)))

f_test_treat = 0; 
f_test_rep = 0;

if f_cal_treat < finv(alpha/2,m-1,(m-1)*(n-1)) || f_cal_treat > finv(1-alpha/2,m-1,(m-1)*(n-1))
    f_test_treat = 1;
end
disp("f_test_treat=")
disp(f_test_treat)

if f_cal_rep < finv(alpha/2,n-1,(m-1)*(n-1)) || f_cal_rep > finv(1-alpha/2,n-1,(m-1)*(n-1))
    f_test_rep = 1;
end
disp("f_test_rep=")
disp(f_test_rep)


if f_test_rep == 0
    SSE = SSE + SSrep;
    edof = m*n - m
else
    edof = (m-1)*(n-1)
end
EMS = SSE/edof


