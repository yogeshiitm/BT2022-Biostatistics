% F-test status on replication component(2mark)    - 1 (correct)
% F-test status on treatment component(2mark)      - 1 (correct)
% p-value for the replication F-test(5mark)        - 1.4487e-04 
% p-valuer for the treatment F-test(5mark)         - 4.6371e-129
% p-value for the post ANOVA t-test pair 1(3mark)  - 4.3955e-55
% p-value for the post ANOVA t-test pair 2(3mark)  - 4.4131e-24

% evaluation
% EE19B130,0,0,49.9472,49.9628,0.102377,0.0659429,14.25

% |x - 1.4487e-04|/x * 100 = 49.9472      => x = 9.6614e-05    & 2.89434e-04(ans)
% |x - 4.6371e-129|/x * 100 = 49.9628     => x = 3.09217e-129  & 9.26731e-129(ans)
% |x - 4.3955e-55|/x * 100 = 0.102377     => x = 4.391e-55     &  4.4e-55
% |x - 4.4131e-24|/x * 100 = 0.0659429    => x = 4.41019e-24   &  4.41601e-24


alpha = 0.0116117;
p1 = [1,4];
p2 = [9,13];
pairs = zeros(2,2);
pairs(1,:) = p1;
pairs(2,:) = p2;
data = [
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

r_num = 10;
t_num = 15;
tdof = t_num -1;
rdof = r_num -1;
totdof = t_num*r_num - 1;
edof = totdof - tdof - rdof;

m = 0;
s = 0;
for i=1:t_num
    for j=1:r_num
        m = m + data(i,j);
        s = s + data(i,j)^2;
    end
end
cf = m^2/(t_num*r_num);
tots = s - cf;

rs1 = 0;
for i = 1:r_num
    rs1 = rs1 + sum(data(:,i))^2;
end
rs = rs1/t_num -cf;

ts = 0;
for i=1:t_num
    ts = ts + sum(data(i,:))^2;
end
ts = ts/r_num - cf;

es = tots - ts - rs;
ems = es/edof;
rems = rs/rdof;
trms = ts/tdof;

fr = rems/ems;
frtest = 0;
if ((fr <= finv(alpha/2, rdof, edof))||(fr >= finv(1-alpha/2, rdof, edof)))
    frtest = 1;
end
frpval = 2*fpval(fr,rdof,edof);
%fval -> pvalue for F replication test and status of frtest
%--------------------------------------------------------

if frtest == 1
    disp("Replications not ok");
else
    disp("replication Ok, adding to error ss");
    ems = ems + rems; edof = edof + rdof;
end

ft = trms/ems;
fttest = 0;
if ((ft < finv(alpha/2,tdof,edof))||(ft > finv(1-alpha/2,tdof,edof)))
    fttest = 1;
end
ftpval = 2*fpval(ft,tdof,edof);
%fval -> pvalue for F treatment test and status of fttest
%---------------------------------------------------------

disp("frtest :"); disp(frtest);
disp("fttest :"); disp(fttest);
disp("frpval :"); disp(frpval);
disp("ftpval :"); disp(ftpval);
%---------------------------------------------------------


%Post ANOVA t-test
trmeans = mean(data, 2);
[tr_sm, mi] = sort(trmeans,"descend");
disp("sorted means index vs means");
%disp(mi);
%disp(tr_sm);

t_tab_aby2 = tinv(alpha/2, edof);
t_tab_lmaby2 = tinv(1-alpha/2, edof);
tvals = zeros(2,1);
tpvals = zeros(2,1);
for i=1:2
    tcal = abs(tr_sm(pairs(i,1)) - tr_sm(pairs(i,2)))/sqrt(2*ems/(rdof+1));
    tvals(i) = tcal;
end
for i=1:2
    tpvals(i) = tpval(tvals(i),edof);
end
disp("tpvals :");
disp(tpvals);
%tvals -> pvals of the given pairs 

function pval=tpval(a,b)
    pval=betainc(b/(b+a^2),b/2,0.5);
end

function p = fpval(x,df1,df2)
    x1 = 1./max(0,x);
    x1(isnan(x)) = NaN;
    p = fcdf(x1,df2,df1);
end






