clc;

mu1 = 2.4; vx1 = 1.3; n1 = 20; mu2 = 3.5; vx2 = 5.5; n2 = 30;
alpha = 0.023;
rn = @(mn,va,n)(mn+sqrt(va)*randn(n,1));
samp1 = rn(mu1,vx1,n1); samp1 = rn(mu2,vx2,n2);
m1 = mean(samp1); m2 = mean(samp2);
s1sq = var(samp1); s2sq = var(samp2);
dof1 = n1-1; dof2 = n2-1;

% falpha/2 <= (s1sq/s2sq) (sigma22/ sigma12) <= f1-alpha/2
% falpha/2 / fcal <= (s1sq/s2sq) (sigma22/ sigma12) <= f1-alpha/2 / fcal
Fcal = s1sq/s2sq; % f-stats
vratiolow = Fcal / finv(1-alpha/2,dof1,dof2);
vratiohigh = Fcal / finv(alpha/2,dof1,dof2);
disp([vratiolow vratiohigh])
pvaluef = 2*fpvalue(Fcal,dof1,dof2);
nhf = 0; %non-hypothesis
if Fcal < finv(alpha/2,dof1,dof2) && Fcal > finv(1-alpha/2,dof1,dof2)
    nhf = 1
end
if nhf == 0
    totdof = dof1+dof2
    stderr = sqrt((dof1*s1sq + dof2*s2sq)/(dof1+dof2));
    tcal = (m1-m2)/stderr; % t-stats
    if tcal < tinv(alpha/2,totdof) || tinv(1-alpha/2,totdof)
        nht = 1
    end
else
    totdof = (s1sq/n1 + s2sq/n2)^2/((s1sq/n1)^2/dof1 + (s2sq/n2)^2/dof2);
    stderr = sqrt(s1sq/n1 + s2sq/n2);
    tcal = (m1 - m2)/stderr;
    if tcal < tinv(alpha/2,totdof) || tcal > tinv(1-alpha/2,totdof)
        nht = 1
    end
end
disp([nhf nht])

%-----------------------------------------------------------------------------------
% METHOD-1 pvalue by vartest
[h,p,ci,stats] = vartest2(samp1,samp2,'Alpha',alpha);
disp([h p]);
disp('matlab')
disp([pvaluef p]);
disp(ci);
disp(stats);
disp([Fcal nhf]);


% METHOD-2 pvalue given by numerical integration
fdist = @(dof1,dof2,f) ((gamma((dof1+dof1)/2) / (gamma(dof1/2)*gamma(..............??? )) ))
if Fcal > 1
    cfg = integral(@(x) fdist(dof1,dof2,x),Fcal,10000);
else
    cfg = integral(@(x) fdist(dof1,dof2,x),0,Fcal);
end
pvaluefi = 2*cfg;
disp('numerical integration')
disp(2*cfg)


Fv = 0:0.01:100;
pf = fdist(dof1,dof2,Fv);
plot(Fv,pf,'LineWidth',2);
xlabel('F'); ylabel('P(F)');
gx = gc;
gx.FontSize = 18;

%-----------------------------------------------------------------------------------
% METHOD-1 ttest2
nht = 0; popmndifflow = 0; popmndiffhigh = 0;
if nhf == 0
    totdof = dof1+dof2
    stderr = sqrt(1/n1+1/n2) * sqrt((dof1*s1sq + dof2*s2sq)/(dof1+dof2));
    tcal = (m1-m2)/stderr; % t-stats
    if tcal < tinv(alpha/2,totdof) || tcal > tinv(1-alpha/2,totdof)
        nht = 1
    end
    popmndifflow = (m1-m2) - abs(tinv(alpha/2,totdof)) * stderr; 
    popmndiffhigh = (m1-m2) + abs(tinv(alpha/2,totdof)) * stderr;
    SE = sqrt((dof1*s1sq + dof2*s2sq)/(dof1+dof2));
else
    %welch formula
    totdof = (s1sq/n1 + s2sq/n2)^2/((s1sq/n1)^2/dof1 + (s2sq/n2)^2/dof2);
    stderr = sqrt(s1sq/n1 + s2sq/n2);
    tcal = (m1 - m2)/stderr;
    if tcal < tinv(alpha/2,totdof) || tcal > tinv(1-alpha/2,totdof)
        nht = 1
    end
    popmndifflow = (m1-m2) - abs(tinv(alpha/2,totdof)) * stderr; 
    popmndiffhigh = (m1-m2) + abs(tinv(alpha/2,totdof)) * stderr; 
    SE = sqrt((dof1*s1sq + dof2*s2sq)/(dof1+dof2));

end
disp([nhf nht])
disp('ttest')
disp(tcal);
disp(totdof);
disp(SE);
disp([popmndifflow popmndiffhigh]);


% METHOD-2 ttest2
if nhf ==0
    [ht,pt,cit,statst] = ttest2(samp1,samp2,'Alpha',alpha,'Vartype','equal');
else
    [ht,pt,cit,statst] = ttest2(samp1,samp2,'Alpha',alpha,'Vartype','unequal');
disp('matlab')
disp(pt);
disp(cit);
disp(statst);

% P-VALUE OF THE TTEST
stufun = @(dof,x) ( (gamma((dof+1)/2)/(sqrt(pi*dof) * gamma(dof/2))) * (1+x.^2/dof).^(-(dof+1)/2));
cfg = integral(@(x) stufun(totdof,x),0,tcal);
disp(1-2*abs(cfg));


% METHOD-3 ttest2class

mu1 = 14.4; vx1 = 1.3; n1 = 20; mu2 = 3.5; vx2 = 5.5; n2 = 30;
alpha = 0.023; fwer = 0.3
rn = @(mn,va,n)(mn+sqrt(va)*randn(n,1));
samp1 = rn(mu1,vx1,n1); samp1 = rn(mu2,vx2,n2);
out = ttest2class(samp1,samp2,alpha);
outm = ttest2classmat(samp1,samp2,alpha); % matlab
disp('class code')
disp(out)
disp('matlab')
disp(outm)
%-----------------------------------------------------------------------------------
