clear all;
clc;
close all;

% num = xlsread("data5.xlsx");
num = [
0 0.071435;
0.02 0.997483;
0.04 0.947974;
0.06 1.16597;
0.08 1.69012;
0.1 1.61216;
0.12 1.66428;
0.14 2.19399;
0.16 2.10857;
0.18 2.39021;
0.2 2.18536;
0.22 2.55174;
0.24 2.3269;
0.26 2.16697;
0.28 2.60211;
0.3 2.63762;
0.32 2.72893;
0.34 3.14533;
0.36 2.88681;
0.38 2.88163;
0.4 3.48239;
0.42 3.12217;
0.44 3.08376;
0.46 3.00735;
0.48 3.73846;
0.5 3.0917;
0.52 3.48876;
0.54 3.52988;
0.56 4.13182;
0.58 4.0979;
0.6 4.09893;
0.62 3.96472;
0.64 3.75902;
0.66 3.83157;
0.68 4.26378;
0.7 4.50726;
0.72 4.6045;
0.74 4.66349;
0.76 4.67492;
0.78 5.12179;
0.8 5.32;
0.82 5.07479;
0.84 5.23086;
0.86 5.30943;
0.88 5.43473;
0.9 5.62277;
0.92 5.5708;
0.94 5.82105;
0.96 5.41735;
0.98 5.9983;
1 6.29733;
1.02 6.11881;
1.04 5.99776;
1.06 6.44528;
1.08 6.52003;
1.1 6.46342;
1.12 7.14347;
1.14 7.02646;
1.16 7.20932;
1.18 7.28088;
1.2 7.69599;
1.22 7.39808;
1.24 7.43941;
1.26 7.5197;
1.28 8.11954;
1.3 8.34869;
1.32 8.04049;
1.34 8.5362;
1.36 8.78495;
1.38 8.46521;
1.4 8.43894;
    ]
y_actual = num(:,2);
x_data = num(:,1);

a = 1.0;
b = 1.0;
c = 1.0;
d = 1.0;
h = 1.0;

lambda = 0.1;
lambda_l = 1e-12;
lambda_h = 1e+12;
lambda_s = lambda;
tune_p = 5;
nite = 10000;
pas = zeros(nite,4);
tol = 1e-6;

param(1,1) = a;
param(2,1) = b;
param(3,1) = c;
param(4,1) = d;

out = struct('alpha',0,'params',0,'total_iterations',0,'nparam',0,'SST',0,'SSR',0,'SSE',0,'R_square',0, 'SE_params',0,'covmat',0, 'final_lambda',0, 'MSE',0, 'R_square_adjusted',0, 'fcal',0, 'reg_DOF',0, 'fpvalue',0, 'errDOF',0, 'H0_f',0, 'tstat',0, 'tpvalues',0, 'H0_params',0, 'RMSE',0,'totDOF',0, 'paramerror',0, 'stderror',0);
out.nparam = 4;
delx = 0.02;
delp = 1e-6;
initx = 0.0;
inity = 0.0;
maxx = 1.98;
stat =1;
alpha1 = 0.0423286;
out.alpha = alpha1;
dof = 101-1-1;
out.totDOF = dof;
out.reg_DOF = 1;
out.errDOF = dof;

diffa = @(a,b,c,d,delx,maxx,delp) ((expy(a+delp,b,c,d,delx,maxx) - expy(a,b,c,d,delx,maxx))/delp);
diffb = @(a,b,c,d,delx,maxx,delp) ((expy(a,b+delp,c,d,delx,maxx) - expy(a,b,c,d,delx,maxx))/delp);
diffc = @(a,b,c,d,delx,maxx,delp) ((expy(a,b,c+delp,d,delx,maxx) - expy(a,b,c,d,delx,maxx))/delp);
diffd = @(a,b,c,d,delx,maxx,delp) ((expy(a,b,c,d+delp,delx,maxx) - expy(a,b,c,d,delx,maxx))/delp);

plot(x_data,y_actual,'o', 'LineWidth',2); hold on;

for w=1:nite
    if stat == 1
        jmat = [diffa(param(1,1),param(2,1),param(3,1),param(4,1),delx,maxx,delp) diffb(param(1,1),param(2,1),param(3,1),param(4,1),delx,maxx,delp) diffc(param(1,1),param(2,1),param(3,1),param(4,1),delx,maxx,delp) diffd(param(1,1),param(2,1),param(3,1),param(4,1),delx,maxx,delp) ];
        jtjm = jmat'*jmat;
        dy = y_actual - expy(param(1,1),param(2,1),param(3,1),param(4,1),delx,maxx);
