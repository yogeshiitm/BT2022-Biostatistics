clc;

n = 20;
dofreg = n-5;
doferr = n-1-dofreg;
alp = 0.19780502;

x1 = [0,0.13491247,0.26986431,0.29061341,0.33504098,0.57540859,0.98313118,0.35968113,0.55760194,1.0252814,1.740219,0.64044314,0.72755337,1.663417,1.30945,1.0266112,0.8931472,2.6805007,1.2274444,3.3649638];
x2 = [0,0.12342091,0.1433792,0.22207768,0.45029395,0.87906531,0.80143292,1.0977324,1.4543997,1.4143416,1.379746,0.68758816,2.0773475,1.1504117,0.78812646,2.2268013,1.6008666,1.2233095,2.1411834,1.4292199];
x3 = [0,0.13161493,0.38428409,0.52762689,0.67219739,0.51457323,0.85679119,1.3180789,0.81812013,0.68854747,1.6411981,0.80273889,2.3867028,1.4632464,1.8209,1.4691426,3.0952784,1.1966672,0.99238379,2.2319319];
x4 = [0,0.19634496,0.27510498,0.28145876,0.42921741,0.3416027,0.61678246,0.43472909,0.76562138,1.5630981,0.96133112,0.78703959,2.0895904,1.4421708,1.9138174,1.0397208,2.7783461,1.9922794,3.0293385,3.4204105];
y = [-2.5132291,1.4712619,0.054413741,0.096678082,1.1957168,1.0890368,4.1179459,7.2546585,8.2142641,35.012919,94.96589,4.0371806,375.6148,83.091997,74.316646,96.256412,605.97227,202.32556,344.08735,1288.648];

x_mat = zeros(n,5);
for i=1:n
    x_mat(i,1) = 1;
    x_mat(i,2) = x1(i)*x2(i)*x1(i)*x3(i)*x2(i);
    x_mat(i,3) = x2(i)*x1(i)*x1(i)*x4(i)*x4(i);
    x_mat(i,4) = x3(i)*x3(i)*x2(i)*x1(i)*x3(i);
    x_mat(i,5) = x4(i)*x2(i)*x4(i)*x2(i)*x3(i);
end

betacap = ((x_mat'*x_mat)^-1)*(x_mat')*(y');
disp(betacap);

ycap = betacap(1) + betacap(2)*(x1.*x2.*x1.*x3.*x2) + betacap(3)*(x2.*x1.*x1.*x4.*x4) + betacap(4)*(x3.*x3.*x2.*x1.*x3) + betacap(5)*(x4.*x2.*x4.*x2.*x3);

SSE = sum((y-ycap).^2);
SST = sum(y.^2)-sum(y)^2/n;
SSR = SST-SSE;
Rsquare = SSR/SST;

disp(SSR);
disp(SSE);
disp(Rsquare);

covbeta = (SSE/doferr) * ((x_mat'*x_mat)^-1);
betarange = zeros(5,2);
betarange(:,1) = betacap - abs(tinv(alp/2,doferr))*sqrt(diag(covbeta));
betarange(:,2) = betacap + abs(tinv(alp/2,doferr))*sqrt(diag(covbeta));
% pop range of b3disp(betarange);

disp(betarange);