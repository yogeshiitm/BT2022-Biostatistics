clc;
mu1 = 2.4; vx1 = 1.3; n1 = 20; mu2 = 3.5; vx2 = 5.5; n2 = 30;
rn = @(mn,va,n)(mn+sqrt(va)*randn(n,1));
% samp1 = rn(mu1,vx1,n1); samp1 = rn(mu2,vx2,n2);
% z = (mu1-mu2)/sqrt(vx1/n1 + vx2/n2);

nsamp = 10000;
zdat = zeros(nsamp,1);
chi2dat = zeros(nsamp,1);
for i=1:nsamp:
    samp1 = rn(mu1,vx1,n1); samp1 = rn(mu2,vx2,n2);
    zdat(i,1) = (mean(samp1)-mean(samp2))/sqrt(vx1/n1 + vx2/n2);
    chi2dat(i,1) = (n1-1)*var(samp1)/vx1 + (n2-1)*var(samp2)/vx2;
end
hp = histogram(chi2dat); hold on;
gx = gca;
gx.Fontsize = 18;
disp(hp);


dof = (n1-1) + (n2-1)
chifun = @(ns,x) ((2^(-dof/2)/gamma(dof/2)) * x.^(dof/2-1) .* exp(-x/2));
pdp = zeros(length(hp.BinEdges),1);
for i=1:length(pdp)
    if i < length(hp.BinEdges)
        pdp(i,1) = integral(@(x) chifun(dof,x),hp.BinEdges(i),hp.BinEdges(i+1));
    else
        pdp(i,1) = integral(@(x) chifun(dof,x),hp.BinEdges(i),hp.BinEdges(i)+hp.BinWidth);
    end
end
plot(hp.BinEdges(1:length(hp.BinEdges))+hp.BinWidth/2,sum(hp.BinCounts) * pdp,'LineWidth',2); hold off;
xlabel('\chi^2'); ylabel('frequency');
% legend('simulation','total freq. P(\chi^2)')
gx = gca;
gx.LineWidth = 2;
gx.FontSize = 18;