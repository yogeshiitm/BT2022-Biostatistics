% (i, j) th element of the final JTJ (4 marks)
% (i, j) th element of inverse of the final JTJ (4 marks)
% (i, j) th element of final covariance matrix (4 marks)
% SSR (4 marks)
% lower bound of the kth parameter at given alpha (4 marks)


alpha=0.0381698; % change this
i=1; j=3;
k=2;

fx=@(x,beta0,beta1,beta2,beta3) 1/sqrt(2*pi*beta1) .* exp(-(x-beta0).^2 ./ (2*beta1)) + 1/sqrt(2*pi*beta3) .* exp(-(x-beta2).^2./(2*beta3));
delp=1.0e-03;delexit=1.0e-06;
dfb0=@(x,beta0,beta1,beta2,beta3,delp)((fx(x,beta0+delp,beta1,beta2,beta3)-fx(x,beta0,beta1,beta2,beta3))/delp);
dfb1=@(x,beta0,beta1,beta2,beta3,delp)((fx(x,beta0,beta1+delp,beta2,beta3)-fx(x,beta0,beta1,beta2,beta3))/delp);
dfb2=@(x,beta0,beta1,beta2,beta3,delp)((fx(x,beta0,beta1,beta2+delp,beta3)-fx(x,beta0,beta1,beta2,beta3))/delp);
dfb3=@(x,beta0,beta1,beta2,beta3,delp)((fx(x,beta0,beta1,beta2,beta3+delp)-fx(x,beta0,beta1,beta2,beta3))/delp);

data = [
-7.5        0.00514273;
-7.4       -0.0805684;
-7.3       -0.0227033; 
-7.2        0.0875876; 
-7.1        -0.0238463;
-7          0.12389;
-6.9        0.0532888 ;
-6.8        0.0055907;
-6.7        -0.0630127; 
-6.6       0.00454379 ;
-6.5       -0.0649719 ;
-6.4       0.0273066;
-6.3       0.0677444 ;
-6.2       0.0240408 ;
-6.1        0.136756 ;
-6         -0.0300467;
-5.9       0.0316324 ;
-5.8       -0.0659772 ;
-5.7        0.0261364 ;
-5.6        0.115335 ;
-5.5       -0.0711048 ;
-5.4        0.0575433;
-5.3        0.105594 ;
-5.2       -0.145818 ;
-5.1       0.117756 ;
-5         0.0912534 ;
-4.9       0.0335363 ;
-4.8       0.119079 ;
-4.7       0.0246726 ;
-4.6       0.0745289;
-4.5       0.0339929 ;
-4.4       0.231915;
-4.3       0.178881;
-4.2       0.100783 ;
-4.1       0.285768;
-4         0.182698 ;
-3.9       0.268719;
-3.8       0.135443;
-3.7       0.152749;
-3.6       0.308215;
-3.5       0.339602;
-3.4       0.375143;
-3.3       0.219094;
-3.2       0.272373;
-3.1       0.393161;
-3         0.291199;
-2.9       0.38874;
-2.8       0.435431;
-2.7       0.189061;
-2.6       0.491702;
-2.5       0.373606;
-2.4       0.252829;
-2.3       0.0986648;
-2.2       0.183189;
-2.1       0.293243;
-2         0.36498;
-1.9       0.092462;
-1.8       0.125312;
-1.7       0.314355;
-1.6       0.0750955;
-1.5       0.318873;
-1.4       0.0686819;
-1.3       0.313377;
-1.2       0.1531;
-1.1       0.0236826;
-1         0.140258;
-0.9       0.112073;
-0.8       0.0172625;
-0.7       0.109762;
-0.6       0.121759;
-0.5       0.249383;
-0.4       5.84161e-05;
-0.3      -0.088015;
-0.2       0.0465801;
-0.1      -0.11824;
0          0.0235062;
0.1       -0.00243728;
0.2       -0.101308;
0.3        0.0635021;
0.4        0.267194;
0.5        0.110935;
0.6       -0.0785645;
0.7        0.0624523;
0.8       -0.00182678;
0.9        0.0657909;
1          0.000271301;
1.1       -0.0146243;
1.2        0.0448422;
1.3        0.0936877;
1.4        0.139016;
1.5        0.165638;
1.6        0.129036;
1.7        0.233862;
1.8        0.311365;
1.9        0.1859;
2          0.159133;
2.1        0.124699;
2.2        0.254344;
2.3        0.312791;
2.4       0.388921;
2.5       0.372504;
2.6       0.327485;
2.7       0.506532;
2.8       0.407463;
2.9       0.453769;
3         0.337422;
3.1       0.418613;
3.2       0.432994;
3.3       0.361679;
3.4       0.328754;
3.5       0.345599;
3.6       0.432702;
3.7       0.209426;
3.8       0.364166;
3.9       0.22704;
4         0.273472;
4.1       0.167753;
4.2       0.168897;
4.3       0.101279;
4.4       0.123378;
4.5       0.150164;
4.6       0.092066;
4.7       0.0312178;
4.8       0.183316;
4.9      -0.00493372;
5         0.104367;
5.1      -0.00147025;
5.2       0.0514146;
5.3      -0.112059;
5.4       0.0435685;
5.5       0.105306;
5.6       0.0320342;
5.7      -0.00255603;
5.8       0.0474863;
5.9       0.0263559;
6         0.214464;
6.1       0.00371548;
6.2       0.0797312;
6.3      -0.0411554;
6.4      -0.0513176;
6.5       0.012949;
6.6      -0.214458;
6.7      -0.109551;
6.8       0.0709454;
6.9       0.0392604;
7         0.0131888;
7.1       0.116578 ;
7.2       0.0581153 ;
7.3      -0.0957359 ;
7.4      -0.211039;
];


