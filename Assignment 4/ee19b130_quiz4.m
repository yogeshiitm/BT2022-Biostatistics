% (i, j) th element of X transpose X matrix (4 marks)
% (i, j) th element of the inverse of X transpose X matrix (4 marks)
% (i, j) th element of the covariance matrix (4 marks)
% SSR (4 marks)
% lower bound of the kth parameter (4 marks)



alpha=0.026395;
i = 3; j = 4; k = 5;
data = [
        0.38513,  -0.0451074,  0.11554,   0.458992,   16.4619;
        0.245176, -0.247961,  -0.0122003, 0.0676066,  13.7341;
        -0.163565, 0.618577,   0.495499,  0.0363067,  10.5366;
        0.329542, -0.200871,   0.580169,  0.0716867   15.3956;
        0.490791,  0.640159,   0.972579,  0.195161,   22.7893;
        0.106259,  0.0887101,  0.440985,  0.656301,   14.738;
        0.928434,  0.443462,   0.420744,  1.11773,    26.2881;
        0.59515,   0.649857,   0.739094,  0.983503,   27.9949;
        0.879524,  0.748725,   1.04671,   0.697922,   37.4783;
        0.655083,  0.716055,   0.770967,  0.985618,   28.9636;
        0.65539,   1.05203,    1.22719,   1.13112,    49.1742;
        0.862667,  1.28807,    1.23114,   1.22028,    66.7467;
        1.06552,   1.09718,    1.07983,   1.57088,    66.3874;
        1.91317,   1.71819,    1.13613,   1.63437,    153.627;
        1.70933,   1.17779,    1.38436,   1.30986,    99.8986;
        1.87532,   1.20442,    1.59367,   2.15478,    137.353;
        2.06622,   1.4297,     1.52059,   1.87295,    158.753;
        2.02372    1.68655,    1.08766,   2.06816,    161.653;
        1.81768,   1.67642,    1.86531,   1.98887,    195.604;
        2.56383,   1.67992,    2.02761,   2.11539,    264.341;
        2.45134,   2.03848,    2.67518,   2.52079,    400.608;
        2.39897,   2.09074,    2.22108,   1.34262,    307.33;
        2.01873,   2.20521,    2.00542,   2.3184,     315.891; 
        2.79086,   2.17212,    2.34294,   1.90466,    396.665;
        2.23725,   2.65445,    2.86392,   2.17491,    529.167;
        2.01776,   2.73157,    2.0243,    2.68237,    438.251;
        2.70054,   3.03042,    2.40618,   2.18965,    644.921;
        2.75076,   3.01452,    2.31027,   2.70408,    663.356;
        2.83005,   2.99804,    2.421,     2.428,      670.407;
        3.09601,   3.24506,    2.60181,   2.48158,    835.191;
      ];

y = data(:,5);
xmat = zeros(size(data,1),5);
nump = 5;
n = size(data,1); p = size(data,2);

xmat(:, 1) = ones(size(data, 1), 1);
xmat(:, 2) = data(:, 1);
xmat(:, 3) = data(:, 1) .* (data(:, 2) .^ 2);
xmat(:, 4) = (data(:, 2) .^ 2) .* data(:, 3);
xmat(:, 5) = data(:, 1) .* data(:, 3) .* data(:, 4);
ycap=xmat*betacap;
SSE=sum((y-ycap).^2);
SST=sum(y.^2)-(sum(y)^2/n);
SSR=SST-SSE;
dofreg=p-1;
doferr=n-p;
fstat=(SSR/dofreg)/(SSE/doferr);
ftest=0;
if fstat<finv(alpha/2,dofreg,doferr)||fstat>finv(1-alpha/2,dofreg,doferr)
    ftest=1;
end

xxt = (xmat'*xmat);
disp("X_transposeX");
display(xxt(i, j));

xxtinv = xxt^-1;
disp("X_transposeX_inverse");
display(xxtinv(i, j));

covbeta=(xxtinv)*(SSE/doferr);
disp("covariance_matrix_element");
display(covbeta(i, j));

betarange=zeros(5,3);
betarange(:,1)=betacap;
betarange(:,2)=betacap-(abs(tinv(alpha/2,doferr))*sqrt(diag(covbeta)));
betarange(:,3)=betacap+(abs(tinv(alpha/2,doferr))*sqrt(diag(covbeta)));
rsquare=(SSR/SST);
disp("SSR");
disp(SSR);

disp("lower bound");
disp(betarange(k, 2));