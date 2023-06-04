function y = expy(b0,b1,b2,b3,delx,maxx)

x = -7.5:delx:maxx;
y = (1/sqrt(2*pi*b1))*exp(-(x-b0)^2/(2*b1)) + (1/sqrt(2*pi*b3))*exp(-(x-b2)^2/(2*b3));
y = y';

%x = 0:delx:maxx;
%y = a.*(x.^b) + c.*(x.^d);
%y = y';
% y = zeros(100);
% i = 1;
% for x = 0:delx:maxx
%     y(i) = a*(x^b) + c*(x^d);
% end

end