xt = data(:, 1);
yt = data(:, 2);

nump=4; n=length(yt);
errdof=n-nump;
param=zeros(4,1);
param(:,1)=[-1.1, 1.1, 4.1, 1.1];
del_exit=10*delexit;
covbeta=zeros(nump,nump);
numit=0;
SST=sum(yt.^2)-(sum(yt)^2/n);
Fcal=0;degreg=nump-1;
while(del_exit>delexit)
    %if stat==1
    dely=yt-fx(xt,param(1,1),param(2,1),param(3,1),param(4,1));
    jmat=[dfb0(xt,param(1,1),param(2,1),param(3,1),param(4,1),delp) dfb1(xt,param(1,1),param(2,1),param(3,1),param(4,1),delp) dfb2(xt,param(1,1),param(2,1),param(3,1),param(4,1),delp) dfb3(xt,param(1,1),param(2,1),param(3,1),param(4,1),delp)];
    chi_old=sum(dely.^2);
    jtj=jmat'*jmat;
    %end
    jtjinv = (jtj)^-1;
    param=param+ jtjinv*jmat'*dely;
    delyn=yt-fx(xt,param(1,1),param(2,1),param(3,1),param(4,1));
    chi_new=sum(delyn.^2);
    del_exit=abs(chi_old-chi_new);
    if del_exit<=delexit
        ycap=fx(xt,param(1,1),param(2,1),param(3,1),param(4,1));
        SSE=sum((yt-ycap).^2);
        SSR=SST-SSE;
        sigmacap=SSE/errdof;
        covbeta=sigmacap*(jtjinv);
    end
    numit=numit+1;
end


paramrange=zeros(4,3);
paramrange(:,1)=param;
paramrange(:,2)=param-abs(tinv(alpha/2,errdof))*sqrt(diag(covbeta));
paramrange(:,3)=param+abs(tinv(alpha/2,errdof))*sqrt(diag(covbeta));
lower_bound = paramrange(k+1,2);
%this is newton's algo, takes lot of iterations, this is done when
%parameters are less than like 8 or smthng, if given 20 or smthng it takes
%lot of iterations


disp(jtj(i,j))
disp(jtjinv(i,j))
disp(covbeta(i,j))
disp(SSR)
disp(lower_bound)