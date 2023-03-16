clear all; clc; close all;
data = [0 -0.011031;
0.02 0.347413;
0.04 0.43137;
0.06 0.296814;
0.08 1.03356;
0.1 0.276411;
0.12 0.998118;
0.14 1.12047; 
0.16 0.936997;
0.18 1.00645;
0.2 1.19353;
0.22 1.19133;
0.24 1.34048;
0.26 1.54457;
0.28 1.65071;
0.3 1.47933;
0.32 1.40331;
0.34 2.19197;
0.36 1.70646;
0.38 1.91216;
0.4 1.99566;
0.42 2.11564;
0.44 1.9548;
0.46 2.53656;
0.48 2.3786;
0.5 2.22525;
0.52 2.51121;
0.54 3.05689;
0.56 2.80759;
0.58 3.10386;
0.6 3.05321;
0.62 3.08946;
0.64 3.10457;
0.66 3.40231;
0.68 3.79177;
0.7 3.62544;
0.72 3.83755;
0.74 4.3157;
0.76 4.27182;
0.78 4.27661;
0.8 4.57709;
0.82 4.95307;
0.84 4.95639;
0.86 5.3105;
0.88 5.49796;
0.9 5.26539;
0.92 5.92265;
0.94 5.78396;
0.96 5.99378;
0.98 6.31296;
1 6.55837;
1.02 6.74745;
1.04 7.21883;
1.06 7.13579;
1.08 7.63884;
1.1 8.00786;
1.12 7.56617;
1.14 8.3662;
1.16 8.37687;
1.18 8.82853;
1.2 9.40396;
1.22 9.36087 ;
1.24 9.66147;
1.26 9.96155;
1.28 10.3107;
1.3 10.7856;
1.32 11.7639;
1.34 11.3175;
1.36 12.2517;
1.38 11.933 ;
1.4 12.6016;

1.42 13.4068;
1.44 13.0968;
1.46 13.9253;
1.48 13.8235;
1.5 14.4955;
1.52 15.4084;
1.54 15.4155;
1.56 16.0224;
1.58 16.5648;
1.6 17.2988;
1.62 17.672;
1.64 17.9873;
1.66 18.5805;
1.68 19.0929;
1.7 19.5767;
1.72 20.2328;
1.74 20.7774;
1.76 21.1462;
1.78 21.9204;
1.8 22.5576;
1.82 23.0484;
1.84 24.179;
1.86  24.369;
1.88 25.1742;
1.9 25.38;
1.92 26.1895;
1.94 26.7331;
1.96 27.9174;
1.98 28.3237;
       ];
y_actual = data(:, 2);
% y_actual = [0.513597;
% 0.444702;
% 0.101033;
% 0.23074;
% 0.240235;
% 0.351521;
% 0.345147;
% 0.0360433;
% 0.454138;
% 0.545834;
% 0.682527;
% 0.915412;
% 0.389303;
% 0.559504;
% 0.625295;
% 0.779743;
% 0.458492;
% 0.528448;
% 0.840493;
% 1.09605;
% 1.01432;
% 0.61072;
% 0.791397;
% 1.11768;
% 1.01116;
% 1.10092;
% 1.49997;
% 1.48884;
% 1.52518;
% 1.42698;
% 1.58684;
% 1.4128;
% 1.57075;
% 1.19098;
% 1.808;
% 1.50351;
% 1.72429;
% 1.51278;
% 1.96256;
% 1.95162;
% 2.34817;
% 1.71445;
% 2.37431;
% 2.16397;
% 2.26084;
% 2.61233;
% 2.27132;
% 2.45402;
% 2.62295;
% 2.40884;
% 2.45413;
% 2.74415;
% 2.68368;
% 2.63129;
% 3.23552;
% 3.14161;
% 3.10089;
% 3.04571;
% 2.98881;
% 3.30729;
% 3.21773;
% 3.17791;
% 3.23994;
% 3.25633;
% 3.59765;
% 3.68591;
% 3.21041;
% 3.98989;
% 3.53165;
% 3.76457;
% 3.76218;
% 4.17122;
% 4.15175;
% 4.22582;
% 4.05787;
% 4.30493;
% 4.60249;
% 4.42136;
% 4.49223;
% 4.07416;
% 4.54295;
% 4.48325;
% 4.76369;
% 4.87073;
% 4.86064;
% 5.51813;
% 4.86203;
% 5.2641;
% 5.11465;
% 5.0534;
% 5.22581;
% 5.4706;
% 5.37968;
% 5.37265;
% 5.40196;
% 5.81053;
% 5.77221;
% 6.19109;
% 5.75444;
% 5.81315;];
x_data = [0; 
    0.02; 
    0.04; 
    0.06;
    0.08;
    0.1;
    0.12;
    0.14; 
    0.16;
    0.18;
    0.2;
    0.22;
    0.24;
    0.26;
    0.28;
    0.3;
    0.32;
    0.34; 
    0.36;
    0.38;
    0.4;
    0.42;
    0.44;
    0.46;
    0.48;
    0.5;
    0.52;
    0.54;
    0.56; 
    0.58;
    0.6;
    0.62;
    0.64; 
    0.66;
    0.68;
    0.7; 
    0.72; 
    0.74;
    0.76; 
    0.78;
    0.8;
    0.82; 
    0.84;
    0.86; 
    0.88;
    0.9;
    0.92;
    0.94;
    0.96;
    0.98;
    1; 
    1.02;
    1.04;
    1.06;
    1.08;
    1.1; 
    1.12;
    1.14; 
    1.16; 
    1.18;
    1.2; 
    1.22;
    1.24;
    1.26;
    1.28;
    1.3;
    1.32;
    1.34;
    1.36;
    1.38;
    1.4;
    1.42; 
    1.44;
    1.46;
    1.48;
    1.5;
    1.52;
    1.54;
    1.56;
    1.58;
    1.6;
    1.62;
    1.64;
    1.66; 
    1.68;
    1.7;
    1.72; 
    1.74;
    1.76;
    1.78;
    1.8;
    1.82; 
    1.84; 
    1.86; 
    1.88;
    1.9;
    1.92;
    1.94;
    1.96;
    1.98;];
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
alpha1 = 0.0230081;
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