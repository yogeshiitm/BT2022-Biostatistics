function out = ttest2class(samp1,samp2,alpha)
    out = struct('sm1','sm2',0,'sv1','sv2',0,'totdof',0,'pvaluef',0,'pvaluet','tcal',0,'fcal','nhf',0,'nht','stderr')
    alphastar = alpha/2;

    rn = @(mn,va,n)(mn+sqrt(va)*randn(n,1));
    samp1 = rn(mu1,vx1,n1); samp1 = rn(mu2,vx2,n2);

    out.sm1 = mean(samp1); out.sm2 = mean(samp2);
    out.sv1 = var(samp1); out.sv2 = var(samp2);
    n1 = length(samp1); n2 = length(samp2);
    dof1 = n1-1; dof2 = n2-1;

    out.Fcal = out.sv1/out.sv2;
    out.vratiolow = out.Fcal / finv(1-alpha/2,dof1,dof2);
    out.vratiohigh = out.Fcal / finv(alpha/2,dof1,dof2);
    disp([vratiolow vratiohigh])

    out.pvaluef = 2*fpvalue(out.Fcal,dof1,dof2);
    out.nhf = 0; %non-hypothesis
    if out.Fcal < finv(alpha/2,dof1,dof2) && out.Fcal > finv(1-alpha/2,dof1,dof2)
        out.nhf = 1
    end

    % ---------------------------------------------
    % output of the above ftest is fed to the ttest
    % ---------------------------------------------
    out.nht = 0; out.popmndifflow = 0; out.popmndiffhigh = 0;
    if out.nhf == 0
        out.totdof = dof1+dof2
        out.stderr = sqrt(1/n1+1/n2) * sqrt((dof1*out.sv1 + dof2*out.sv2)/(dof1+dof2));
        tcal = (out.sm1-out.sm2)/out.stderr; % t-stats
        if tcal < tinv(alpha/2,out.totdof) || tcal > tinv(1-alpha/2,out.totdof)
            out.nht = 1
        end
        out.popmndifflow = (out.sm1-out.sm2) - abs(tinv(alpha/2,out.totdof)) * out.stderr; 
        out.popmndiffhigh = (out.sm1-out.sm2) + abs(tinv(alpha/2,out.totdof)) * out.stderr;
        out.SE = sqrt((dof1*out.sv1 + dof2*out.sv2)/(dof1+dof2));
    else
        %welch formula
        out.totdof = (out.sv1/n1 + out.sv2/n2)^2/((out.sv1/n1)^2/dof1 + (out.sv2/n2)^2/dof2);
        out.stderr = sqrt(out.sv1/n1 + out.sv2/n2);
        tcal = (out.sm1 - out.sm2)/out.stderr;
        if tcal < tinv(alpha/2,out.totdof) || tcal > tinv(1-alpha/2,out.totdof)
            out.nht = 1
        end
        out.popmndifflow = (out.sm1-out.sm2) - abs(tinv(alpha/2,out.totdof)) * out.stderr; 
        out.popmndiffhigh = (out.sm1-out.sm2) + abs(tinv(alpha/2,out.totdof)) * out.stderr; 
        out.SE = sqrt((dof1*out.sv1 + dof2*out.sv2)/(dof1+dof2));
    end

end