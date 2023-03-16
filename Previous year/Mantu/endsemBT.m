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

Y = [-0.0422223; -0.150032; 0.0197163; 0.544772; 0.0383798;
    -0.220912; 0.529664; 0.0377839; 0.00556966; 0.267008;
    0.272636; 0.103871; 0.480956; 0.166219; 0.00671927;
    0.333737; 0.375978; 0.268347; 0.509515; 0.402574;
    0.196502; 0.326463; 0.370701; 0.274179; 0.74806;
    0.647391; 0.683095; 0.864904; 0.586789; 0.616522;
    0.342838; 0.531556; 1.01355; 0.864395; 0.939764;
    0.767735; 1.43641; 0.651621; 1.13034; 1.45427;
    1.22279; 0.868489; 1.3344; 1.29512; 1.18882;
    1.68621; 1.68198; 1.38978; 1.78794; 1.75947;
    1.62523; 1.58644; 1.77373; 1.63891; 1.52598;
    1.87966; 2.01781; 1.83167; 2.08887; 2.16504;
    2.2929; 2.19839; 2.23436; 2.36088; 2.40883;
    2.57397; 2.79777; 3.02241; 2.57582; 2.91087;
    2.82388; 2.74006; 2.9147; 2.78038; 2.90197;
    3.19668; 3.17151; 3.26475; 3.36249; 3.71174;
    3.60087; 3.28328; 3.90811; 3.53091; 3.72425;
    4.42906; 3.98547; 4.05935; 3.85023; 4.54126;
    4.58103; 4.20684; 4.52988; 4.55017; 4.95329;
    4.98308; 4.93088; 4.70114; 5.03429; 5.05525;]';

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
