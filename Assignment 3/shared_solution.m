clc;
clear;
alpha = 0.0813538;
p1 = [2,7];
p2 = [11,14];
pairs = zeros(2,2);
pairs(1,:) = p1;
pairs(2,:) = p2;
data = readmatrix("Book1.xlsx");
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
frpval = fpval(fr,rdof,edof);
%fval -> pvalue for F replication test and status of frtest
disp("frpval :"); disp(frpval);
disp("frtest :"); disp(frtest);
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
ftpval = fpval(ft,tdof,edof);
disp("ftpval :"); disp(ftpval);
disp("fttest :"); disp(fttest);
%fval -> pvalue for F treatment test and status of fttest
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
    tcal = (tr_sm(pairs(i,1)) - tr_sm(pairs(i,2)))/sqrt(2*ems/(rdof+1));
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






