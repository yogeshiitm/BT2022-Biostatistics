clc;
alpha = 0.472617;

X = [0; 0.02; 0.04; 0.06; 0.08;
    0.1; 0.12; 0.14; 0.16; 0.18;
    0.2; 0.22; 0.24; 0.26; 0.28;
    0.3; 0.32; 0.34; 0.36; 0.38;
    0.4; 0.42; 0.44; 0.46; 0.48;
    0.5; 0.52; 0.54; 0.56; 0.58;
    0.6; 0.62; 0.64; 0.66; 0.68;
    0.7; 0.72; 0.74; 0.76; 0.78;
    0.8; 0.82; 0.84; 0.86; 0.88;
    0.9; 0.92; 0.94; 0.96; 0.98;
    1; 1.02; 1.04; 1.06; 1.08;
    1.1; 1.12; 1.14; 1.16; 1.18;
    1.2; 1.22; 1.24; 1.26; 1.28;
    1.3; 1.32; 1.34; 1.36; 1.38;
    1.4; 1.42; 1.44; 1.46; 1.48;
    1.5; 1.52; 1.54; 1.56; 1.58;
    1.6; 1.62; 1.64; 1.66; 1.68;
    1.7; 1.72; 1.74; 1.76; 1.78;
    1.8; 1.82; 1.84; 1.86; 1.88;
    1.9; 1.92; 1.94; 1.96; 1.98;]';

Y = [0.071435;
0.997483;
0.947974;
1.16597;
1.69012;
1.61216;
1.66428;
2.19399;
2.10857;
2.39021;
2.18536;
2.55174;
2.3269;
2.16697;
2.60211;
2.63762;
2.72893;
3.14533;
2.88681;
2.88163;
3.48239;
3.12217;
3.08376;
3.00735;
3.73846;
3.0917;
3.48876;
3.52988;
4.13182;
4.0979;
4.09893;
3.96472;
3.75902;
3.83157;
4.26378;
4.50726;
4.6045;
4.66349;
4.67492;
5.12179;
5.32;
5.07479;
5.23086;
5.30943;
5.43473;
5.62277;
5.5708;
5.82105;
5.41735;
5.9983;
6.29733;
6.11881;
5.99776;
6.44528;
6.52003;
6.46342;
7.14347;
7.02646;
7.20932;
7.28088;
7.69599;
7.39808;
7.43941;
7.5197;
8.11954;
8.34869;
8.04049;
8.5362;
8.78495;
8.46521;
8.43894;
8.89222;
9.17473;
9.39061;
9.30325;
9.75703;
9.96329;
9.84921;
9.8942;
10.1993;
9.94244;
10.8576;
10.5393;
10.9754;
10.3659;
11.2202;
11.1202;
11.3152;
11.7827;
11.6654;
11.9004;
12.294;
12.0885;
12.5035;
12.3159;
12.3542;
12.5765;
13.011;
13.6356;
13.3892;]';

fn = @(X,a,b,c,d)(a*(X.^b) + c*(X.^d));
delp = 1e-6;
dfa = @(x,a,b,c,d,delp) ((fn(x,a+delp,b,c,d)-fn(x,a,b,c,d))/delp);
dfb = @(x,a,b,c,d,delp) ((fn(x,a,b+delp,c,d)-fn(x,a,b,c,d))/delp);
dfc = @(x,a,b,c,d,delp) ((fn(x,a,b,c+delp,d)-fn(x,a,b,c,d))/delp);
dfd = @(x,a,b,c,d,delp) ((fn(x,a,b,c,d+delp)-fn(x,a,b,c,d))/delp);
a=1;b=1;c=1;d=1;

nump =4;
error_dof = length(X)-nump;
reg_dof = nump-1;
lambda = 0.1;
tuning_param = 5;
stat =1;
lambda_l = 1e-12;
lambda_h = 1e+12;
param = zeros(4,1);
param(:,1) = [1,1,1,1];
del_exit = 1e-6;
del_exiti = 10*del_exit;
covbeta =zeros(nump,nump);
SST = sum(Y.^2);
SSE = 0;
SSR = 0;
numit = 0;
chi_old = 0;
chi_new = 0;
while del_exiti>del_exit 
    if stat ==1
        dely = Y - fn(X,param(1,1),param(2,1),param(3,1),param(4,1));
        jmat = [dfa(X,param(1,1),param(2,1),param(3,1),param(4,1),delp);dfb(X,param(1,1),param(2,1),param(3,1),param(4,1),delp);dfc(X,param(1,1),param(2,1),param(3,1),param(4,1),delp);dfd(X,param(1,1),param(2,1),param(3,1),param(4,1),delp);]';
        chi_old = sum(dely.^2);
    end
    jtj = jmat'*jmat;
    for i = 1:4
        jtj(i,i) = jtj(i,i) + lambda*jtj(i,i);
    end
    param = param + (jtj)^-1*jmat'*dely';
    delyn = Y - fn(X,param(1,1),param(2,1),param(3,1),param(4,1));
    chi_new = sum(delyn.^2);
    del_exiti = abs(chi_old - chi_new);
    
    if del_exiti <= del_exit
        ycap = fn(X,param(1,1),param(2,1),param(3,1),param(4,1));
        SSE = sum((Y-ycap).^2);
        SSR = SST - SSE;
        sigmacap = SSE/error_dof;
        covbeta = sigmacap * (jtj)^-1;
    end
    numit = numit+1;
    if chi_old > chi_new 
        if lambda/tuning_param > lambda_l 
            lambda = lambda/tuning_param;
        end
        chi_old = chi_new;
    else
        if lambda*tuning_param < lambda_h 
            lambda = lambda*tuning_param; 
        end  
    end
    
end
Fcal= (SSR/reg_dof)/sigmacap;
ftabl = finv(alpha/2,reg_dof,error_dof);
ftabh = finv(1-alpha/2,reg_dof,error_dof);
ftest_status = 0;
if Fcal < ftabl || Fcal>ftabh
   ftest_status = 1;
end
paramr = zeros(nump,4);
paramr(:,1) = param;
paramr(:,2) = param - abs(tinv(alpha/2,error_dof)*sqrt(diag(covbeta)));
paramr(:,3) = param + abs(tinv(alpha/2,error_dof)*sqrt(diag(covbeta)));
paramr(:,4) = param .*sqrt(diag(covbeta)).^-1;
disp(paramr);
disp(numit);
disp(SSE);
plot(X,Y,'o',X,ycap);
