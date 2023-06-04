function out = ttestclass(x,y,alpha)
out = struct('mean_x',0,'mean_y',0,'var_x',0,'var_y',0,'dof_x',0,'dof_y',0,'pvar_ratio_low',0,'pvar_ratio_high',0,'f_cal',0,'f_alphaby2',0,'f_1malphaby2',0,'ftest_result',0,'ttest_result',0,'fp_value',0,'alpha',0,'tab_t_value',0,'tp_value',0,'t_cal',0,'tdof',0);
out.mean_x = mean(x);
out.mean_y = mean(y);
out.var_x = var(x);
out.var_y = var(y);
out.alpha = alpha;
out.dof_x = length(x)-1;
out.dof_y = length(y)-1;

fts = ftestclass(x,y,alpha);
if fts.test_result == 0
    out.tdof = out.dof_x + out.dof_y;
    out.t_cal = (out.mean_x - out.mean_y)/((sqrt(1/length(x) + 1/length(y))* sqrt((out.dof_x*out.var_x + out.dof_y*out.var_y)/out.tdof)));
    out.tab_t_value =abs( tinv(alpha/2,out.tdof));
    if out.t_cal >  -out.tab_t_value && out.t_cal < out.tab_t_value 
        out.ttest_result  = 0;
    else 
        out.ttest_result =1;
    end
else
    out.tdof = (out.var_x/length(x) + out.var_y/length(y))^2 /((out.var_x/length(x))^2/out.dof_x + (out.var_y/length(y))^2/out.dof_y);
    out.t_cal = (out.mean_x - out.mean_y)/sqrt(out.var_x/length(x) + out.var_y/length(y));
    out.tab_t_value =abs( tinv(alpha/2,out.tdof));
    if out.t_cal >  -out.tab_t_value && out.t_cal < out.tab_t_value 
        out.ttest_result  = 0;
    else 
        out.ttest_result =1;
    end
end

out.f_cal = fts.f_cal;
out.f_alphaby2 = fts.f_alphaby2;
out.f_1malphaby2 = fts.f_1malphaby2;
out.ftest_result = fts.test_result;
out.pvar_ratio_low = fts.pvar_ratio_low;
out.pvar_ratio_high = fts.pvar_ratio_high;
out.fpvalue = fts.p_value;
out.tp_value =2* tpval(out.t_cal,out.tdof);
end