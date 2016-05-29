function ntau = reductor(tau)

if(isempty(tau))
    ntau = [];
    return
end

global t;
tau = convert_tau(tau);

ntau = [];

i = 2;
while (i <= length(tau)) 
    if( tau(i-1) == tau(i) )
        i = i + 2;     
        continue;
    end
    ntau = [ntau, tau(i-1)]; 
    i = i + 1;
end

if( (length(tau) > 1 && tau(end-1) ~= tau(end) )|| length(tau) == 1)
    ntau = [ntau, tau(end)];
end

ntau = t(ntau);

end