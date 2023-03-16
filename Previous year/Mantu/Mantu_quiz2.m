%sample 10
clc;
alpha = 0.0205905;
FWER = 0.349452;
alphastar = FWER/2;
x = [7.99885,-5.12807,-5.27355,-9.67294,6.25357];
y = [-0.50422,8.14281,-12.8092,13.5747,4.58584];
out = ttestclass(x,y,alpha); 
% for given sample
disp(out);
[h,p,ci,stats] = ttest2(x,y,'Alpha',alpha,'Vartype','equal');
disp(p);
disp(ci);
 out1 = ttestclass(x,y,alphastar);
% % for FWER calculation. 
 %disp(out1);