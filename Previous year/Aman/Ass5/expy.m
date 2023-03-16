function y = expy(a,b,c,d,delx,maxx)

x = 0:delx:maxx;
y = a.*(x.^b) + c.*(x.^d);
y = y';
% y = zeros(100);
% i = 1;
% for x = 0:delx:maxx
%     y(i) = a*(x^b) + c*(x^d);
% end

end