% to get p-value_fstat

function out = fpvalue(f,nu1,nu2)
if f<1
    out = fcdf(f,nu1,nu2);
else 
    out = fcdf(1/f,nu2,nu1);
end
end