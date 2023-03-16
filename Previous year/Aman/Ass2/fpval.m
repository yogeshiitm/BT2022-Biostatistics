function pval = fpval(f,adof,bdof)
if f<1 
    pval = fcdf(f,adof,bdof);
else 
    pval = fcdf(1/f,adof,bdof);
end
end