%       dy(:,1) = y_actual - expy(param(1,1),param(2,1),param(3,1),param(4,1),param(5,1),delx,maxx) ;
        if lambda_s ~=0
            if w == 1, chia = sum(dy.^2); end
        else
            chia = sum(dy.^2);
        end
    end
    pas(w,:) = param(:,1);
    if lambda_s ~=0
        for i=1:length(jtjm), jtjm(i,i) = jtjm(i,i) + jtjm(i,i)*lambda; end
    else
        for i=1:length(jtjm), jtjm(i,i) = jtjm(i,i) + 0; end
    end
    
    ijtjm = jtjm^-1;
    dyn = y_actual - expy(param(1,1),param(2,1),param(3,1),param(4,1),delx,maxx);
    nparam = param + ijtjm * jmat'*dyn;
    dym = y_actual - expy(nparam(1,1),nparam(2,1),nparam(3,1),nparam(4,1),delx,maxx);
    chib = sum(dym.^2);
    if((abs(chia-chib)<tol) || w == nite)
        param = nparam;
        SSE = chib; SST = sum(y_actual.^2) - (sum(y_actual))^2/length(y_actual);
        SSEr = SSE/dof; RMSE = sqrt(SSEr);
        SSTr = SST/100;
        rsquare = 1 - SSE/SST;
        rsqadjust = 1 - (100/dof)*(1-rsquare);
        cov_mat = ijtjm * SSEr;
        param_err = zeros(4,2);
        param_err(:,1) = param - abs(tinv(alpha1/2,dof)) * sqrt(diag(cov_mat));
        param_err(:,2) = param + abs(tinv(alpha1/2,dof)) * sqrt(diag(cov_mat));
        out.paramerror = (abs(tinv(alpha1/2,dof))*sqrt(diag(cov_mat)));
        out.SE_params = param_err;
        disp(['param (a,b,c,d), ' 'param_low, ' 'param_high']);
        disp([param param_err]);
        disp(['Total iterations, ' 'SSE, ' 'RMSE, ' 'rsquare, ' 'rsqadjusted, ' 'lambda ']);
        disp([w SSE RMSE rsquare rsqadjust lambda]);
        out.params = param;
        out.stderror = sqrt(diag(cov_mat));
        out.SSE = SSE; out.SST = SST; out.covmat = cov_mat;
        out.SSR = out.SST - out.SSE;
%         out.SSRr = out.SSR/
        out.final_lambda = lambda;
        out.R_square = rsquare;
        out.MSE = SSEr;
        out.R_squate_adjusted = rsqadjust;
        out.fcal = (out.SSR*99)/(SSE);
        out.fpvalue = fpval(out.fcal,out.reg_DOF,out.errDOF);
        if out.fpvalue < alpha1
            out.H0_f = 1;
        else
            out.H0_f = 0;
        end
        out.tstat = param.*sqrt(diag(cov_mat)).^-1;
        out.tpvalues = zeros(length(out.tstat),1);
        for q=1:length(out.tstat)
            out.tpvalues(q) = tpval(out.tstat(q),out.errDOF);
            if out.tpvalues < alpha1
                out.H0_params(q) = 1;
            end
        end
        out.RMSE = RMSE;
        break  
    end
    
    if lambda_s ~=0
        if chib < chia
            if lambda/tune_p >=lambda_l 
                lambda = lambda/tune_p; 
            end
            param = nparam;
            chia = chib;
            stat = 1;
        else
            if lambda*tune_p <=lambda_h 
                lambda = lambda*tune_p; 
            end
            stat = 0;
        end
    else
        param = nparam;
    end
            
end
disp(out);

y_cal = expy(param(1,1),param(2,1),param(3,1),param(4,1),delx,maxx);
plot(x_data, y_cal,'LineWidth',2); hold off;
xlabel('X'); ylabel('Y = f(x)');
legend('data','NLS Fit');
gx = gca;
gx.LineWidth = 2;
gx.FontSize = 20;
% pasb = pas(1:w,:);


function pval = fpval(f, adof, bdof)
    if f < 1
       pval = fcdf(f,adof,bdof);
    else
        pval = fcdf(1/f,bdof,adof);
    end
end

function rpval = tpval(t, v)
rpval = betainc(v/(v+t^2),v/2,0.5);
end