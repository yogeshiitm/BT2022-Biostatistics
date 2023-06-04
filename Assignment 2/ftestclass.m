function out = ftestclass(x,y,alpha)
out = struct('mean_x',0,'mean_y',0,'var_x',0,'var_y',0,'dof_x',0,'dof_y',0,'pvar_ratio_low',0,'pvar_ratio_high',0,'f_cal',0,'f_alphaby2',0,'f_1malphaby2',0,'ttest_result',0,'p_value',0,'alpha',0);
out.mean_x = mean(x);
out.mean_y = mean(y);
out.var_x = var(x);
out.var_y = var(y);
out.alpha = alpha;
out.dof_x = length(x)-1;
out.dof_y = length(y)-1;
out.f_cal = out.var_x/out.var_y;
out.f_alphaby2 = finv(alpha/2,out.dof_x,out.dof_y);
out.f_1malphaby2 = finv(1- alpha/2,out.dof_x,out.dof_y);
if out.f_cal >= out.f_alphaby2 && out.f_cal<= out.f_1malphaby2 
    out.test_result = 0;
else 
    out.test_result = 1;
end
out.pvar_ratio_low = out.f_cal/out.f_1malphaby2;
out.pvar_ratio_high = out.f_cal/out.f_alphaby2;
out.p_value = 2*fpval(out.f_cal,out.dof_x,out.dof_y);
end

