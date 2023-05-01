% p-value for the replication F-test (5 marks)
% F-test status on replication component (2 mark)
% ---
% p-valuer for the treatment F-test (5 marks)
% F-test status on treatment component (2 mark)
% ---
% p-value for the post ANOVA t-test pair 1 (3 marks)
% p-value for the post ANOVA t-test pair 2 (3 marks)


clc;
alpha  = 0.0116117;
trt = 15; rep = 10;
todof = trt*rep -1;
tr_dof = 14; rep_dof =9;
errordof_temp = todof - tr_dof - rep_dof;
errordof = errordof_temp;

X  = [
71.4674    70.1734    62.3013    72.442     73.344    100.166    71.8172    66.4059    68.2517    70.2332   
293.119    288.396    275.278    282.282    284.16    293.187    276.611    288.753    285.961    294.969    
58.5143    48.5551    51.168     74.0088    49.122    54.6432    66.3463    51.9397    44.3146    63.6198    
243.89     243.325    239.056    245.243    245.301   260.114    243.237    242.198    246.217    241.684    
155.773    144.856    156.041    149.749    140.45    140.84     138.707    159.579    142.182    134.437    
40.5011    12.0167    29.6663    37.8545    21.8184   40.3648    19.9524    27.1456    23.5587    27.222    
27.9892    22.1475    23.263     22.363     23.1464   21.6691    19.2468    24.6387    24.1317    20.6125    
198.222    186.671    182.047    187.242    191.073   201.064    190.062    175.979    185.778    177.579    
-0.522383  -6.09028   14.7886    7.32775    -4.57368  19.0706    -7.42181   10.4275    20.3747    3.26253    
255.282    243.771    235.259    244.462    235.53    230.279    247.27     235.757    239.012    233.911    
140.902    153.555    147.789    149.688    144.771   149.77     144.331    140.785    134.392    146.035    
26.1094    25.646     26.3704    26.0618    25.9469   37.1318    27.0562    27.3681    25.7794    26.5113    
169.498    157.864    169.688    160.968    166.719   200.443    171.693    184.84     178.458    155.326    
79.2857    78.0848    68.2908    93.8821    61.5917   91.987     71.3968    83.528     76.3123    93.0902    
51.3294    62.8486    38.1646    51.5629    44.824    77.3322    71.7768    45.6603    54.2628    50.2725   
];

smt = 0;sst =0;
for i = 1:15
    for j = 1:10
        smt = smt + X(i,j);
        sst = sst + X(i,j)^2;
  
    end
end


%------------------------------------------------
cf  = smt^2 / (trt *rep);
tot_SS = sst-cf;
disp("Square Total: "); disp(tot_SS); %1

tr_SS = 0;
for i = 1 :15
    sum_1 = 0;
    sum_1 = sum(X(i,:));
    tr_SS = tr_SS + sum_1^2;
end
tr_SS = (tr_SS/rep)- cf;
disp("Sum of Square Treat: "); disp(tr_SS); %2

rep_SS = 0;
for  i= 1:15
    sum_2 =0;
    sum_2 = sum(X(:,i));
    rep_SS = rep_SS + sum_2^2; 
end
rep_SS = (rep_SS /trt)-cf;
disp("Sum of Square Repl: "); disp(rep_SS); %3
error_SS = tot_SS - tr_SS - rep_SS;
disp("Sum of Square error: "); disp(error_SS); %4
%------------------------------------------------

ftrt = (tr_SS/tr_dof)/(error_SS/errordof_temp);
frep = (rep_SS/rep_dof)/(error_SS/errordof_temp);
disp("[f_treat f_rep]: "); disp([ftrt frep]); %5 and 6
%------------------------------------------------

ftest_trt = 0; ftest_rep =0;
if ftrt < finv(alpha/2,tr_dof,errordof_temp) || ftrt > finv(1-(alpha/2),tr_dof,errordof_temp)
   ftest_trt =1; 
end

if frep < finv(alpha/2,rep_dof,errordof_temp) || frep > finv(1-(alpha/2),rep_dof,errordof_temp)
   ftest_rep =1; 
end

disp("[ftest_treat ftest_rep]: "); disp([ftest_trt ftest_rep]); %7 and 8
%------------------------------------------------

if ftest_rep == 0
    error_SS = error_SS + rep_SS;
    errordof = errordof + rep_dof;
end

ems  = error_SS / errordof;
disp("[Error mean Sqr, Error DOF]: "); disp([ems errordof]); %9 and 10